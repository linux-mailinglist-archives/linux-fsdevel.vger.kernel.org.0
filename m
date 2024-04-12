Return-Path: <linux-fsdevel+bounces-16825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077568A34C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C3228176A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911E14D703;
	Fri, 12 Apr 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6yV/RKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5014D2B7;
	Fri, 12 Apr 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943121; cv=fail; b=W//qZ9TCuTRfv8ynUyyWhQVPRb3yUK0CDAy6CB8m3nGSPABy24ZTSmFYa2BCeu3gdmhrOSVLeD6aSEciErISErsK56MW1mlH0cOQb2NwgKWODOqmQ4/Ot0DyGGz/i7fmPRc6BmlTdShil4nEcsew5tP5DPyLwF0u72LKJ7NPfrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943121; c=relaxed/simple;
	bh=kaIfliKW42JLxAO5JGlVr1qUHhY/+3QRJkckijBie0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axupfyYZBAVFwOLFQro8ml653c+YHEHv6vr0u1unA9ZM1xDoD8sNNw9U7hg/PnShVVG8gA9g8xripqe9WrUrG9pnh4olrDtkWUUxSYrNRjmE0l8MVlDPSZNqTP4rG2KREwDJCRp8tOmnBi/Y9hI7DmElWFZL0X6IVQmzP4IS5jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6yV/RKb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943120; x=1744479120;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kaIfliKW42JLxAO5JGlVr1qUHhY/+3QRJkckijBie0Y=;
  b=b6yV/RKbpnxKyCFWjLAgVFoKAySUMwLhCD80enXGNL/qGfRXdoOW0LwM
   ubi7vc/v66OmdEWMwKOlf19Df/G6wBdbRzUDM5GxwFUS+500DevQEoAYb
   Cc0bDOAyKVTpIuzF8mS18BQs+PPHM2u/N2TWs0Z5sXqWKVnbifcQUn8EF
   poYRYrQeU5OTilhTtjamfyGQYPtGoZNZm4LEoe9Qh2djF+8UrhFH9q2IK
   tFsTpShafCW6W752b5Ra2LcfuFUVAFseNfFxT0HVJ+egS4LDJ25DdE8kC
   KVgbiLmGilFQDc+65vUKcOOngZT6svqlt00NHqsip9VIsZNzRIL4luRkM
   g==;
X-CSE-ConnectionGUID: bB4kqVuPTsa49iBf5Fk6Iw==
X-CSE-MsgGUID: df7bx5pZTxmpvU0PNXvmdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="33800557"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="33800557"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:31:59 -0700
X-CSE-ConnectionGUID: rOT8EzOgQEiDBP485xWx9Q==
X-CSE-MsgGUID: 9fUGpOfxRuKRbZ2EgA9+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25939772"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 10:31:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 10:31:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 10:31:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:31:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMDCpQisHhgrGOgvBZLKQRH2PL+1yqp11gZh5Uc5RJEq5iKn+Aeionp7SGwg182z0tRwChV5XV4q87PqtTV4v0T19296ETCdx9dwPWs+AqNwXGJKumIzUcnp0oyoFY42z4N7Tms3O1srB1kOy8GV+3i2HdXpoGizUcyoVMBI3XogbvuQCwGjClCfI0VdxEeXu5lT4qzyZCcBcgQsxy2NetfpOT/i+eA+gKAjdlBBqAax3nADm3ezNcC6JSgHFYlcYaTR/S2I1QEQDeNu4sypHYkQ4yLYnwYA6HEzY+j25aCXA6pfzs6U1CL02uvR9Er+j+pCfynABhaLOjXZYf6tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ8iBF2gHemaTcdvImkn5jGkvrBsnNYKJm4vhoNeZlE=;
 b=aa2rkJCdwUbxwgKW63h1CoLQhCj4wFzCSCSfng50a3y/5fRd06gobOf9lAASbRMYg0gMDUR7HeSMwCN5Fx+nyPFq1/c9iqos/JzJGwuUH5zX/2izOk57GVmB+z45BjSKr4OKj30d27JoU185p2XCaSEOwP53AHn9gJ+rY0y96cAuSTDbE+BwnspFI4VzKyovD96EoxKNWVLgh+zy5MD7a2D7KVniFOzN/HcUhODRZ17xkL7z99J7sjYu8X6LkrSjIYUIVz0/ycOi77YE7KaZspfVEhO09mvMChEAwbA1GUJq4Pntr/SzB4YMuHpbu0h1YakmuGA7dzqraZGHEOFPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 17:31:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 17:31:55 +0000
Date: Fri, 12 Apr 2024 10:31:52 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jan Kara <jack@suse.cz>, Alistair Popple <apopple@nvidia.com>
CC: <linux-mm@kvack.org>, <david@fromorbit.com>, <dan.j.williams@intel.com>,
	<jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <willy@infradead.org>,
	<jgg@nvidia.com>, <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<jglisse@redhat.com>
Subject: Re: [RFC 04/10] fs/dax: Don't track page mapping/index
Message-ID: <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
 <20240412152208.m25mjo3xjfyawcaj@quack3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412152208.m25mjo3xjfyawcaj@quack3>
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 54903b96-ce05-4975-a848-08dc5b167306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtVlrjOfj/f/17eKp8JgsESk6EbwwLB1InUeys9u6nkhogPxxA0tIwTOIqp7ncKMSUE73aANU6RAbzgK5bBw5nBCXcnoeperGbX2yTgFYH+061kKLh4c3eTL1cgoJt4W2NCyIMPVgWZHn3ClxjTsrFFSSqzfmwJ/0E0LD/vjhN/RbfdqU4LX9dVZl7E+jb5KIfkrCwFUxquQw1+YUa0EnaG4ycGIS5MWw0yhleQkTPsNc9LVPFTu/goZZxVCFrPJnF7FYnvF6NP6ys2sZsQvtNWfXQa3uoKfLQcTVRZF8FAXgm5HTFYIzFNvIno/PyHY5LPZLnCB9DtuZqPagN9ZXTXKypNJTFjlCTL7EMUlC8dbgg9p4KHo1xAXVphGNhboV/udcH0tnXc7x/DHa93bEPDZr4FPwl3g4WRypVWvSJijgwMSKV5dgaTRVzGZ1TVSAEokluKMYnKbX/6hUprOyTVxAi3SpAI1wGrSHcZOcHc/rqoXuHl6mo+RL7PAUDMKSfO6rCE0+QeAd00YQU4DbDojbXGwW+DvbhSnWZSl+KmdeBMHmuksPR7rYsoT0jnjvQvglJCjhc2Thn+1zTkOGr9FQlX/OZ3qsjMrwf7707L5z2LUnKmH1q0totQhxRnxZbtaLcBxm2hT79247LiwsEa6DhvKYKSA905u57FU2Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wy0RiuiHYUL+un2ur+lKt7TGL0xvo1YRTIp7BjYi5H3IIAi9MxiXXwQlcaU/?=
 =?us-ascii?Q?5zbUg5HT1HgdDiet6UUkZJMcaVnaIfNY5pEoVDo1XdDewc8R2hokr+LKNk4u?=
 =?us-ascii?Q?tEKt6Hd8DcJ+C4FtO71bowjeo0Rpz/hmnxWoYxPqTGX1hXf3RSPrjwB3LyiV?=
 =?us-ascii?Q?EC1Z135/iu+EdezN3XUZW12hD7Rey2CoiSzJ2FVt7UbnpG3FwDiQ3ANggSr2?=
 =?us-ascii?Q?+FP+UdUdUQYTrttjRrOqAnsTkUpcfHEw2wcFLOvVWtaeSuWJcflNBzE82a3C?=
 =?us-ascii?Q?znXIlzsCUCAYRxAp/oi4sjIzvvwOGZ57aq7a88daO0zIqFSYXxtbEKDLSSeI?=
 =?us-ascii?Q?J9dSMdNDmOGl2LOMaY2pIHDnwAJmY0ibaDDQ+/9Dpa3YkL5Q5zM2RLJjSArm?=
 =?us-ascii?Q?7qscihtwZxp2jjI3YZYmKmQRTF3tFd3rPb8Jnr9X4cvQHn4VPximPXhzaQkJ?=
 =?us-ascii?Q?TZjRJiaq1E2DyyjTq3+Z5woWX3R8ZMFcY7M3wVKfn0R6CXkhXAaicaSF3+Cl?=
 =?us-ascii?Q?VnZxzasTvN/Rb8lpa3gDHYBjCtybwRZbCDR3xggNJvWan1JMoAlB7LsOLP5d?=
 =?us-ascii?Q?Z2RP2AUZMO5eszQzlJnduaeOVcd8jHEyHvsY8Z3pEuSGx/FnFSncKNhZCQny?=
 =?us-ascii?Q?hx1isqhIf6P+AGGKM4dmHDQZEjs+EVS13YdAkYOUb5rb8D/fOD/AmOG2T0Gn?=
 =?us-ascii?Q?zKdm6l75WMV/ZwpgwvWXTm41BwhGxk5lUpoHa5z1HIYiHqiP/B3KVlx4ETB9?=
 =?us-ascii?Q?baEPlgvizjFNDCynhmHuIrsNfmRsWCs7maCEPjbWp7aFaZu0N6iXGQ7c+Hnw?=
 =?us-ascii?Q?fJ/15yYJSP3QpazSkTI9XTCeOC/iRjnrqh1lr7r6jAeiZYWifaIshQWWNlWX?=
 =?us-ascii?Q?gEe0zL7aQGZNvNmej8S8jY1jAlvAT9/PugsTYMXS9Kf3NbF1ufRyqWTpsvS6?=
 =?us-ascii?Q?OHxQWyXNfNDPk5Wva/oIZvHtKTK4OTv3SeaOJv5RrtrJQ2/jgfqmRM1BdM68?=
 =?us-ascii?Q?LiSGVf6KK/ApXq2Hg0B4GYtyGmjOBxECVtlxNgONieeHB6nFs2lxvaINE4M7?=
 =?us-ascii?Q?IAj61nUtIJD6TX6JPVDVEUnW2NdP7Og8SC3tJasa9GY9hT+bDqfdSMl7PC9X?=
 =?us-ascii?Q?YtbG/M2HnBO1tRfRpu0XFDSHGb9Gk2dkNjB8E22FAdn3QknjhRxqjY7ej3ds?=
 =?us-ascii?Q?cAS7GzyKzxHgsUk0rNfcRCL9F3taL1d+wZe4cph2gVdtPpQdQYDQsRIZ/beb?=
 =?us-ascii?Q?azGy08LVk+UEcB9kc6k+pvlh0E/CGzU1Y+Javg4uSb+WJd/yzgBBnWopai+o?=
 =?us-ascii?Q?Dix0xD4ZWY5ds6KqBxEweK0WH8gKRx+jYv3bb7dCzPh+3XIvNredAcXwDmSP?=
 =?us-ascii?Q?QQlUUW1Of+++wpyVfEnMhxTMm5R37H5gcnopbk38m9KblkZIcHiFASnpeU55?=
 =?us-ascii?Q?5aDBJHv/aD9wi2MFkWn5f1f6CmkgBxj/Tdh50VQGW9V+SdBql22p7h+TmeDe?=
 =?us-ascii?Q?AUh75+SmU4njALRSUH2ei52eHtRbKFcGoQjDH27Ut7KGURCYGDucpagRkIEZ?=
 =?us-ascii?Q?yvjF711H8JPwiY6Ro2Wrm4MPUuBES1AYXlNVHr/fRREG/fUaCuRQaVytJwZJ?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54903b96-ce05-4975-a848-08dc5b167306
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:31:55.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukIFd0MmWSnvilxhgKJD8h855BSLp6r77NJh+CucQQAZA9nrn8bffl090+FA3iyGLG35tFPNLyswRCazKgduXv0rdkFRRISe64n4ymD+dLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com

Jan Kara wrote:
> On Thu 11-04-24 10:57:25, Alistair Popple wrote:
> > The page->mapping and page->index fields are normally used by the
> > pagecache and rmap for looking up virtual mappings of pages. FS DAX
> > implements it's own kind of page cache and rmap look ups so these
> > fields are unnecessary. They are currently only used to detect
> > error/warning conditions which should never occur.
> > 
> > A future change will change the way shared mappings are detected by
> > doing normal page reference counting instead, so remove the
> > unnecessary checks.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ...
> > -/*
> > - * When it is called in dax_insert_entry(), the shared flag will indicate that
> > - * whether this entry is shared by multiple files.  If so, set the page->mapping
> > - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> > - */
> > -static void dax_associate_entry(void *entry, struct address_space *mapping,
> > -		struct vm_area_struct *vma, unsigned long address, bool shared)
> > -{
> > -	unsigned long size = dax_entry_size(entry), pfn, index;
> > -	int i = 0;
> > -
> > -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> > -		return;
> > -
> > -	index = linear_page_index(vma, address & ~(size - 1));
> > -	for_each_mapped_pfn(entry, pfn) {
> > -		struct page *page = pfn_to_page(pfn);
> > -
> > -		if (shared) {
> > -			dax_page_share_get(page);
> > -		} else {
> > -			WARN_ON_ONCE(page->mapping);
> > -			page->mapping = mapping;
> > -			page->index = index + i++;
> > -		}
> > -	}
> > -}
> 
> Hum, but what about existing uses of folio->mapping and folio->index in
> fs/dax.c? AFAICT this patch breaks them. What am I missing? How can this
> ever work?

Right, as far as I can see every fsdax filesystem would need to be
converted to use dax_holder_operations() so that the fs can backfill
->mapping and ->index.

