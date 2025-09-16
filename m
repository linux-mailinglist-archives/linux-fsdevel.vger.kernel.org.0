Return-Path: <linux-fsdevel+bounces-61807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE2B59FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD523485B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC1323F4A;
	Tue, 16 Sep 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pL+P+FqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3130FC31;
	Tue, 16 Sep 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044437; cv=fail; b=gLA7XC9V3AVpMqjLeEsao7axmS7xDt4OVGhd1bMTveEho1zmi7rFe8p/7OANc7aZY6Mo0qH1OgDrNKAVdDL03jTliz3EsvpfM+0Pb06fFoCU6I5Udh6zmup7FwQMQHuv6iG2TfVPEYUtqkO1WSKTeSEzPWud/EiF9tSEih7Q91U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044437; c=relaxed/simple;
	bh=hda7Z/v3mfLjOj9AlMj1aVe7pFegFpqMseMdYbK6+KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNnC8QuOdxqtUR0UK2CHiMZxiHWACfvkuKYn1+NGm01X2ZHnp2Rw2ERLQH4Ue87doEdVWVGVrWXZLLN1qR0OyFjsQF98gkXJSnSadrlQxZcWsXqdjgghqOhHmaW95XaHeqJn8WX8kiNKeuO51FPAUGESGyTkr8Mz6H3rC7UzzcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pL+P+FqA; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBgA4Hg1sov6XB3H+Dyfkvlo7JctE9hLSbuhC8CrcDy8EskXn5GhheflqXaJOPIIQnLZouyNmxxw/4j6hyowcGYFEI5+hYJZLIje1pk+UF9zzentynHBmMdbFnyhbbmzYNPmpqOqHkvrmifn7k5Pj3j4uHsYocT/Y/Zsm3KmrTIFOIVJ//KFKh/lEcNBdGFUfwi3H9i6dC9N+jxeOBnV6Mni8VXm/I+oEtdM6QP4w46LjJmA/P0OzxrI3nXo1Wqyl4QSgtYFam/9SnTQTuzvEXorsufvwF+lm9bvmgkW+zoUGZKkpelolwX6QcXutyxA5w/3DI/aJdLZ1kj860WrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuOm7RAr7ULO4gzMgfQKYRi1nq8gzxqXtlxew6kKOQo=;
 b=pI1svxL9HSDh2zpFj5thW+L5LeO3yInWM8Pm3ZEaE1qDTGZLdl3GlNN/NUJAWBlvtzP8rwpR2RqIAFzd2OxFWN0ZbilSr1ff0P/gSqBj6hxPx81A9GhcpC0/+43D0ld+ASSKjwcLqOkxKkf+d/fsuXzkpZQbCK7EPm80YzhFVnuMERV0w5WqkIqvDJgJD8DFDiB+Zlo3wilkscj9RcpIO+oW07q0z6PX8eAxfMaq0Legaok08aOzo4E0DdIyaPt8DZXknBs1nvQXG8xgK7OsC0sPQn2K5rRQKW2GCQNoyMulAxMpN/Upr9OioJpEDE9lDADlmPel+WX12Ej4p4pPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuOm7RAr7ULO4gzMgfQKYRi1nq8gzxqXtlxew6kKOQo=;
 b=pL+P+FqA4e8weWctvjgQmF5DeRLa7lDJs+kQDw9ozkIvgIcivo5dXnjRBbzGCOIjDUgoElSg2R5xDeoXcDAGty818IvqHI1Ln1oiSG5xrC8IKbEK3cW+im2StQlqEgkpucTNVezqBRTbMWGbuupWJOhYdZQbUX5UeuaO/0i2iSlUnvZXxLXx1CRQ4cAn1YW0kqK5VWGMF5YPwqjwLDibBOK5ny54DvCIlGX/6jjPHMBuT0ZAUgrNxEeUL/lARePwu9F+HITq2wvDcuPku5xBStes34mrBJFsk48Dvnm3xWb95zDaMBrfywQ2dBLY/3HgeabEbtjagllpuU4SPKyBHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 17:40:30 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:40:29 +0000
Date: Tue, 16 Sep 2025 14:40:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 12/13] mm: update resctl to use mmap_prepare
Message-ID: <20250916174027.GT1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <381a62d6a76ce68c00b25c82805ec1e20ef8cf81.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381a62d6a76ce68c00b25c82805ec1e20ef8cf81.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: BL0PR0102CA0050.prod.exchangelabs.com
 (2603:10b6:208:25::27) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7453cb-6f04-40ae-ad89-08ddf5482099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jOUMyQKJcTwCYdsu4ieFTku4iJqky1IW1515otgkTCMR3Nulu2xlCmYl2GuV?=
 =?us-ascii?Q?perHlBRyjVXKAYyfHD8j+RYUx7HwBqIDB2+UCx8N7JTfGsV55zeq1yFEmYKl?=
 =?us-ascii?Q?zrbuDHNLkbxTlFxUDHh5AzdXnNFth7HFfhkBFh2W2ld12PBk/EaqToEPoj7V?=
 =?us-ascii?Q?ZwFyGN9NEB1KvqJ0jK/iQhvPihUy3shU2WSlsQG5H8+f6vv1yyJPfgpDPFuw?=
 =?us-ascii?Q?aJvfHhL5XxCXAAMtgkrCDYkL5/dJQ/JSPzWZQPCTX8hwxsV8VCWQReLgqRz/?=
 =?us-ascii?Q?LnI9ZaLz3bLihFFzD3kUexAp5/U/cXbPyesZCETCtc+VRGtVgBM9zNm42LNB?=
 =?us-ascii?Q?YUf2LQfQH/E5pBMYKJwPyrW4V1W7arLibPi3mlwuoKT/UY8iUitBCSfjRrp4?=
 =?us-ascii?Q?/AJS4WJze4ByC4jHHE5h7PSj3CMtl6ddXsfwXBmvqwFf9vxdIvOCjviW00Qt?=
 =?us-ascii?Q?JREuFqFXYXCuM+UMaEMBe/sY+bLDOjhAu+YQzn8v6lkR40yG87oJYrLlUqnU?=
 =?us-ascii?Q?DwSY9P1msB3BcTm2ACSAUNlWUAq+sw+s+K3JuvcBDIjdRM26lEL2W/Vnz75x?=
 =?us-ascii?Q?LpMX4yDek6g8NPrGJzI+7GkpBTlZqKFjvPDAp4Ow0IVwQT2jqn7cEUXichmN?=
 =?us-ascii?Q?AlWuAtHZarbinb4T+taQENAVyKVLzrxY5lI1PaephN3RLtLnxhogMVqikQRs?=
 =?us-ascii?Q?+B3fErB3c6CzS1wm4NT341tTX2T1CrC+B0oq5pVwnOyh9FuRnc/MCg5e66Gs?=
 =?us-ascii?Q?QDB19EADO8pqIpZ+KQmPmup5Mw5aSsh7bGrzkhqVfqpKfwg20Hjco21PCz2Y?=
 =?us-ascii?Q?N+Lo+M7XSkNiknUii7uFI9yYTv8uNimfGDZEfVdn9J+ICf5iOSAkYrMb31Pk?=
 =?us-ascii?Q?VngNHhjloNzwaJTxlJetD+a3pevZWqlfQNHm1+w00tSvBFqYj0454W89TOfq?=
 =?us-ascii?Q?fdhwkCaHiWUlaeybq+r1lRp6UfBrS0pcYN7dpyEkIMWXPdIlYxJAjHmec0+H?=
 =?us-ascii?Q?sa0Ot3FyXkMRZkgrq21mGaaE/ihvhyR9g3RARJoSU78mTB/j18WPTR5mSFt8?=
 =?us-ascii?Q?Llvo7oKLWZU0eKyUZSJgnysBHlm8j/2TcvFIqFrMVzEiIRfpw3DxMK0jVbBG?=
 =?us-ascii?Q?bvjaHApP4ZJWU3sVOEcxsmsKOT/3lmn1D6746m2DXaNNXahcluVUPgU6unwx?=
 =?us-ascii?Q?kWdx6j9I+TZD8ZUym16BfhhVi5cHwDYroOTx0JmMogs4N91VOvcjWOmr7oAH?=
 =?us-ascii?Q?la1QkG5s178WMJ17M313E7VE0qOYpYOlQpBrV7is+5OlV8GTkBL3VnbTlMgh?=
 =?us-ascii?Q?KOLIQV05gg+cv/AUgidDUkFYA8+UsmOv+zADids3x066mL+6bY/TIrB+P7YU?=
 =?us-ascii?Q?FqNPC5ARTJRPtL1kQiNgd9aTaHM87MPb/yb0akdXrZhniriT4Jz9uCyTaalx?=
 =?us-ascii?Q?lGLQGziD6Yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdpyjK0FiSO0J+4AX4wH6kdK1JYSjeAeAvwt2qL7AVcAviDeHpcE0eYtcL7f?=
 =?us-ascii?Q?VwLGjYiaD/dsgPpMbM2gV8BqW7jewIv2Gd30wv7xr0arAMTsQLz6lzsMorOr?=
 =?us-ascii?Q?yd4WHtQjqpBrgXkz/KCkevpkZmpCTkaNYuIfRlv82pmvLM6pyXc0ctaYNjTT?=
 =?us-ascii?Q?KXdcLHpmIyUDLqPUtX0QTxsjHoImJ3zy3LPC0Ef1kLV44WHEB8vNLrjgOFaU?=
 =?us-ascii?Q?Kxogre4cvLyBlu2L3TmT6Zuvl9TrUw+9v/hpWZr1r3HDA4aGqXws5B4CVOTz?=
 =?us-ascii?Q?OztW3L+ja7dPX5y9k0XVY7AwZK78D6vmhU+gSTobMFncPBoaaE+oTaFJ6GzM?=
 =?us-ascii?Q?UBjaYBkSXPTaPV5ZvPFpWLvnA2sLaq3PYrxVhw1E6Np1rng7PjdhSw7OqxYt?=
 =?us-ascii?Q?ZagYNcwxnt+dST9ixQgqAqykkaHX9OBlKBzmzDecgglj9kO/xbflURn90yJk?=
 =?us-ascii?Q?c50zWdrxXyic8rlAcCHY0NL1LKpgkMJDRlTPYYEJVHXU3BRPjnCidj7KrL2f?=
 =?us-ascii?Q?BxcX1FlDAFGzIUJ7Std2wLyx87ysuGgApVFBmi447+yfOeSpdzfsxsh/Plax?=
 =?us-ascii?Q?3caNoZ24khup6xUoRtMO5xO2Ub5DEEEriqbEhG1+vYY2oar5bHIch7BE/599?=
 =?us-ascii?Q?Cg16b3jQ9qQ/G8ihfBTA7Z3a8R+FhZNxzrN8AkU07Coj1cZf1sMQupIoyb+v?=
 =?us-ascii?Q?/A25rsnft2gHcCK9Le2ZvFxp7YUCoDQBo7WDhN1h8YX5hUm5yEE+lAjQlYw9?=
 =?us-ascii?Q?mdFBvJ8nxM91J6+7cVGuU/et4zXZsia2Jp6lHHvMQf4NGplk7qAqTtgyoQQo?=
 =?us-ascii?Q?kdU2s6FYtNAoflX+FoVdAeyWEa1kvwgL/g5EW5T8r+0o/zeQF9JPI3u8Myqk?=
 =?us-ascii?Q?ePWMSkMI1S0RdFz40vdWUA2vUwZn47bNFw1ZT59ggqcn+JIndx7WAIsl3w2A?=
 =?us-ascii?Q?bAQW0gCSCQD0iSlUkNND6qlHqvGB35EReLqdbIZGh8D/xkM9WG6VyT/+180u?=
 =?us-ascii?Q?2UBKHCCcKHO0vEGuq1Ra3NZo3x5BrM+4+StGDNftBk+GQyzSvffKYV+Z72rG?=
 =?us-ascii?Q?SO9f2QHIqSy4aVugJtjHN5g92IzupR+1thp7+1VJzRNWUxaMUJXp3EIs6/Uk?=
 =?us-ascii?Q?SFEyEUXIb6U9jSy1Zrr70CE3jIchUnD5VIZBLYNV+yHids0sykOSPzJXWK8q?=
 =?us-ascii?Q?WqFdIGc88XBsIw9F0EUmrE1tI8fX/RTxdlXnRAV1kYMP07DTT7seLTXtdsQI?=
 =?us-ascii?Q?1PGdbEfJz5e+Q3rsJn5Ca24+WtbMsUy97akAzcgoCXODbLqY5WLPM56OfN/s?=
 =?us-ascii?Q?y1uJW2PvU2hrP6IRXBQTD8NbkHGRnrIibC1d7p1Ds0dD+Behd284xxaT2bjs?=
 =?us-ascii?Q?7YFQf7qYa4vn1HEVvywTuxM7d7UuKx2FxpcwvchRhrrxYaz09wIqPxH1FgwD?=
 =?us-ascii?Q?RNivrQLaLHsYUsHMnZ0uno0FsTpaWFbu3MdEBo+ljf1kiDNxzkCfELA3qqcn?=
 =?us-ascii?Q?T+rcTTU3Hs6Gi/WrFiP4PtxLAAUmK1xCrKE2Q2pWP48heB9w80O/4NORamka?=
 =?us-ascii?Q?EziSsDQS2XQWnUrAMyVegUfIQFZEEWgGvM+JlH8P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7453cb-6f04-40ae-ad89-08ddf5482099
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:40:29.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrHnireU+CQRAOmXYmtBwasgYF3N3WvN3x5h2upeCasL8XWg26inook7KFoAIqHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662

On Tue, Sep 16, 2025 at 03:11:58PM +0100, Lorenzo Stoakes wrote:
> Make use of the ability to specify a remap action within mmap_prepare to
> update the resctl pseudo-lock to use mmap_prepare in favour of the
> deprecated mmap hook.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  fs/resctrl/pseudo_lock.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

