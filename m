Return-Path: <linux-fsdevel+bounces-74526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60766D3B77D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1DA3072E87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9B3191BA;
	Mon, 19 Jan 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnbXErzW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="csU332Xf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334E2DF153;
	Mon, 19 Jan 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851812; cv=fail; b=TzuxuOIu14ehKQsQzm2FeD0F3dAcUiE4dskivxAtjxYq1aOSF8klzMo0O6HVRxe+n5X4LXykyM/NKUozIfoceI5Qs4SbbWmOu70/b9KNFONg6Bq+qdPU24Q29fm8YXlYjc9IsjIVYOVXdY9kHq+KpideCQdXqbPKGYrIkLAduAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851812; c=relaxed/simple;
	bh=wAp49LGrX7wM3DGKeLyDP3Jp/FdJ/eh/1b1UAKNa8x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SEzcV4uC4mdES4c4rjJHAyvU2ITQUQsji48kx/L7co1IY1M51vajiCKUM8GcuZNojnQU+XT5qfKVkWN6TAhHyGq7RE2gz0THtnd7l78LyJb1TQWMZaK1RqZd9zHycg45qWtKloP/JWbQVASllFDewOkvcKd0FG5czh23X0pGexg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nnbXErzW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=csU332Xf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBD1lg1036681;
	Mon, 19 Jan 2026 19:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mev3WgszcYy9/c8rbn
	ZwGFXVyxU7toeelBe9EaEdysg=; b=nnbXErzWRsOrxBzcnEFM+1N3/q/PFbN1wB
	+58CJ+TbDpzxb2wkzazG3rw7zKt+zpjT4bJJpIbdJ5sHBomKYhJYxlyRc3DoZQ3j
	CJk0Z5WP1ZbwRvjAuxbAP5lmNiCj2ecBSbBrB2Ewan8noCJCOSJQAjmSjX1gqVit
	ZSLq1qpvChiwDqNHE8IrWaxOc8jQY9Ix8Jd7N98Bd5CTj4Fa/7c4lmuqVd45sroj
	2QgWWhU8axAvreTiC7TxRKFBTXacYoQjz0W71rgsX+7+rqgkmZ2Qs+yTkGJvvnE1
	NLch+Qlitm7omH811gLXpvdZF9QX0yrcouS1tLQc6DdE8MsXF/2Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yptkg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 19:42:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JHjOiY018020;
	Mon, 19 Jan 2026 19:42:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8q9y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 19:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHjIsF0pmn1atbSa78/7JlUiD7DVmJ4js4qe/yrwvH+Z817qW+NjZ294ZIsC8HplBgdWL54qtTt4mM5iyyzP4MO1otGmdLNikip3cs6Aa48EN8krBq4sbTJ6sAz9On00V+i91hYFv3CpTXDF5e91cwbO1ikKVhO5SAXT9wo14yaPbF7ksTQAMogdtrATJQm3EV6nbT5aGOPYhsDwxyvSUtWTDu023VK9D2hCwgYa8UuISLZ7GS7R3pdPnVzMjxTSOTHM9Hb0/A+rDHztdKokzRB0uASy4xN67RA9OR/UDGBnRKPjNpKLkPrgpcEysbcMgLE/NKpa4SZ6XN/jxBcjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mev3WgszcYy9/c8rbnZwGFXVyxU7toeelBe9EaEdysg=;
 b=D29/M6pm/ZQs1zg3Vi1FMlbMKjJbeeIWbbziiJHVEsdc0fd9NXjpgPJtCxI6IooNf40z7TM/yrys6hEN9ZYiFr9iJClgaUGkq81KxWVFuhveVN7cnZ2kNQzAyo7QmkwO2793WxiHOfyRrjTXLZU9O5GJqwfWpZ7WHHBSqq8tUOgjDii2sxAeLE7aXunHlJTGqNOzxkAqu1vbHTDHCouy/mUePnk0ISb1Eu/vS6CeCz+d8Drcvs5rJLHpvnOoWftb6ya4ca/WHtgCglTzTlp2ZG5Sa9eByXa62xhcQglEKhE990mTwgd0Vz7KGtMl0T+5xCTFGD393E6LWM2VmTrV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mev3WgszcYy9/c8rbnZwGFXVyxU7toeelBe9EaEdysg=;
 b=csU332XfjmR6+RU81J0oyqMwD1v/I/YAOqOOQuNlmlPtXaQHrZ8v0QY0Z9PsATus87CfD+CVxxdz1RsFwyACWXgGE08XRGYifeZTNyapoTe3GHAdCKvBCu4M2hc2ybCT9TwrB1xG4BL/mclATqkimr2SQnv942t5cKOIajc8dOQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB5992.namprd10.prod.outlook.com (2603:10b6:8:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 19:42:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 19:42:28 +0000
Date: Mon, 19 Jan 2026 19:42:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/12] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <e7b0dfa2-51c7-469b-a6f2-78b505c0f139@lucifer.local>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
 <20260119113302.76b21eb8be2f9d0bb076446d@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119113302.76b21eb8be2f9d0bb076446d@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c90e802-22cf-447d-2ff0-08de5792e0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeeBnK+DeiCqYZAxeZoYpZtDKdVF9kJsJoehGBc6fy+pbswWOM5McA2YFqvn?=
 =?us-ascii?Q?F2SJlGM03VOvO6Pz5ZFX7lCpsnxOeJ4z37u9fj2bUh5a0zU3dV5tTIdABhmN?=
 =?us-ascii?Q?CbWbRlKIOCI7P+PDU+dfHH1HpyXkjFBlJKGWgVissipk2xjWDaXI3hcFkT2S?=
 =?us-ascii?Q?H/6cCB8jjVM6hTEVimr9hNzs3BQfAc3x1JpbiBzHP57keTyZ4Dag3/qpZcYa?=
 =?us-ascii?Q?X/Ar03GDE3zjp/xmvCY5jliSnC9lFRMfvSWbSAfY1FRtgjKDH1BwzR+T80qZ?=
 =?us-ascii?Q?kL1eVBGqm0muhqk6AuoX/X3Sjk6faoPsPWJdnyRStlYDokYVpj3VqzAXIYg9?=
 =?us-ascii?Q?A9MrlC0lQkcaI5YkdUUnxn1dSKsch64IUO0cC4DvF/Lzb9o7y8+lSllSmF4p?=
 =?us-ascii?Q?P/JT/aj5dV+opVl9dkvjfnry0awF+SAf8X01vvffq+VyBpyICoPV5nq7wZ+E?=
 =?us-ascii?Q?p9wrO+qfMZP93sxG9LL0qJFDyUMzGti1T9KWTA4r90VdbZbU6j/WHknF3LRj?=
 =?us-ascii?Q?+ktByCvQnYM5yRL/unkamJ+8KY6ylqCxICDS4NYqMNCFCiJUtflKFwl2cFWC?=
 =?us-ascii?Q?oeGxab0Rnj8YZVkLNMAwBnS+LSmGZI6/0I2fvOCuHpiQupSGNfIglfUtfWqU?=
 =?us-ascii?Q?Em8yE8TR7yhd85j9OU9g3BPXvMIGtywhC7FVG5i/xj1rOeaba4f7riUh7/pp?=
 =?us-ascii?Q?BFTbyGJK1X+FMPKbvQDyz/r1+IwCgrFRSbMFg+477xWao8auRTZx2vfxWoGg?=
 =?us-ascii?Q?Dnjuh8kqCsRnnqs/RSRuoa3q/Elf0ww0EP1JWBX4hYnTy07Xu0Hgvol5RJYf?=
 =?us-ascii?Q?OmcPRMywbrPa3U44kEfHCjcoEGewc0mwaGh58S6Z/0N/DUbcyPquSrkDSjrV?=
 =?us-ascii?Q?VB6qdhb0KMKS6VTEsfs2BYLAeIfU9WklD1TabOnHOToVS78IhEIf2FoqcFfk?=
 =?us-ascii?Q?g9qvbBRTClMY7G46dPh3M8rANrUo3IpSmXLNWzpVSLOmmN1KUoI13wWxcgqr?=
 =?us-ascii?Q?gDrujurDpq5kddT1+ZiLTa+5sFD7SLQtpV1UdYMGNVsLD2ZHsdQ06F6G9l5G?=
 =?us-ascii?Q?fwOnuM/b7bbjixXbOA1cNIIncNUmGmcf6z44GC42qPq/WYR9Xi9SdOTvRPJ0?=
 =?us-ascii?Q?NRJEzInzcS965lal/heFMTbZ2ArMHLfF0bTfy7qd00v8MtbWN0+NasNEw0WJ?=
 =?us-ascii?Q?A6k/nW76Ti8+9waIrsuueO+ESwVz5Uw0gopcmobtJgp8huCwjMEhyWmISoIm?=
 =?us-ascii?Q?d7KXKNgGaAxmmRuHhIIPLofV6ez7MWQxg8jd1lA9ZPgu+wyQyJeot7lztTBf?=
 =?us-ascii?Q?D3cegjia9ynojUeU9bALYYdITd51QTMoJBzbXEauA69/iNx8uAMr2xRFBcdU?=
 =?us-ascii?Q?ncDPjMgMqaPQcguBv7bNnKzW3Kp2KYK11Js0lMZFz2BMQe3behLgeO7LseeG?=
 =?us-ascii?Q?lXjQt8Tj6xPeLz3t9OcZxeTovQZYo1myTMoJ0MnHp0Nd34fmJZZQntSyR6NO?=
 =?us-ascii?Q?appZNyKaDHjmb4CCZlPse5/0zMptqLd0yUuYRhcAyiFRguXNGBQaivKna8zD?=
 =?us-ascii?Q?LXrC6hX2VkgG9uv0yvg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TK4oGsi7AJXRsLFjHBBfNxha0q+r14hMnbGr8uO79S0x4LKtuWCrKGaAoFBP?=
 =?us-ascii?Q?FDlPJel5sZ9U/GWrpZGIRAk7l6DBtOq3S35QnNVBIfuKHW1kEjzG+KxkPf+/?=
 =?us-ascii?Q?h/h47dpwi+bk7dmx4/7AXoY4k2Q5wQvojuPjFzQy/rTbQ6t+ujzEZ7WNWm8I?=
 =?us-ascii?Q?SHLcMx0xO+8HqyiGztVlJs6H53agw52/L8oDbGL8AiPFOoZh3XBCQfJwUVaY?=
 =?us-ascii?Q?26AzWbeTZi0koC/sWsjXr1NgTa0k/S198MvIqQCG/JE5Y0Wl0TW2t6XDjyMZ?=
 =?us-ascii?Q?IODfWGHfK+trHUS2eSUHLlM7fgt2jahrgPn1htZ5Mh9AArGb9A6/jpq4rYV9?=
 =?us-ascii?Q?Dhr+fhCRux81yhq9iqlymJ7V6oDweLERJrdPDRo33DQqd8i9x9ej/L9A8CwC?=
 =?us-ascii?Q?eGQ2XyiU9GlnscHl4o0GVb28PUwzjnMUJrEONR04pH8/X7qfKniBilQvl9x+?=
 =?us-ascii?Q?MOsq2BQL/wGYhjHx56nhjafwO3ZEiDVHeB+vLmKxFj7nQiN3/A0NiithnURQ?=
 =?us-ascii?Q?HVqy5X6NrqsDW6RAY2ZyHSaRq3fxZJtCjTsJKDUfsGYflDj0QDHdlC5pLbZj?=
 =?us-ascii?Q?CnqPXs0R8IqI8zoBI2tv2eQ89CoZkBDAoWblAt/2skqs3CinD45MzTzRSnAe?=
 =?us-ascii?Q?ZyKmd/dsGwMyXODyL8+fM2w1mdJ/4/Al0ZI+athjKYSD/Z03YtxGfig6NrDF?=
 =?us-ascii?Q?wThI9nqdjtKzDvrCZLlWdgwekzUeb4Vl5vU4f+BICgAPw2E5I+KDPHqkRc/d?=
 =?us-ascii?Q?5v8iNaMhXyZkBCs9EqXVeBipOhKwU8omjDRNgBEYrUzeCcgjqFoixUbyBI3e?=
 =?us-ascii?Q?v+fwUFV7lulYBZm+WqOZXyxhj+cFFtK1hcaUQ17jVJvgMLFEnwGWgtqYoMeY?=
 =?us-ascii?Q?UP5B9z+uNbgKhIK4TLnkE/HA2/p/UjHJHYPXgFe6l/gc9xSx7eVPHVobFr7D?=
 =?us-ascii?Q?3vUDjazwbzokIqzTTma03QDy1pV9xiGww9ghd8H2JB/7XEvu6eUu1EC8CR8V?=
 =?us-ascii?Q?LarHdXxqnidF7u+gsi8aPgwG4qi3YOHbwj1RXO0tToniFhC23i149eicQRZF?=
 =?us-ascii?Q?mFi7u5uUWNyEL7vO2Q/tYB2LUkLx4UX7P/M16uRi6mxrpEjEpfS+oY6ECpS8?=
 =?us-ascii?Q?5V/CL90M2YcmLkWt4xAnCF1D5bwUI2OeSxvhDhS3NuKHkD22jzvywW4CmfZs?=
 =?us-ascii?Q?orbT1InKgd+xT8OKB+FtbUiFpoYU1zsSJuKmKjxPXt9eRO83PrQJDsGZjsyq?=
 =?us-ascii?Q?7kV84QfKUwIpQUvJmMeHaAdevI32S/11R9l/2IwtTv7fX/Zen5F1uePMQl9Z?=
 =?us-ascii?Q?QT4U40qRDdu+N3ijcs2oH/0wLt3ZgNh8WDaXezwVcX6Mp05hjELnaFh4L5kB?=
 =?us-ascii?Q?0ZSeQyyoC3CBq03nvE6SHBZdpd8yXir0uj1RHiz8DBEexEnIAelV4Kya0emj?=
 =?us-ascii?Q?jyYrYDgIX1/6ul/xxsHaQ19qnmoHe1m0e2eAsVighszs/ENARYGdmHjgzy+m?=
 =?us-ascii?Q?TrKDCH1+yNbNMr0x+f+IS24hwvee19mt9L4pa31hNXOPo/lxJkKVaPETasR4?=
 =?us-ascii?Q?SutcJURLVxH3AaB3QCj0ipwktcAwyAsyBN+vpx/L6QU684SlgjfBNScCbwVO?=
 =?us-ascii?Q?EqXRPAeFHfTO0UCmpkuUq+SFoL1JdYVyNY35ufaE7Pe+uOD9/RA9jq1tlsNw?=
 =?us-ascii?Q?zlTDAQl5nDCCcNxsRWhBaQAZU5c6NrdZRQWbsT3Z7bQL09uq4CGm05sl1h81?=
 =?us-ascii?Q?nEVmxjmg5PVMKTjtZiQmWxuwzcitLP0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F/cErJeM4dOjMTJpZsFJ7pi0MAVi80l5khQihWD4uPfHngKntFOzTDhlw34KxH4qt83ur1JoTmtqiTue/AF8uxhdiQrynogWDVNq1c3scPibX0GLIS0aUwok2B3sYgxBAsG5w2aaQ+XxR0iE34FUBNA5qmu9ExE30z2lvIr9oQZ47SVlIykiO2N9c8TEWz6qN4leqKdDCnysO/z1IEAbPkjYV20+hViyotBS3Aq4icqNU35T7lIZn+9PltE2zuqjfa2pc2HbdbRkZwH54eM8LACXsGLhQMAfVrhbwmlQbMGpxidJxDIRdP4ghk0mZZkFFWLYjivPIM43fU5W1JgDwN3jhMhcxNa6wR5iikYM6W+kCZo19Y04S8n6+9xqKmdNYWXZHbZWWU7x7wp3sK3SBbe73pEk3pBGFzGz3iJwa3yv2w0LmbZXN4k5k6PDNDMVZhwr656tJ6iF2MvSSmjQLzpnDOmMhE1fk8KVWQYeSVYb1nbQNJviQgF2YgSg/YvUpwGQqL92Ou+QCGsj2lKVGEbKTDvwFdjGGVDLKyalWAql3JDexD7cfXelUcz/2RHyu6vf3ygTjJ0mdOpVkmZUXgsuVwH8ePACKNHUNziX8T0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c90e802-22cf-447d-2ff0-08de5792e0fb
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 19:42:28.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H4FW2GbUnsyD40qd354S7YeG8nU1MpF+WtjynFtgjQzow22epm4z3hQHIYrPrTGXkN3JMKGbx9T2aKiRsaBTLVie0Nt5z3F/n88XBzaIpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE2NCBTYWx0ZWRfX6yYNAuAo+iUW
 KMlhYAdU9++BIEIYtBSVKwge4W7BlYtaA6YzBanxwtEoJg2ngS4WqUaO5rny1AXhDlyOY/PDOuO
 p0HawI/CHBM7/YSJSRFUWHtAopIVKzfyo2dkm37Z6jxHs0Ze/uKgqxMNTQcqqwbnMpJsGuJDlDU
 tN0gcc4bH8udF3JusOMxkB4vr/qEMaqrBiZynBO+9Jk22LT1B63L/2nV/axLfCnKWyq0b0TcNjx
 unQ0G5x5P7Y3ItOcYG4tbXeiWrbJJJEYAuZdiLokv5LcP2ncrViXXoQtno1dTm2qtmDpt2EKXCw
 cNcWfllG0o7SlC4MkmHDIuJhRqsHkDfJTIFM6+e/L+P18N2jDinMyfapVnZ6bSWXrcawpBx2JxP
 ensh57eLgLfo+xAuy0zlPvdK7e3S3LI2GLU27DNqFYcq+EHClYY4/9/qaEpxOlO3f+9SKUv+v67
 TSON66DCTuE80rbh0/Q==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e892b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NLVJpxZf4kwzY00CVoUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vhpXJsOKotKUV8sXrPRAi-N_zemXBb-1
X-Proofpoint-GUID: vhpXJsOKotKUV8sXrPRAi-N_zemXBb-1

On Mon, Jan 19, 2026 at 11:33:02AM -0800, Andrew Morton wrote:
> On Mon, 19 Jan 2026 14:48:51 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > We introduced the bitmap VMA type vma_flags_t in the aptly named commit
> > 9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
> > future growth in VMA flags and to prevent the asinine requirement that VMA
> > flags be available to 64-bit kernels only if they happened to use a bit
> > number about 32-bits.
> >
> > This is a long-term project as there are very many users of VMA flags
> > within the kernel that need to be updated in order to utilise this new
> > type.
>
> Thanks, let's give this a run in mm-new for a few days, see if that
> helps shake anything out.  I didn't add [11/12] due to a significant
> merge clash, but it compiles!

I mean I'm not sure what testing is running in mm-new anyway other than
David's private bot, but that patch is key to the series, albeit thankfully
only affecting VMA userland tests.

However unfortunately _nobody_ is running VMA userlands tests except me
locally (we did ask, more than once kernelci people but it seems they are
too busy), so I guess we may as well leave there FWIW I guess.

If the change that conflicts is in mm-unstable by tomorrow I can rebase and
respin.

I can't base on mm-new as the criteria for inclusion are extremely
confusing right now and everything there is untested so it's like playing
whack-a-mole a bit. Hopefully your forthcoming documentation will sort that
out (and hopefully it aligns with what the community would like).

Anyway I don't have expectation that this series will be taken this cycle,
rather it's for:

- Review
- Testing
- To get the painful merge issues dealt with ahead of time

As a result it'd be good to get into mm-unstable sooner rather than later
though since that's what's for linux-next I guess during merge window?
Though it becomes a little unclear what the tree state is then so not sure.

The intent with patch 11/12 re: vma userland test changes is to make it
MUCH easier to maintain and to avoid this kind of thing in future. So
short-term pain for long-term gain.

Thanks, Lorenzo.

