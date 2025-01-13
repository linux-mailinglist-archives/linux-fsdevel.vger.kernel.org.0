Return-Path: <linux-fsdevel+bounces-39094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED9A0C526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856633A7BE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AE71F9F5F;
	Mon, 13 Jan 2025 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcCZH8fV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A91CDFA9;
	Mon, 13 Jan 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809654; cv=fail; b=mYEWqrSR6fHJiUXb6O42+w5VPJWM7l75Z4wO8VdwdoSeGQDIcz+uTFZpKJSPaxW1JDnTGAxqIoUiRC1za11h6RK7swu/Gf8+Ha58vz1HCSrEQtfLy/m9w7N74DR6CKVX/oeaojeuE9tgkdJ0s4nktnJyVAnUUkNlsq6tFv3n7ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809654; c=relaxed/simple;
	bh=b1Rrdqkv+9XRzXY49fi/LsFlbJ+yUob66LScJ0m84nk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R5WUdNpn3pQVVXySN54pYnoAGDVYVoPCiYTa/2t8KUjHRNdRXXUdtf8mVwxkJaxqxxJWX4d0h0pT+BF6lfEM1XvbWRcIQ+yw8Oilao/PsOHoX0rGvU/WnEcSgO1bcE0xu8QexGyqP/XQPhr3k65PlNEI2sCQNwal3o4KwYhNb/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcCZH8fV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736809649; x=1768345649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b1Rrdqkv+9XRzXY49fi/LsFlbJ+yUob66LScJ0m84nk=;
  b=ZcCZH8fVaU5f8YzTRUxyPZIM1VUBwxP2kKR+hxUGHqMWwSquPwKjpkcY
   u5TlqawHWIAZy/wU4CoIG0SbP0KTbD9RU8AIA6D8413tEeHXbiOmVrscp
   MAFgwKgaM9V7pbIDuDWXz1fBDwiyE8yaWBm62ZY33BCDvkcFnVGhXnDYj
   5n+D8YYFUuI+RJMSgvXBG43dgqxho/wWsOE8+v3Vl+l3oSgZ5KEoUTfrP
   xSvdx0pHDqgT+jgYxOfHmSxvPnMqwGzqaEIimgrlthb6enAcG2446139j
   yuXQtC1dGtGJ4JHiqQ6czjnXZ6bJmFjTqOd+hWFw+/6Bg5jCbvQc1SYuL
   Q==;
X-CSE-ConnectionGUID: N/0dV7DuQAW+xadA3o74EQ==
X-CSE-MsgGUID: mbbzj49YScGnLoJn4iDWag==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40771532"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="40771532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:07:27 -0800
X-CSE-ConnectionGUID: Qtkm8JpnRl25bjVLymVabw==
X-CSE-MsgGUID: gfakIKZ6QhyMCyLEhbB7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="105188600"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 15:07:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 15:07:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 15:07:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 15:07:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHUvQg9+GKN8/7FIuBSelRKH54k5E9JN0eDO/txAIiZMj2VqdAJIkV3+xyQbP3KxtB0cbraI67PwGrVqEwuEgVLKCo7e9lh306Wna3b4RJ/Vl2VsErpC1akRLnmd6UdHSwg8TTc3wI63cSYBAUwyQn5nq7kommTa+2T66+yeDkGa3KaG71h2RYUn1xLVYIJXSwAn7+46kLgJLVKiZfkvaO/fu04UJd8pExY53Gclibt2AMSmTm+tA39gjxbGe08Zym8nMaN5ZGwfVAGNebg9vjm0A7XJK+Kg7iG5Y7F3UbC+thrCbuFE2QW6IJcHlMyXm1NJ58un03LcQl9IsbV55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5svfBfn8X8iNG7JiPG8B2kpmH8qGxbf94pQ4qkZz20=;
 b=wbx/PIm8bJNhOJo+ftVOMrT4bjgb5C0iegyDYnDkhZQmos947e7Q/8W5810PJhhIdnQeqkV9wxybu9hDgbkV1lYcTk2cFc5u7goott4LCjlRgQdv4wnfB7OmPQlxewSnqqWexjjKecCoCtQKpV48GX79KWWpGlMvbL03oLl23WptWPHXX+rG2p9Xkpk56VGyuEZLQuY9lgUCe28KC9jxQYQB3J7tXVai7d5zBp59MZJBkbM2WVSrLO1Hciq8Jpb+wEOyC7MwbtZFCuj7/K4WZOPke7c+2yeH1YpxnO4EObUHndkgnLKbwmhd0ev5EprNIMbKQ7rRMq445NSKy2N08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7059.namprd11.prod.outlook.com (2603:10b6:930:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 23:06:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 23:06:55 +0000
Date: Mon, 13 Jan 2025 15:06:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 05/26] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <67859c89ebeb8_20fa294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf769f-9da7-4ae9-1b83-08dd3426f90a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6lzv0/GjnvXOysif/9lFmf5LyFU6G5P01bz3L/GIQNyNpb9vtlzDIfytlOku?=
 =?us-ascii?Q?7bqxhftaoB9+S5/oscJQxHi/yUCgRxIGZvq60vZ1g9XL7dJCmp6WOUDKH0n8?=
 =?us-ascii?Q?J7/ozqiAlr/oCrAup7qQi5h+Oj1apVCJ9KzTgBpqGO9ovf7G+JlaM4mFR3C2?=
 =?us-ascii?Q?D7D7l/nA2y2KMeJ4Yl16ebvOumUPtOH8BcThvYYnTkfC/FAavWHnx+d++fgQ?=
 =?us-ascii?Q?J1DR2Cbl2O7RLmtVGZ7XpnesvhA9s1cDlY3glBhyfjHdwr2bFU/3naobZ949?=
 =?us-ascii?Q?coysqBtv3f40DdT5btGFsgqGNhed5VRyCx0mofsyDmhlYLgkN2HA9d/o4GdX?=
 =?us-ascii?Q?cPQRJrQQisKvh4M9E0wbYNWTkZzmfIgXGpibKhOcBC+aLgT3mTSfg4KtSUdT?=
 =?us-ascii?Q?tiL4vLUrCThWDYA6vLb+BFdHw4n7R7ee0EMTS2VcZcl0k+obWRJlXwIZJbJO?=
 =?us-ascii?Q?AfFJ+ExdG47KFxjtKOzd+sm2Xv++w72ycqQgrjkFaqfolnz2bSbvWv+wri6v?=
 =?us-ascii?Q?AAOpdGdudfOqKXZ8hyKBMwPhRdYtzkBITIxSz39RyKh6FtUw5wReCSo4WIK7?=
 =?us-ascii?Q?S1tj0ulN6SwlVRXgZW/Nd+D0+//+Bcp02Yge0Fenj1k21GDHurnobRiKDFdM?=
 =?us-ascii?Q?X4epWcBiAz+xNOPyspUTAKo7dEkwkYOAFrPLaXw2iBxy5E5oBsIVN0oovsLY?=
 =?us-ascii?Q?+DWO/hSOCU7yCOZY5ct0C3N67St2eeW07+R77R4yXsOrHsiHDWbUxbImMW1L?=
 =?us-ascii?Q?C6EcVyNDruSFEQsXCvC0GKWLxrKHSkDMiKdcjF2wEiKpgh7+H8F9WyJue7JK?=
 =?us-ascii?Q?jXr5zEb0k+pfzqQLxV09YKTknW6MyfDl3ajNCIdzBouZEPxkSLJvB8+G+Fvi?=
 =?us-ascii?Q?XvDDEpO+Je7NSHXKWBQanGFjfC2LHWtkiwo6cInLz+A/5VE3PyONDXcXXYc8?=
 =?us-ascii?Q?hZGsO7VwDmMwJHXdqe7om1Qrzq0p7nsGnbmxVENQRLfZNIqcBHKz2KixnT5C?=
 =?us-ascii?Q?PD3B1ihyJWCZAFZzU59sIXlIfILVEktzvrUBTG5Q/bpKGgR0sJm95Wt7O0Xc?=
 =?us-ascii?Q?nimAmPkPoGWWetCru+FYLXp1Dp1lMivYQuSS/FF+yPY71O4hJfvLUpB2C+TE?=
 =?us-ascii?Q?85IXjh/V3cfWt1b+dvyTTgnaYYfa5KfP+x8xhpzfgGcGrUcfFYVdJd84/HdI?=
 =?us-ascii?Q?Ch6pNEnD8hoZAxd/l2r4u9ETTQXZ/BTJiBwQIIRuQH8dnY1vjVcWKK1Ut5AW?=
 =?us-ascii?Q?ZTATxwQxD6SJzcdsNYzXHpsvMZLtj0ImZWE9T07IjI4LQhGtAkpQCKOlm+lf?=
 =?us-ascii?Q?Ob3JIdVCFH97sm0cIITYjCP/GulNNSos7TaxRXT8rgw2jRxiI6oKfx2lMoCp?=
 =?us-ascii?Q?7OhcRuP2+ejq7KmRdJusD65W27Up?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pt/MHV7g9/TWH/a2GWV9GaNlz3aLxRAcQmtND2aUzWgGU/J9J/AnwxToUPfT?=
 =?us-ascii?Q?dKIV2HSZ8FxZtiia6axXr0i/JcDDwWfrko+E4a2gLHaoUdgvZUplSOyBlxk9?=
 =?us-ascii?Q?P899U9bFHs35yWoPPeTvBASVIBU/uXJB5u+M379ZH0EoYMXgO2earR4eQN+Z?=
 =?us-ascii?Q?aBJWPHG1EawhN9rEABxxlkw+6c3wtER8NzSUdlx7vQ7hSswjeW6BkhafRFlQ?=
 =?us-ascii?Q?1vSsz7qM7ojWJ1UsJAdOEPv/TyZHO2Pngm8BXJn2bSxh1PgMNbj4EqaCt/Bd?=
 =?us-ascii?Q?azhfBHfHe1Q2u7SwaAAc2IKRAV76sPzl7npiqU4Xn11WGx7qx0bPAO08Kq49?=
 =?us-ascii?Q?bNF1oF5WBsjtooCCLQZDxZTCmGOid3ctyA55ejyGdxM3+2aC6lj0nMQCAVQB?=
 =?us-ascii?Q?NTRUUE+k5tC/zO7vzX6p3ZtvwyPnVvwRF8KCjmjDcHRtkPpJSffmjlSoJI9T?=
 =?us-ascii?Q?ixFJJBskLyCJhVeHBzaBdJVK90Q7BEaco5t9X6Mc0is/TuFyiGDlWgH5kMqe?=
 =?us-ascii?Q?/xCrR6oeRnhbM058bI9HoDCZXqrUf1HYxSzGYKfM0QH0MG81cwS9saQM6+R/?=
 =?us-ascii?Q?vVBu3WxPUJu9910YXo5/zBO1cit94Yqzy08AGJCIqPwU+DcMO8Mne9HDtZLi?=
 =?us-ascii?Q?hSiZX5tPf7GYApZxkDxvxEPl/JmgguTjR4XwqCSo0BCBNwNiSGzYCe5BYF3q?=
 =?us-ascii?Q?DCyB1ESw8Tj5H5hk9xcEI6wzipoZ2rXZqhW5AcWma6/ddFaavARfWiDrF5Mc?=
 =?us-ascii?Q?Ec8ZCJ7Ik80zPtmTt+iYR/RYKCYiOzM1icUuVSxaPMMOWmSREgjEcvvPvMVi?=
 =?us-ascii?Q?1KJGzgIvb8OER2J3606WtNWX5NqZVZueLVNuxMk4TCLMwTTSY8wpRaRLyLCC?=
 =?us-ascii?Q?FZRX/W1vRDA2m6gK8NUjqkrBcDUGuX0mPjV8puRr2KyLwEvLw0S+WtjNTW6h?=
 =?us-ascii?Q?baN4bkVqGpmHc/D3co+7ZDMEeEtn5GciJx+PplyrsfEukpCzdH4+0aBxbdJ3?=
 =?us-ascii?Q?yXS6pmm/e37Y+b6XhxykF2KcEz3CLlRQCsd7CJFIQz23jj14RXAdtL2z35jd?=
 =?us-ascii?Q?Ya5sh5kXd9vIKgm1Jre/r6odZvugsz6IWMwIo8RdQJAn9G53Wd4jmREGot/u?=
 =?us-ascii?Q?k2bnUZPC5fQHBaFGAOTp8nTpjJlY/oWubb47p6j+OOOZcPZNI76rjshpmn2g?=
 =?us-ascii?Q?CicZUsvZrtXqmjUFMd5Wt/tCqN4yvVJx2SJ3Cv9utoL31sN5qtb4hTTzXwaK?=
 =?us-ascii?Q?ioemQINYE2A5IENSWWQDZfhS/q1yt9pluUTVkYYOwstGs7dJ0d6mNReKn+Co?=
 =?us-ascii?Q?LLOlWNmuU5YxFTZGwivuuSAzyKuPL0lWEBPdtKUht1y8EHrw8AVt7QUjBVhU?=
 =?us-ascii?Q?r8FdKCLfT+ZGG7xMB+jcVod26+74VYEbnzAn0snhzbITEgBIFwUGh/TFzp9r?=
 =?us-ascii?Q?Jom4GoAvstDKY0MzOKVtI8ViOb2DWjoDMS/6xSr33cSO4AftTKOlkr+X5bGQ?=
 =?us-ascii?Q?6nIrCXABANK7RnLVxZYhtzxLei+3T2vs3TAkm2JeQp7ljGv+2Lc7uu4CCxmb?=
 =?us-ascii?Q?u8FC+6AmJJjmU3R3gZjKC5bIks8Llor9SbLx6RXVvvzp2bIf1EVi0fM7cRrL?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf769f-9da7-4ae9-1b83-08dd3426f90a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:06:54.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGXynRMwRXZV4erm5IdXzuL3mHdGjsxB83aNhAhBUNahcoEtOJEWnyZNPc/41cSJILXh6SY6PyNUNQmECb67zncBrPDzbtsO91ILHHEELC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7059
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Prior to freeing a block file systems supporting FS DAX must check
> that the associated pages are both unmapped from user-space and not
> undergoing DMA or other access from eg. get_user_pages(). This is
> achieved by unmapping the file range and scanning the FS DAX
> page-cache to see if any pages within the mapping have an elevated
> refcount.
> 
> This is done using two functions - dax_layout_busy_page_range() which
> returns a page to wait for the refcount to become idle on. Rather than
> open-code this introduce a common implementation to both unmap and
> wait for the page to become idle.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
[..]

Whoops, I hit send on the last mail before seeing this:

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 49f3a75..1f4c99e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c

This hunk needs to move to the devmap removal patch, right?

With that fixed up the Reviewed-by still stands.

