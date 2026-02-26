Return-Path: <linux-fsdevel+bounces-78645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNExGGG6oGmbmAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:25:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5D1AFBFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A203058BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D7644DB71;
	Thu, 26 Feb 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYoTxuiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36F39902A;
	Thu, 26 Feb 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141022; cv=fail; b=Spns6HgurRROCAx08zrw/FcTXAHg+P0Qg5fIalVNcEnVT2b639AVyxPwiVqQDoinzfHJ8wfm1FtGnWlC6Y7A2P+DFCDXPwRlHaZyJzzgzNqrRPbvlQZpAHHGIT7ePClo4Kl49q0JDR1Gbs2k23i3qEqmVtnRACPwHGMGa8eQ4co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141022; c=relaxed/simple;
	bh=XpmS97DA3tLXpPBtedzrAA8T1qT3VLE8lmsVi2lGMg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmOENNLytdKbRftaLM/XB5Q92Nl03lGZ6+RzzA1l60lqrGSjdSWRKGsh6iGbZMqgsYYQ2W+nMDi8oN3zVDCmoiBsuqylG9hspe9rndl/7a0ljCNq6vPPRcaNuoS9FFetVKBCvoBrkcKmCfTMLHfYvYLTG8ESoXMzIY+WnVon8P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYoTxuiv; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhavha2spCmaEND6NI+XyjF3qRGJef8GJDsDQD2uienfPqQeoFWMvFQ6FM16nl+N9ZvYq76eB0Jfp8fSzMHMP2S18qgsaWmBBKdUSCRdHvIG/yVUFjqDp+lr5V17tN92jmvvpq9fcd5qu0bXL8KYUWbmk99tS7G/plLOJ5rlJvihhyEplZHd3XsppWtU4AtpSBCRsz/r6gbvszBJoQMqmc/uzXCDDVC/C41SmW64yb5lPUkq39ZGB+lC+N+S4tVAvhiRLzez7WCGBR+t8KvpCwar0eVv/o+ygNDB0iN/l+NCH0cPnn+ORjHREnfRWpLt7YBZxubIEEV1SZbLcFvhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOi1EIFkJ7ECXU61MxsO5+tWC3MJtJIuzyVIOTl3yHg=;
 b=IZP6PBGSwN6NjcWjXWp8ByCWaEC4h22T/aUi9ZTLLyWVP72T91/H3lDoVpg3cuIYilXqRl9bpxGRzUlP10yoXMUAY8Ddp+UixffYdlqVUU4k/6XreHQBtjwGgyNofCshFBpAOsyxlp/hUztRFEYNnOjehRATHwHDTx/kAF96WcCRtAgpTdzP/w3FNkyC2WXefH9Gz3HX4fJpO0vxHbiXYOf9Ih3oOo5BACCo9RnohBiEgaqXz5/2Gj7ENOfJH2Wu805lpZd9w1yFkzFtj1qnQ6WKNVzryi5i4bEF7UcvVpLZWcl9vXPubFe1rzn2UHE/Dz7iwiTphHx3L9HMCbYP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOi1EIFkJ7ECXU61MxsO5+tWC3MJtJIuzyVIOTl3yHg=;
 b=fYoTxuivX5pUUs/qP6hIr748UgigF/btXqxTN0UurqztypEIznpPZvfXCJIRYBIRDorfDCBz239SksEZBOmoK0f1ytjxzChA6c9NPYfwCkXyEhG2KvQZ2vedlz1l61zgXcFDmq3WJsKXVFa1IOEd4G9KvCc6+C94XIRyMxMi0I2qex2tu7ApOr3ftaT0Q8sPPS2cpdSTgHOtNbE+1GfNTDfrYKZd3qzFwOOhEVoeAKqplpFV3RIbHIL/mIdyG5NBw+9bto57YqwVZe+XXEZ5Vqge+J0AFkoYRqvr2/M8uUTweNBAXerNbICbEN8gACB7TSctRqB6eh44C8mLpuVajw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Thu, 26 Feb 2026 21:23:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 21:23:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Paulo Alcantara <pc@manguebit.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Brendan Jackman <jackmanb@google.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-ext4@vger.kernel.org, netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Remove unncessary pagevec.h includes
Date: Thu, 26 Feb 2026 16:23:03 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <2A496638-5119-4339-92CA-B1948B766FE6@nvidia.com>
In-Reply-To: <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
 <20260225-pagevec_cleanup-v2-2-716868cc2d11@columbia.edu>
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b114121-06bd-4b3e-6ee0-08de757d42e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	BU62UA8ycRgdBhvEL9hpFgYsyQNFS0YhgNdTSOo6PDYG1mJssu4DhtgD3QfyEb3+Ya8OcwRb/p9ZizSSGOOQw9VC6R95KtGRM2PHGJ0a0RFq8A5yTEutExmhuydAOxKuecQq5Frql9NtnR0syFn+IyEngQJQdqi8rsyTrdaklxQQyKclYHxI4b5BanR+o4ks2lwFVuc8Lr4Mm5KqLen46y5zVCoyqFeXlLjFH7XC6ti8yoAhDzYB9F8N1CuPArsxc4PbyuCB28p1L+mRCyYrzV1KoBsE4DUCe1tbdMfUKi1Nr5WMn0/8/LTg9nlwrPe94C5PDbkIsX5FKPnlQnceiJbDui46jkLdVsKKQVoktuZ/332B9vrFyUCtUx88x066kt9yc0mCYK+qr2aW4fA3aqZ8OBv1GdVyQq5XkgvGPUC2ock4h7V8IBDw3BbEgxybliX7dnKgfIShleA+p7JNzJ7kJyQBr92t68ENe057KMWPSzpAE3OHxihp9ds0xoveHOlG+7nbNRpVQziSmQxpSiZT/dggQVofwXUlEZ5d37+nnXmwLNBNMU45tC5XLAjnimoLP0Q4qITNDLoEsv4x3Pbbq/a7Sop281Z2avJCdIl+bEB25diqwuVki/Y6PF7JeO8n1jGgzqGCVB0i04xv9Y3ogbm3ug5f292Fv6w+DVGkHaupsKd9bN9shkgbSbBqsk4u0xYkrUoT/a+pbx3hWD3pitR+lg5gOayDbZTRFnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DteN/GYAg3knNpZxujGeliaF3KUd+qtIUwFeJNu+goAvyt9tglTAe++lhRdW?=
 =?us-ascii?Q?brDEwQiOW1NCA1yBCpzofAeOmqm9FPp+S+/Vhc8yeIYHVPyQ8Q4ZTjK6yAor?=
 =?us-ascii?Q?iCeEHjH71rGju8+7ComogvW41OJOe0wr/OBtgh7UX+eiqFS/AIZu5bcgVJIj?=
 =?us-ascii?Q?qLwmZr6vUlsDUfTwrab/32PVpmqKDkGM8ATjrKOMmXrnT/ztOKpvlGSwsuRy?=
 =?us-ascii?Q?jUi/p92PwkbeqRU2HaQd75c5TYMPvq7NczmV/F6/TRkbxDxCoUHNa71xZtY4?=
 =?us-ascii?Q?II2FeGDapTBI1GE7s1BK7m4+FM67HsYCoXLJbqiUqNLmyjqLyPx8C7mxAH0N?=
 =?us-ascii?Q?kRHM0YVt3Jo45t6fz2Im7VaaCT8oDKYuuBHg64GSEnrO6l78miSNjeaAH11q?=
 =?us-ascii?Q?LQweb2H7ruZag6xyfJW0NzQVK8PPSWsRPtsvqVuOYVqWSlLeEvO+5roiTgQl?=
 =?us-ascii?Q?6dwSAydZ9RsS9bvgY+nUg9d/Ie+7Vscwkt1FgUr0yN4Wh+Z57idVvD9p75/5?=
 =?us-ascii?Q?qfGOANdO21o+/RlvSIUK05FH+14Inobs6O+g1qAa1M41bnjsBRulSIA2ZxFx?=
 =?us-ascii?Q?jo6JEkpN9zdiXeH5q1GIav3dg7F/WuGljQVAQsEu2cv+pAoxWJK15MODdlxf?=
 =?us-ascii?Q?JbNYfBLI2Yu8lSbebh3Rnprrw63ByH9ni5d7SusJCjWBBY3PvRkatrwo4bn6?=
 =?us-ascii?Q?4U37+PPQBPbhTmJ8/nimIZNR89FQxYHlD9mIDt9vcJnieKoDQg2i46sxvtmj?=
 =?us-ascii?Q?QkSxKyr//ZyP6gtOEcsimEAtTHko42Ma9QRqzp8QdrwY/P+EFrAWwcDRyzKl?=
 =?us-ascii?Q?NByXxAYqAu3cEJiuU1bYgTMn+SfdKDq3KcwKWSbTS6QiKIz7FZpFMWFWWeYc?=
 =?us-ascii?Q?dB+cflncsktJNuqqpIFj3ssW1cYBidj5zxa1yrmxuplzuF5nP+/Oc4TUS65P?=
 =?us-ascii?Q?LsDNZuEUXCjxeAxnEGGsnZHXTZqNHga2rB02m5sH0E3Xb0rDvdHwDZNOjd+p?=
 =?us-ascii?Q?7hfyexuC3+rX3ixl2tmTYwYryheRx3A+eW9FwOiB1XJbYGWieV0b1/FPAwFc?=
 =?us-ascii?Q?037C0yzdLZN9LdgkWC2FYLIgy+YSf+4OkEU5OfewjOL7xWbFE2+87Js8jDjG?=
 =?us-ascii?Q?TH+K03kcsfoIo8evM7Hs4aUA0LYMzAsQbQCr6QrA7G6N0RQyEDNnOvbAXJeh?=
 =?us-ascii?Q?eR/qqenwInEMkEZLkFb68uaPzLmKwvqGkuPAp32P4swVQkWUqyEJRiNIVjH3?=
 =?us-ascii?Q?ADNz2kQRq2qUBj+a4vyfjJzyKblIhxnx3Y6AHG7XF5RiUPy8H9EKxI4hVpvq?=
 =?us-ascii?Q?wZekOCK43KSOAAWR3SJwBAPDIlOJS2RtemIzmQV+N7keJ02z0GHCTznF14MH?=
 =?us-ascii?Q?yiB8MY9CS8XDhzMWBD/mLgp4enZdZcRCx/3gE7n1jdev+05/B6l7mDys4/xH?=
 =?us-ascii?Q?vJl78FxCtK0belo1QwexqviqDHR6VGgE3BvhCSpdjUqPqUInClhSXNqewKQ3?=
 =?us-ascii?Q?mstL5gXKDzTVwu2+bFGIgDeGMm5ZJb4pu9h/SMAAYRgGo6LQFWq+ayc/rFDX?=
 =?us-ascii?Q?pN98uM/coPOw35wtCFmfmuZ8wVzvje69aFh0sl6/NQ1gSW6sg7+zstYnCdoo?=
 =?us-ascii?Q?XhjiPYHaqwmHOQyd/8V5KtbWoH2u7BCvjmCIr5BhtvJk+R/SMKdWHY3QPoU1?=
 =?us-ascii?Q?YDCDbRtX8Ht/v9iuP4HaKC1pGMlLnau/UbUkjcGubHzoUDpu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b114121-06bd-4b3e-6ee0-08de757d42e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 21:23:18.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwkPr3EKXn/HguwGcKVEamSWpgQ+EEF0wI+tO53qGpIRVaCsjamiaFHbeAHutHMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78645-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,tencent.com,huaweicloud.com,gmail.com,infradead.org,intel.com,suse.cz,zeniv.linux.org.uk,mit.edu,dilger.ca,manguebit.org,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,microsoft.com,talpey.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,fb.com,dubeyko.com,linux.dev,brown.name,ziepe.ca,nvidia.com,cmpxchg.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.sourceforge.net,kvack.org,lists.linux.dev,lists.samba.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.964];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,columbia.edu:email]
X-Rspamd-Queue-Id: 93D5D1AFBFE
X-Rspamd-Action: no action

On 25 Feb 2026, at 18:44, Tal Zussman wrote:

> Remove unused pagevec.h includes from .c files. These were found with
> the following command:
>
>   grep -rl '#include.*pagevec\.h' --include='*.c' | while read f; do
>   	grep -qE 'PAGEVEC_SIZE|folio_batch' "$f" || echo "$f"
>   done
>
> There are probably more removal candidates in .h files, but those are
> more complex to analyze.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/afs/write.c                   | 1 -
>  fs/dax.c                         | 1 -
>  fs/ext4/file.c                   | 1 -
>  fs/ext4/page-io.c                | 1 -
>  fs/ext4/readpage.c               | 1 -
>  fs/f2fs/file.c                   | 1 -
>  fs/mpage.c                       | 1 -
>  fs/netfs/buffered_write.c        | 1 -
>  fs/nfs/blocklayout/blocklayout.c | 1 -
>  fs/nfs/dir.c                     | 1 -
>  fs/ocfs2/refcounttree.c          | 1 -
>  fs/smb/client/connect.c          | 1 -
>  fs/smb/client/file.c             | 1 -
>  13 files changed, 13 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

