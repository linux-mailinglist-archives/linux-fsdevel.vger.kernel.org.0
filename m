Return-Path: <linux-fsdevel+bounces-61798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32DB59F41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC481C04C12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6B275105;
	Tue, 16 Sep 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rc/mtPgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0411397;
	Tue, 16 Sep 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043723; cv=fail; b=NyBmGWuAs3PpUxYHnaiEEcBS1otK+xn1l26mO+4wTXsDLyMHwYuqGn8EwhJWCcSqrUNLqzaBkC0rbIJPp2XyKJYwblmuc8qiOPv06wiTtE2wFuB4kbQKNfOaFMWF+ZoklGbaRPePupcNI+VTfjRBulOLYAihn4DG6owAZ6KXK7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043723; c=relaxed/simple;
	bh=YG4Y+jZT0bBaJN4hiyFFxcsZ4uaiik3Dow6F10Wfui4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gk5pk3vhRuhLkVdJ43oM2XG84TCE9XuiFtt1Jxj5uEHtH14y+iPNR7tCeSYlydi6ejjj0utolEfPq7lLjVImMeusWN0hHH3qUoW8LlJH7XYYtjp4D9qBybplXxXWfDHpcaE5as5/AJyS5CwvvG8n0GlwsoIjR1ZTaK9KVN5PXvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rc/mtPgq; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgelt+GhIPZkokFW0CGSvV1pC/yv8ijl96Xw0bFGwp/rt8JfqDMQx/8ls89JD7Mnffh5kBGn2dHoKns9EDNq1juCkI/FrvT4FzRV95T6emgv/dqA1hwxkeXNM+3CAvaEFw8lr3dwFgk9motoa3AdD+0spu+eeS1VpNud1y82jKtMqme5ACp9qKfquszTdEpzRy/6TB5jIyHSEJ4O/JKQxnqkLmv4Mm7iUYfiVGvjW93Q0Amry1vzHKECsn8lYwBHu5FsDGqciSIiw8LQfxVc2jEGN7KPsqwps8qTcUhma2zwydvC3Os4YxhkBW2uHLnU4k3F15MIiyGxd+HLbSumEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7B2Dvx26EpWDjI/0jhZDqtnCxFEiRJ8IR4BdGm0584=;
 b=tWnhy9X10nxOUQJbiAxIPMDWXea6o7O7GQI/FX5ziI5b3nTItOEVpmyJf5vrrreS8ZnibZn4rRcBdjjdytFIgPqK/70ruI4AGno3Wj7Y7ahatZJQ8h1ZHhDmaQMd4OMT5qBNUeuHjBCcl4QJ+G0x1Lk78hZY4S7vWtgJRNhNjKdYiHopC4+XT4cMZKmoBoamLsXMe36UEi63xeUKzWB3MUSHaHe7ty+TqobOcAP3K3ay3EjY702cw89X1te9qPhuIAQo1OXhiGkUbp51yLOPNq1iLt8FYXPeP3hTieqCNYpXr7mezrbJ8mZouHu5FFi6c3W09/k3fOlIgD5ud0Gs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7B2Dvx26EpWDjI/0jhZDqtnCxFEiRJ8IR4BdGm0584=;
 b=rc/mtPgqWdSk4kXq+rEnH3TBqpMCUKcAJrVXr7yR/8lWzFaHmrZT5zFuCYq61Q3f+OWqU9cPsszQWWC5SgzCv9oMzHO22cMS33vREAcRiEa1Kb0l/n+yUUwjaQvUxXPeAhHrJdCRowFuLEkNWEetuFNwMjFyWzsadqitLcjwKOCMFa2271/PlA8pbtrReoWQpKEGv/eY/mQ5N+7mE5utLi50PppH6ZZmymnnzFCxH3H90B15Df4HyiSFiI6IACkYQ+IlXakQXosBLtkzaM3eVucMH4g4a2dulFD/gxKsvWWMXd0JvI6xrhj8v2nShbscLMBvGPdJSAnHjCcUurNCKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 17:28:38 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:28:38 +0000
Date: Tue, 16 Sep 2025 14:28:36 -0300
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
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250916172836.GQ1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2a3317-d2a2-4f8c-dee0-08ddf546788e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjck5V4WY3RJubrpNbHRlsPRMCbIgHlXg7QPqcuA1dy08IGgUVDVbwPVepOx?=
 =?us-ascii?Q?lK63fTqm1rCt6XrLZiDGRUiMT8jCALMb+yH6zCNz1D0HUKc+2QeI18mxIas2?=
 =?us-ascii?Q?SdKZjGLM6DvSron1JNI4g4Gohd0exxAnFahaJ3YqhbfKwTfmUr3g5PqptwdX?=
 =?us-ascii?Q?O8PU6sa78cqNDDK2qhghdjO+hQpdheOxHY0PN3eOFBqPRlxL/6G+/diGwfe+?=
 =?us-ascii?Q?QTfI2bCypRjOzjYRTfcHXs9HSknCvFjZmYMd6kmxVQkWfN3FVeh2kyfxh81i?=
 =?us-ascii?Q?cRdGr8FtITDDn412d7u7V/hL7vGfgOWdfPTkNhjYP+6zkKFW8Zk4EhJR3sMY?=
 =?us-ascii?Q?Pq23Asm1GUiBn9dtmKygcvZpXZl5Pu83pcdYIHJ61/DXlHm2tDDZM1L/e+zr?=
 =?us-ascii?Q?BAPVBrywFkDo+vNKuDDXaqRMgjvbcxqfYofJPgxU4BqgjNAtnjCyJjRxwyTh?=
 =?us-ascii?Q?pdGqt+j+o5JwyjJhaPYC8MGlbP7s1rowVdh2/bUEwsAs6vscmnJA0TeW09St?=
 =?us-ascii?Q?qr2qviK3v1mGCgy7hqJKgDcLxZyYr9wqPnaOzp+QfouC3QSRnIczdNCUDS9H?=
 =?us-ascii?Q?aM2hT4cUrNAUmY5d193ZrNZBMj3LKhAIjdtPlTFlg1n8UGn/vQMX8TYJSkGM?=
 =?us-ascii?Q?8ix1PCjxGVTuB2PF15Q69+Ft4j2Uqz30m+em7m3+IpG9AlvNHShGZYEwt0D6?=
 =?us-ascii?Q?uyC11boTEqlzj36QdTG8nGG7PIqGjS7Rcg7sl4KcQ+bZfSx8XBS4fOlVamXx?=
 =?us-ascii?Q?UyGMNEw8HaMnAhtzVsKpWN4MO3Z9E7y2RjLEdrTh/3RRgHQyexfXjLhsRDnj?=
 =?us-ascii?Q?3x6K4Y3Rj3Eom9jLPbS6jX4GxdSKFCm9Bh+1EutaNdOUKugPzK9JCwipRKpx?=
 =?us-ascii?Q?qB6G+NyPfUdQO7alaVjw/O2e9HY/6ipwUcc3ez1cCW1qKhmv9Iq/Ej+sTIsr?=
 =?us-ascii?Q?seZS24YIDM7u87lK9k28LPWdILdKnNBTVL2ayMpxX3SzlIEzBjtbODjC2lSO?=
 =?us-ascii?Q?o5lEo+4nrocy0sYzsn4NMAkUI065t1FyDvwFsylHAckcwqUYoj82c+ZiFuKh?=
 =?us-ascii?Q?8GVhGpdLngnKDl0yOR8gsTL/4/c13P+vwC6/HKTiQMPamDQtQSD5G1TT4A55?=
 =?us-ascii?Q?wLoTAEakQhcR/BaeezesUbRPKgnH4gHv6Q71xsc9fcQzxSKfqsvKIKobFAkz?=
 =?us-ascii?Q?Q3rsvTFoftedE0SEPIKl4Aeb7yQmSCmHuHB8W+zHgEwURK/mYQ1I//tt1ptg?=
 =?us-ascii?Q?EIuhkmznTPGi8ZfsX2HF0CtEyugm+fdyzFu7dCJXrX3sba8tJFel+6OQb94F?=
 =?us-ascii?Q?88E9YQZAZZLQNp8DHrrvQMNxdfe7EDKSVzWNCMRjOsCqdjkEmBQbJsp+1cqZ?=
 =?us-ascii?Q?FsPB5BwFmiegElhceVSpPEPBux1fo3LC2jz9yvKAfrE9Mf1OTkYVkG2DUmEy?=
 =?us-ascii?Q?qc7tXGA4RdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTYPaytGpllb059ZZbp34qqdljkME9ObUwve3yfIdMS29ra2Jp+m4X2kZkPB?=
 =?us-ascii?Q?W+TysMLqwGgul5S/YMAZJV3XrzSQdYrSJW4+vAN7hhdYLbuxJbRfXZ+fcZZ2?=
 =?us-ascii?Q?zPVqPYRtNUImB7rJ15rvQTOxnOQsbcce5vUl7brO2lp2bAaoUs4nXsA0oEGg?=
 =?us-ascii?Q?ax4efsUytzWh/QhbFkmiCZK5hPXsSYkWPUOlbwDYq7aq4OxoMzw3TOKWA7ua?=
 =?us-ascii?Q?1i77uPfCgT95a+s598LesGOoWico95x8uyHin9skyANVWsuac8veHZCaTm3j?=
 =?us-ascii?Q?/SoeLGCQJkwC/HNOX371I6xEZoNN47OhNFDW+1/E+U4S7rsQklDB3d3vJ3gY?=
 =?us-ascii?Q?eTHu7bV8qeV5RfxRpVwPc/MkD9IgpMLmatIHSerGJq7U4dDln8JT0HpfOxJV?=
 =?us-ascii?Q?Uo1+VpqB9NxVwg4aHA8lHkXizO01n2+a5mLcMLgShweZZeNSk7BLgD1DU5Fa?=
 =?us-ascii?Q?FaZX2XW9vZgUavJ+mY5e1oDy8qmaujO7/ochcMa6+eIPPmeibg/lWWyPe9kO?=
 =?us-ascii?Q?80STfhFuyRXWhHCb2bYyFsUx7muFTJC7UdrC9I8bZeuH8Wz/+aDfxKjB3glR?=
 =?us-ascii?Q?NjLBDk3vsXZv24Y04916diaRGASj8BG+pcg1waBkMAtIZnsPOcKew2h89S5V?=
 =?us-ascii?Q?/MlXBbRfVrcl0c0rk6Moq0vZXQw1iUYa6sArlAxlwJ1mG3V5NSTRU+8PgvdL?=
 =?us-ascii?Q?aWSlI/AcamC9+f5paN8zNT8RlrVP0pTSf4g3ygHLulCtZgLZrP3KI0y0/oZw?=
 =?us-ascii?Q?ywwT1ltji+PrKGuj26f5gnvxT9K6CmakQGg7i53ag6gujVojHYkndw1jR0+T?=
 =?us-ascii?Q?x/NeefFPm+exEHsiR1PQzUUMIWjFvVWQumvjR3qc4yitrY3Sm+a7WBCUMREx?=
 =?us-ascii?Q?bPIO9cOrOktiX0bCwxSV1kHwbbre5eoq/7gBeRD2d2O3GMbpJ6iAWXRoXRGd?=
 =?us-ascii?Q?rtIKJuPYBQ1bPsusx0FXmx11UkQ2nUecH6VEjs6ivlFPsropDudzj2JZEAAM?=
 =?us-ascii?Q?2oTWNN6x17CLSryw84Up0xKrjg2f873RCCx7DhfxqmxCYOfDKJnGuvJynFLo?=
 =?us-ascii?Q?1Bgm0ahA9RFmwEOPItqP0sr/lSMrmctZikdQO4whwM8U3P4RBfxPUdzLzDUZ?=
 =?us-ascii?Q?5eyIbYRkqMgPedRhjSiWcUPPl7BXf6YrcNTHgU9yRH0d2s71Ym3It0kQlmvh?=
 =?us-ascii?Q?InEroVgYKmDNgwWmn5t3DjBWL+UPxvmyjowywIs90KWRxfOoBrkegrXB7I8j?=
 =?us-ascii?Q?+znuhhXXZ61bsQ8WCusHUoWn6v9reUefUhLmve43/VKSdzmspKE5MVQvT/Y7?=
 =?us-ascii?Q?bSaBOD/m1rQzg4uN2C62SL9H+HNnhwQjFJMDIpaOxrOK30UHccGEUp0+wO0+?=
 =?us-ascii?Q?Vu0P5LOrkCqEcfLprtR9sfOeQurybSJt+ZKsPK/hU+se28p0Ro2ggCrc1QYI?=
 =?us-ascii?Q?VvSQ88Tp5nPlSfSBGwjADZHgIk/yOqCPVJFiyq/xM7GKdr2BzZZEh7np3S9F?=
 =?us-ascii?Q?X5Fc1GvueZJJfJPAgRZmVFBKO7QliFbRiS2qDHISjRdXKf8CzrwIsI2O6xUW?=
 =?us-ascii?Q?lymJBqY+AYqKYzN4/uokwdLEMvax2ecCq2kQfTSR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2a3317-d2a2-4f8c-dee0-08ddf546788e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:28:37.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8sEjFK1EHT99bZeGu1DBEti1ai8vtQ0lxyhp4ZVqzdOiEQA96VGJQMp1HRzZd+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

On Tue, Sep 16, 2025 at 03:11:54PM +0100, Lorenzo Stoakes wrote:

> +/* What action should be taken after an .mmap_prepare call is complete? */
> +enum mmap_action_type {
> +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> +	MMAP_REMAP_PFN,		/* Remap PFN range. */

Seems like it would be a bit tider to include MMAP_IO_REMAP_PFN here
instead of having the is_io_remap bool.

> @@ -1155,15 +1155,18 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
>  		.vm_file = vma->vm_file,
>  		.vm_flags = vma->vm_flags,
>  		.page_prot = vma->vm_page_prot,
> +
> +		.action.type = MMAP_NOTHING, /* Default */
>  	};
>  	int err;
>  
>  	err = f_op->mmap_prepare(&desc);
>  	if (err)
>  		return err;
> -	set_vma_from_desc(vma, &desc);
>  
> -	return 0;
> +	mmap_action_prepare(&desc.action, &desc);
> +	set_vma_from_desc(vma, &desc);
> +	return mmap_action_complete(&desc.action, vma);
>  }
>  EXPORT_SYMBOL(__compat_vma_mmap_prepare);

A function called prepare that now calls complete has become a bit oddly named??

> +int mmap_action_complete(struct mmap_action *action,
> +			 struct vm_area_struct *vma)
> +{
> +	int err = 0;
> +
> +	switch (action->type) {
> +	case MMAP_NOTHING:
> +		break;
> +	case MMAP_REMAP_PFN:
> +		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
> +				VM_REMAP_FLAGS);

This is checked in remap_pfn_range_complete() IIRC? Probably not
needed here as well then.

> +		if (action->remap.is_io_remap)
> +			err = io_remap_pfn_range_complete(vma, action->remap.start,
> +				action->remap.start_pfn, action->remap.size,
> +				action->remap.pgprot);
> +		else
> +			err = remap_pfn_range_complete(vma, action->remap.start,
> +				action->remap.start_pfn, action->remap.size,
> +				action->remap.pgprot);
> +		break;
> +	}
> +
> +	/*
> +	 * If an error occurs, unmap the VMA altogether and return an error. We
> +	 * only clear the newly allocated VMA, since this function is only
> +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> +	 */
> +	if (err) {
> +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> +
> +		do_munmap(current->mm, vma->vm_start, len, NULL);
> +
> +		if (action->error_hook) {
> +			/* We may want to filter the error. */
> +			err = action->error_hook(err);
> +
> +			/* The caller should not clear the error. */
> +			VM_WARN_ON_ONCE(!err);
> +		}
> +		return err;
> +	}
> +
> +	if (action->success_hook)
> +		err = action->success_hook(vma);
> +
> +	return err;

I would write this as

	if (action->success_hook)
		return action->success_hook(vma);

	return 0;

Just for emphasis this is the success path.

> +int mmap_action_complete(struct mmap_action *action,
> +			struct vm_area_struct *vma)
> +{
> +	int err = 0;
> +
> +	switch (action->type) {
> +	case MMAP_NOTHING:
> +		break;
> +	case MMAP_REMAP_PFN:
> +		WARN_ON_ONCE(1); /* nommu cannot handle this. */
> +
> +		break;
> +	}
> +
> +	/*
> +	 * If an error occurs, unmap the VMA altogether and return an error. We
> +	 * only clear the newly allocated VMA, since this function is only
> +	 * invoked if we do NOT merge, so we only clean up the VMA we created.
> +	 */
> +	if (err) {
> +		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> +
> +		do_munmap(current->mm, vma->vm_start, len, NULL);
> +
> +		if (action->error_hook) {
> +			/* We may want to filter the error. */
> +			err = action->error_hook(err);
> +
> +			/* The caller should not clear the error. */
> +			VM_WARN_ON_ONCE(!err);
> +		}
> +		return err;
> +	}

err is never !0 here, so this should go to a later patch/series.

Also seems like this cleanup wants to be in a function that is not
protected by #ifdef nommu since the code is identical on both branches.

> +	if (action->success_hook)
> +		err = action->success_hook(vma);
> +
> +	return 0;

return err, though prefer to match above, and probably this sequence
should be pulled into the same shared function as above too.

Jason

