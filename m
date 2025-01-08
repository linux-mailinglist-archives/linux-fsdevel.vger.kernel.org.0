Return-Path: <linux-fsdevel+bounces-38684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB5EA06851
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 23:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9583A703D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B492046B7;
	Wed,  8 Jan 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg3jHXoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918B1E1C3B;
	Wed,  8 Jan 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375476; cv=fail; b=Q+pk1LiY7FRRdXIa4STpvkPY29FdHPg+Bp2EcgwU13G1Fsnp5EOxvp1ZkiZchf4DbJPxioEbss9a1gi7zcBN4rcyb80it4RQDjXcT2urXcZWZGrPEqUzhGLJfoL+myN2w7MN6JNBNUIG+N3MsxFrCrDYHUYjPcEpjuQ2lj/X6Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375476; c=relaxed/simple;
	bh=Ce2+BfJSZKhTHcX12QKljG2tsQBO7DwT02/kJt5KTo0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCoK+Nm/kk1G6DGxv1LdGNiptSlnu5uERgWn9tQK7B0ZYNEBAp24Lte7Cm2Ng+R5SL8hJeQk/vqnziDeHOnWmbFb5tlLIZP4vayQUSoYQx/h6l/QHcIPb/r3dOpIX0qo8CU9Fj5z+VU3KMFL8D1beQ666HlAADV+35B5cWsU908=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg3jHXoh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736375475; x=1767911475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ce2+BfJSZKhTHcX12QKljG2tsQBO7DwT02/kJt5KTo0=;
  b=Hg3jHXohYza6ZEkxAocE94EjFWXQlcspozugkRp5VqLi8An8jAwK0qZ4
   xblA+W0fXVDqZkPiM7YcgBRfV25w1R/75NZSK0sn4KTCiTkpyJUabKiii
   NOdAJ7XzyaoCiACmCSJx2e/zOBAFMKdYuR7QMCoJeAEjKOHAzLq3+94vN
   hj12kNbOok2wpuTsbkBVQ0itgkBNzsW2JNKqSn2hbmf/cRWbypDm0CK99
   5pY/cn2AOjJ/b4d0nKgEtYWnAwZsn6VljdT4fjwcV3E9rchEIvcyEsykh
   FrZIGDt9mhNdAczTVzafORlBjLXceatSIz6lGXmkpJ+QsCH5VUz+dboW4
   Q==;
X-CSE-ConnectionGUID: njGv70pYRPaPiY43mtv4AQ==
X-CSE-MsgGUID: mE8ouR8ATiOT6PaW/obxUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40386091"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40386091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:31:14 -0800
X-CSE-ConnectionGUID: sIe2cLOaTSq2+IFlqu6OAw==
X-CSE-MsgGUID: ryLKBlBZR66qAdy4lMiuMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="103723763"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 14:31:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 14:31:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 14:31:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 14:31:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk1KBOY1I7eufmB0mLtTNGOAGrrztzEUEOimSe5uT45D8/f6TsYZVLfQ2/OgH2tB5gRTFaeDrIVhjq8Rt4Ysove9KsAzFzjlS8zFiTzk0DT/HmbSH+l0q7FZGWU0dOSrJEW/yCbiI6HplR0ScvmwsQ4MfgXFDduQUOUsQ5U70EUhE+zvTxhVMkjfReDyHe9l+3EJhbCY/ZRrXpjSlwySB27vhjbYE1nbJ6RAt8klmTlHCc237vWrL8HGNnOlGiUJL0LcYAO2MeYoLy20a/Z1gnuB4auNAytBuQz5QTC2TQ0L+AEMYoQr4suc7j1NxLt25xe9pq8CRjwPdvQwuJDrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUqv0Ksbm+/HEaOsgldlwIOMzDG6U+KhCwAb9+DqhZc=;
 b=izcSxrfk+kQqgJmeAAQrG66bkLoSXC+BumrxaL+Y1MV+phncUqwd5y3iQsjbrU1Oe88n+LfepUaWehPLyEe0E6nmXKnl/oG1BhTylSY1Yye3Waa3UbHXP9gYEbFjC2cepNve5t0JiMxqfasjPB/8kvWUJMDXloA5VZNJ9MoRpTaFlhzLAZKm/J1M+dHS0vA3HnXmCjyC0el1Z6+7rBzTvnNWJ+ZFpGZ19FXVdxk3r1U3gy/XzBXhBF3nzXmAXjBkEqH0k1iMEnLDEKrH4RK+6QrOji24b2tsT+AyofK7sGT85CHb7bkj4c+9kvd85vG5+8p7aJlznlqdW+gPWS5mKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 22:31:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 22:31:04 +0000
Date: Wed, 8 Jan 2025 14:30:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>
Subject: Re: [PATCH v5 02/25] fs/dax: Return unmapped busy pages from
 dax_layout_busy_page_range()
Message-ID: <677efca34ca0b_f58f2943e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <db02794f12a4cc8c659a1123bdc90fcb4dcb1104.1736221254.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db02794f12a4cc8c659a1123bdc90fcb4dcb1104.1736221254.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: bdae4f87-bf2d-401e-e312-08dd303422e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZViParltpZlqeDozfF0T2Koomhsr2ax2cRxDLoYcGtU5EqcW1CAmjJnSB78n?=
 =?us-ascii?Q?MBy2BJfCjW7Dj9dRfrUglM9U2UUDg9/Rx7f11aPHzoS82VXPmrg5+txZX68+?=
 =?us-ascii?Q?AaRG/r0S6wz4KNDmXvOlAiBsx/1Nkoi8VsKONkvJk/Pm39z9ue41ulF3dE6e?=
 =?us-ascii?Q?DgPTILe5K/4CaMwJkzjG1CAB8ycsnqE5LLAvGm0LegmGVAzN3utK8W7Mw/ev?=
 =?us-ascii?Q?KnI+4HxzC8xL9dRbnVMGxmqZBytv12zWHY2yvYKY+EP3aEL0rR1ISqQSC2di?=
 =?us-ascii?Q?MATMB4ewP68u+1wiNnneSN4F9rIN01X6b9v1YMfGS2hBZuHsqyMQQMhaDj0m?=
 =?us-ascii?Q?4+idFk9mwcpRL3GnB1Iwn7bvrZSroMGX8Hw9ClYw5fugQBYbiCeUO+MMOemu?=
 =?us-ascii?Q?muTeZ7JJWpej9PzTbFwoug2E5YH+UxOODsEe7wYhYA7eKRx1tGIO0Ze06+3P?=
 =?us-ascii?Q?RkeGFQ8imOXWxbpqitoa8bUn4EIN0TCS64XIurf/H3hQJsCTAFrCQdHShGdl?=
 =?us-ascii?Q?wbo55t1V3dxkzHpcWxJEHWhzk9k6HQ/Js5+CyRauSCdjZWOwtnOjEH2v3Luw?=
 =?us-ascii?Q?h/M0T2DsfTjzklNRskQzF3gI/astosK9GuIXXG+6rOCSF8w+3RXEXlGMJFtF?=
 =?us-ascii?Q?XbdA0lQWBShgeKSmqpvNmLxBRSuI2BOfJDdpkLrQrzS7ErWplYaNLdajReR1?=
 =?us-ascii?Q?X3UCQfVXKjjSoP9S8+WZlHqoFH+wd4K9smdQgN5RrvkwZnrVxYPm7rHLptW9?=
 =?us-ascii?Q?7d/gqAIvOS2ZFeBzpomkA7oysuCIa6UdnmLGlUnrSZ8A2VgOk202j4UN017j?=
 =?us-ascii?Q?RM3qwnG447sbuN5gi5HLKvVGwDTK3oo0aF/ciDq2vtALLk0OXws4t/DNvvIl?=
 =?us-ascii?Q?i4Rs321eV0FlDulKmlpDqXWOwa5Muhp2XBYaPIWIz5jJTWqBX8gw3Bix9Egz?=
 =?us-ascii?Q?J3e60QtQbrhW4GI/MTjvzcJ1x/y/nzlr6KM4QawNE/2Ync8Rcd140T7mPSt+?=
 =?us-ascii?Q?mcTI7C7x6uC38N+zwS9Y6FEE6nQqodKHwyEibaAuBoMJRcwJDREd7CHsXzpt?=
 =?us-ascii?Q?oCWOxXDQzKgy+kjTfMdxD/sYVGulzYnnqahCrVUNc8sO0KmKbwOK6tdkvDpC?=
 =?us-ascii?Q?qq7W4Pk0VVHdarwn3QVDBuMbfBxm/9XUPJoxuWzNofpdywtluq/sFK8mnzc5?=
 =?us-ascii?Q?FqAMC3TnqI/HbIS5nfji9I/fE0N9QXtrXgLf7UtQmlBNL9VCouiYobndFZVg?=
 =?us-ascii?Q?OcDXtI1sAPd1JO7FSfPihbGfQP8DKXZIaV6FOFAomcr5OyVv9s6K8RD9Jk/U?=
 =?us-ascii?Q?VfjbO93iZPgV7Jj01oCNeY644nWmLDpIwJclK7bimD7KcU3war83YzXv1hE5?=
 =?us-ascii?Q?NT2hDzaHNa8tpTfbJDAAT07noq+W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eh3VDFQ5cctR5h6XBYd94LwnS41LOU1dWquAq+DxzGxBOf6eCA4NWEZDri4h?=
 =?us-ascii?Q?4IZTUEm2Y7GDEf4VGO9dltUImSe+XO7RTXyYZN9ykrJaFOOwb7u8vi9bA1y2?=
 =?us-ascii?Q?+oDBASvmCtpKZGLO2lMw6cwa9gajxgwQ4DTZ6lVEfk9ebHcNv/qVY6bLTL80?=
 =?us-ascii?Q?86IXtIoNKxXH9TiFl9BBYlDgaKXE95aykqcF963rfbfY2ooEjmAvZDRQVorN?=
 =?us-ascii?Q?H4Fo4HpvQp+vrv7frjH4WSb4I0DzubDC0lq4hKGmdEf4KqFV551L16P1vjMT?=
 =?us-ascii?Q?J03YAAyFOjz3/jCSsg5cf4J0mad7uuWmLH6QtiXThxvLgtGuakka0Yq49oYs?=
 =?us-ascii?Q?NJb4242UdGxoTUfJFvyDbiBIa4HvYe237CJS/LKznx0h0pGDzAAou+eerKTW?=
 =?us-ascii?Q?7p9XfAEJIma4e7vPtP41nt4e/KihD35BQ7zB48bgARh7rxhczAYovGxnDiiS?=
 =?us-ascii?Q?vjAVN1DV6t0tDvGV2QdrnrpnbTdPtCna72tK2EQEzTWexZ0dELEEdvFo4vER?=
 =?us-ascii?Q?bJKPQRgQtPvyuWzE367+B6zqSN8FNBTNznxyp3sSMyyQRsAp1POzR324S0qb?=
 =?us-ascii?Q?WjG7yHLZC5YIx2TvIhPv9qXadO+0nxoAniAjD08E/Ae3yM+Hp6BpKlmoSSM+?=
 =?us-ascii?Q?eUJiw3l9N+YGFAGbS0MembN9hjZ1H7723LBCxrT9Rv58KREOq5dHs1QffhtZ?=
 =?us-ascii?Q?+JqpKSpcNxRYxthJfXNk//lZs8z7HC21jaQwgmftrRPbm1yH3JXzPL+5aAzd?=
 =?us-ascii?Q?6r27s8hCcyNBgkIaoUNVEhvJAoPRAZcV/GviuHaKOEvw/oSsGJtUoDvj7wwU?=
 =?us-ascii?Q?fokQbHO2DWdRNshRncln1Xservo2wxnMglXJqvuawksTfM2kjA3sPuxKftJ2?=
 =?us-ascii?Q?tH1VIET6TByekztdgbd26Np1vfFgp4rxwSgze4SFz1TnJPA4QE9LEI5ofeeM?=
 =?us-ascii?Q?7LATVXjFm9I1MGIQZ6rFzKItmRI9lqeSmK33AiGokpww1f/z6WrfRi4+NoQ5?=
 =?us-ascii?Q?dAsjMHGv0vlco1JmD6UYAgLUSX/pgaWE5GkS/Z1q0rewRZkD69qY5ryEr21b?=
 =?us-ascii?Q?96TZUnin9VyKzXfDNznBm09wxSbdppmXuFDZhTMiBmhuARTRV/7gmahXAiXd?=
 =?us-ascii?Q?kQaPDkqJxOLm4PdSlmEgwGsF6VG7LF0rlXLvv+XWySiES0IFaPiFyEGEkHgO?=
 =?us-ascii?Q?U+OkHw+kaqtHgzId2vgBz6OxT27aDX3TFNhXuBOEKKaJAwnoRrQOo5zOqKX5?=
 =?us-ascii?Q?5n2wN3Xaa/fJHYV7Plplp7QZPYhXrZIlZ4u1zC45RcZYISBUOfOKYvc/+DZ/?=
 =?us-ascii?Q?tRKxc3j8rMVNYebBgUMDmOkCz9jkhwzQYagwuzhfV/UpScHoUaK2+zs4/kml?=
 =?us-ascii?Q?i3jQOwF6Iid82+CoIkTkiWP5f8HvvnnYH/e8QGvslz8VrXDUzT/hLXQ2ASo6?=
 =?us-ascii?Q?FgglLWNj1R18iIOBQGl6+ZxUDvBikc6Xd55yhDHWAqyzR4HV8OYQdlhrsYhn?=
 =?us-ascii?Q?V+uR28HLIlioMRGMqyty//8BJc9OO/1Q1lAY9/u4Ceh4PGWnvPm4u7kq84EU?=
 =?us-ascii?Q?lmsojmTYow2VOR1A5YVoJLai9nQTneNg/kMOg/sjy7HrL6Wu9U8n6/EUtqlN?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdae4f87-bf2d-401e-e312-08dd303422e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:31:03.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPPWGdZU6GcTJ8/rvLuJSwJYs1OIP5G/Xg/+8yLW6S2OYZpQfjeZ4UcwdurA6IFeyGLH3c4EAON7IWQJ2wOTyf38McanhXHoh7hgM7+xfHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> dax_layout_busy_page_range() is used by file systems to scan the DAX
> page-cache to unmap mapping pages from user-space and to determine if
> any pages in the given range are busy, either due to ongoing DMA or
> other get_user_pages() usage.
> 
> Currently it checks to see the file mapping is mapped into user-space
> with mapping_mapped() and returns early if not, skipping the check for
> DMA busy pages. This is wrong as pages may still be undergoing DMA
> access even if they have subsequently been unmapped from
> user-space. Fix this by dropping the check for mapping_mapped().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

