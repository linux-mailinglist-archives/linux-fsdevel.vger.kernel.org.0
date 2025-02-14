Return-Path: <linux-fsdevel+bounces-41761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F542A367B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 22:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A617A5A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD331FCCE7;
	Fri, 14 Feb 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcOmQFxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C061FC7EA;
	Fri, 14 Feb 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569470; cv=fail; b=UTrq9hEcdNwBgCYkQ2fMPA2Dnaxsqd+Ir/pFSu1IJDNTFKdipu5wsfpacm9VzaJuFSBvTxCBS3Iyhklrr1tXWbUbivPQ7woOEQ1KIqAJBPoDSZ1b04F9E5kGRkNXLgnnIw25u6LISpo7miyziTcOJYKLK2Qel/y5UjA2wEt9dNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569470; c=relaxed/simple;
	bh=tHARa5JN9kX+UBPiev+j50ACJ6iodE8pzhAvJs8yPy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwzprbbKU+5c+uabv5kFtmvBG5qXZwLdJv7appl3NffnFmbQLaPLhcf3TYuMEg+DL4sAE2WWXsr1wc7E3vjkM4Nw8uR/QAmyi8oyLdggiJ6npmK1KKVB5S+hYBFNfMdO6H+3JubgnpuNZmVcDVYf2rX1rZ4Z5szZUTSSZBBjsw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcOmQFxp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739569468; x=1771105468;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tHARa5JN9kX+UBPiev+j50ACJ6iodE8pzhAvJs8yPy0=;
  b=HcOmQFxpZFRigUqSYS60ydnGdb8E4kL84pSmDVlF6y16mefReQLlKi7D
   jmnbgxQTHEesk80qn6Ufh6J4uLctvH8EHJf0sTwIlxHw0cxwSY50JEYbn
   EUxbVLDYT7cQC+rTbNmH2Lif1s8BNOqtwMahA2rDfJDUPqkrjcAF0POuS
   A6dIsdXQeAKL8QbL1WkGeK+Qc6R3GKNVXhTAxVshwyQoc2AL7VOxoAR21
   uNA02Sou7TcfJminsU5vIfZpbzNp8oXUlJRv7kkltmOJ2cT2d5M37kgl3
   NKuvVaAdF27oXNQed3Xg3FsWVmUvMEEW+sKdJ8OMr/hFAaf965xOA3Vqb
   w==;
X-CSE-ConnectionGUID: Fg8mO866QiWVD9uUsDdn6w==
X-CSE-MsgGUID: gYDdHl81RiOAZ+hKiYuzVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40039604"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40039604"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:27 -0800
X-CSE-ConnectionGUID: ILBpsKihR46jl/UORflaVQ==
X-CSE-MsgGUID: YdMbnoSVQ4arxsO6+Jv8EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113532897"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 13:44:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 13:44:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 13:44:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 13:44:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRtuzCltlkm5aVs7WQx6POZBsxtbe4uQNg6xptroF/8F5gXTeUJEqVI1f0aomQPmlU4MnvBtIr2n/qs8drj8hgaRItPl7x4G4VxEXOG4VpLcHRMiScFgNDlruZKnE6IZdIRQE0RGZmLqVLGOmZ7SowOK+dM54gBCexykoFGoTWFZukGoeo84Fw3O/aTs4I2TE2VYbKiOfP4zCDgjOUYxzEsw4iF0O2EWJzyqhBPb6Ap2lOF1IRHRTmWJr4RyXjBKs4Ei0eHS4bTEuZORPKbBda/S1vdCmNpppf594UMGWlDm5giOvQhitTuOQ1iylpV4eagkWwaR2Ij7Uw8moOm6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHARa5JN9kX+UBPiev+j50ACJ6iodE8pzhAvJs8yPy0=;
 b=fxno/fGOTbH+Yy7TBHtLXLAm1f6niCKAb3bg3NrNrBls65aH+eDSPTV1uoVTqDwfzUFaloO5L3XKCqpc+12uuEwQz3ZnjVJ2L9SsPoeE53L5tAqkKOc6qFLhAm5HcfHSXm8wh613ELi0l4e5tnpHvTduRnQFPg4Gskaip2Tw0NM7xLEPSJVQfnHrpQaqmiM9y86YQuhjuko8oYhtgGFggISECc+qhDCyhESqo5elwb3M53Eie09Ayq+yydABAMtuO2vGLIFYK4gVbjNo4gQQV+I7jPlfjvpCO+329pzWMobQaAPqQqx1Aq9XK8JDN9YbPkB+cLhMrYOQK3Zep8VUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 21:44:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 21:44:09 +0000
Date: Fri, 14 Feb 2025 13:44:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <apopple@nvidia.com>
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
Message-ID: <67afb926331c4_2d2c294d6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216155408.8102-1-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216155408.8102-1-willy@infradead.org>
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: afe3cce1-9f05-4432-a0ed-08dd4d40b65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rbt+E1hxV8VC3Q2mJuKJBSUcfLUsG6I1DiTwD3OI61jxWK/WS/HvcN5SdZjJ?=
 =?us-ascii?Q?SJ71HSUgR8oPtVtKcXq3+9PD1duYv/6aK2hR5zAnEencwxVFyaGRKy0iWhnI?=
 =?us-ascii?Q?E0mp746qsawUXbBXKOALllcmnR66eStC7XwkgnV1KcX8aiJF4KiaPZPiUvd/?=
 =?us-ascii?Q?DR0EpghdDSycb8pLE7oIOXXvq/CCKUNYtb9ENYeuKfoOughBkPPTUvVvWnHW?=
 =?us-ascii?Q?b2jYZxiVwOh0Pvn1g9xmqOGx9W1FkWn5YRvV/6qWTkamgM7GwkcFhnHW7HS6?=
 =?us-ascii?Q?aVVxNhZz8tiw3GTN1HzyXHnj4gYpCaZRgE46cscQeg+Scf3JhC+E/PqKdQBZ?=
 =?us-ascii?Q?Yqu7NHgyQ05WPMOpRVRjV/KJjUOQXLfR4izfQi3at/7Ki9vzk3wqpQo4oWPm?=
 =?us-ascii?Q?lZEokEjINkKD6Y+Jm2ArQmux8aA4ZMvpsql8u1XXXuHN+Uf7quqwX9XfzLZ5?=
 =?us-ascii?Q?MUHfs7izo02U2QyvL0o3q4oGYAUeu3TJnpsku1NpeiSzdZ3YxF0UXkQ1sSSw?=
 =?us-ascii?Q?Zj/ID75XW8OW/7AKph3XyjcQHDxzuh4EYIWCQ/Q5a/gDIqH0yvaCcs7iPX16?=
 =?us-ascii?Q?1PwZnJGAuEmiFRS8zndWHek5jBSfrGid1+Jrwt4Ad/ecTKKkTP53pQ/gbK3C?=
 =?us-ascii?Q?dk3Ixb2HS5jl7KtUf+JZ/8EdW3MTm4PugzTl3JdJ29pP5+XcFmp8mFElh+XG?=
 =?us-ascii?Q?9kDxSganJ6Cmb83Gy4RdUwkQzf64y/rX9jTCVFUDPXAyAb1lokqH2P+eHLZf?=
 =?us-ascii?Q?SWAWPpSXVuzNdpkZR94cIluUeoN1FC+29ASyCL7LB987rLhH+T3IVja672pN?=
 =?us-ascii?Q?/qkUEZW+Re+OQjEL40rfgMKejQxjq9p8fdBrwmfmgpWjjJNPVGcFWBNnWdEw?=
 =?us-ascii?Q?GllANP9mRe8iomRTJJzQGBBzAncGXeXEVXB/eGR9WFWVzMknTByP5nMXsx6j?=
 =?us-ascii?Q?9MpvZtVSNt2KvpNpvW9v2d4pK2xn9gZ+XoBl99GVx1hmc6mN2cxf2ZubNWJt?=
 =?us-ascii?Q?SMrmXR62nRweAvicrTwGrnUaPZFoLlrkCJ7vhV6zvzdCClGvnygPeywL4Hye?=
 =?us-ascii?Q?WB3Z7hG2uFLDAYnBWiZ2UlIbAkMBYIXPwfIvhkkVZ1ZsKi3ZiUzLKl0NTiNG?=
 =?us-ascii?Q?fKFA+wTPqonSvMq4HHIJaO9YOJ+vJu7LEGiK6ZRB3/m0HqHZ3/71NO2ukTVs?=
 =?us-ascii?Q?E0icSixYSm05XtVgT+wZlI3EelqnhBEDALHdP5KvhOyVUWb+vxyYi43GQ4Vi?=
 =?us-ascii?Q?hz8JplroJUKcXiYBt1OlSvYhgMRiI4WwOATudEJy7GVila3yE/MiTWiBxA/0?=
 =?us-ascii?Q?BjwS8+vri0dccWH6A4nx/LJjABQxhLUrJqDbZt1/MlT1h6X9AKXBg1Jsa9VR?=
 =?us-ascii?Q?+ojywbWDkv/c2MHusOyT8c7uS7iR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uk5ZyJhdAYU+EqGlC17sCXN6DoAwZQbku09B831EQADiaBrIzS0gsaeh560P?=
 =?us-ascii?Q?ppGwoLPnSDJzj9qUcvIs8F0zNJOJ4+Tx1E+zeXpD1R2+aofrwCwCkA4su7aD?=
 =?us-ascii?Q?dfrrhCIvfWzpfxjrXFEaQ/D8Ybkux+BswitVXJhxk6sypS54m9jA7jMZEpFl?=
 =?us-ascii?Q?z6GrmHtYb5vmYaF90qfUzKjLc7MmC/HMxWBh9P6zPV22NeEFGvFBIhkelnfY?=
 =?us-ascii?Q?2JDe46hTL8TiiU01DWiahuE1V90H781L9UkARevN09Mk11XX8E1k5f+utoL+?=
 =?us-ascii?Q?RS9t48Okim2nHNKpiBGZ7b/rVaQva+MiBj8FCnqVSVTv3BIfetHOqOELHH+W?=
 =?us-ascii?Q?d/TtKq9Mu4O4hh3rcSqhMRcfCgSuRI/ZuofflvHy/5g92xoDd9T+iWv/v9jJ?=
 =?us-ascii?Q?6q0CBDGcDs/sgG5inygUDYlOf4XZ0Saku9omgoD6VUDuGNLby5QUee5YwSp4?=
 =?us-ascii?Q?vF7Rnyt2YmeXps1yzrkf0LYizpoyMs6rjYIrtHPTX8/cHN8TZMcZFsLo3NXg?=
 =?us-ascii?Q?xyquNXBmz5s+jN8Rwk+EQPflrloADIN3jhyKXdFZYOkc3B6kuFVb43EyFxuU?=
 =?us-ascii?Q?KOfoK/MTfsKp5fYG6xr9BO304MYF2sUFMmFmcO6zb4e8VELUlC2nSZ3eqe6f?=
 =?us-ascii?Q?tcuY4zIqOXi4OLJgtnMsZIO4j6yoyUemTOdRtzgi71hdoc7zENmnn7I1rdHC?=
 =?us-ascii?Q?PcmSNhQxn0TX8bi8j1rhV+ih8VVFJR7cyPPD4JblG5Ce/goglHwnCmE96MLU?=
 =?us-ascii?Q?Yahss6G6167O0yQ3c260+Q9qteuaH5PvPAsWiFJC795OnK+ZQFyj4AxTQBNc?=
 =?us-ascii?Q?ufHs1AADiJUszEidBiReMU5YXezENsgPXdU7pV70K2cILbs1dCJEbbSZN1rx?=
 =?us-ascii?Q?nQtKdLS10YxEpeaY9Aa56/fXNRa4gOVkNVvfNePIf1DBdLDKGObz43ehIJm3?=
 =?us-ascii?Q?6x9UhnglrhPN+f7tNQ5Xz39XpEIiYI3+w3YZZzhUmR2ILl22Yf2vMsMakTmF?=
 =?us-ascii?Q?4t/uL+34pWG4sKs4fpCMIxDuzHm9aoVoAji/wUNcrU8yajt0xqEM5BbgF6tY?=
 =?us-ascii?Q?TvhQ2M5/gQv0wgQTtZe3NxVK2uTxgDIjYN/93LqTRmaRJ3AVBz+QYyMjWrYk?=
 =?us-ascii?Q?eRXbeVRjORSGjeOAW0AhV+/ZaT/OPYsEm1a9ylwi4NRL/xSxtlCdhlNCX2jO?=
 =?us-ascii?Q?ysRwUlH/PAUq2+pTgTw6N9Qgwo2aPosaNCFF6WEsGUZrPB8OSI4Pz0qJLIId?=
 =?us-ascii?Q?kjqWw5EwHkNrCadDBY8NROXUuc65feiyu58r8kjefwsQ76p4hUkNaRP9xc5/?=
 =?us-ascii?Q?mx7k+PqQAOX61tka/1lyZGcmwkbSf3iK6gEYCeAKXvDWZJI2GXPHYAU7FWsx?=
 =?us-ascii?Q?U8nD2/cmHubIZPvSePnppNyCvF3RbZt7cyptlv0wtgv0zV9WHtL64s03XrTH?=
 =?us-ascii?Q?NQZPaZ92AFQXJKkBtLw5jjvuduGSDc8mzSFs3Wi7VwVjcTqZ1O2Xht0kXo1W?=
 =?us-ascii?Q?YaUU00bkJ392+tXpiN5XyY2eub6OjrudwQn0OGgOCwzAAE8lApQuWhhIqyQC?=
 =?us-ascii?Q?OymCwJqLwPYGXp64iVgdt9fVcV96FZTFhFtywWL07jQAEl6LYHY8TEczBOZq?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afe3cce1-9f05-4432-a0ed-08dd4d40b65f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 21:44:09.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjZn8SrZBoWhtE4hwP5f4H1hhjRgLkUkapo340ic80MSNYeBl2l3nyultne4I6IupwAtNSYpiXCgrLtzC7UWK4YoX3HI7jnz9Km2PCK36aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

Matthew Wilcox (Oracle) wrote:
> This looks like a complete mess (why are we setting page->index at page
> fault time?), but I no longer care about DAX, and there's no reason to
> let DAX hold us back from removing page->index.

This is a safe conversion for the same reason that Alistair's conversion
to vmf_insert_folio_* is safe, folio metadata is always initialized for
device-dax.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Andrew, can you pick this one up at the end of Alistair's series?

