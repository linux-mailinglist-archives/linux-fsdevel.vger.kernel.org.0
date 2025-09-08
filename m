Return-Path: <linux-fsdevel+bounces-60524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 982ADB48F6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A41B267BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40130B511;
	Mon,  8 Sep 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oo+ahGwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897730597D;
	Mon,  8 Sep 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338051; cv=fail; b=EyQUFp9VHDePYHYKTBe4PDmNjzyT9t3XnlnPXyqnQ6tKKncHiDnRwu0fuaX0MzTd7UXbSJ/osd1WzKyd6jMdxImshCKiym+nNUC2eCx36P2OPMhcScDjFDNzNvvu8OHCSZmbL6hoPAplVMjj1TlSR94FCMSkfapoT8wwogTVBr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338051; c=relaxed/simple;
	bh=MQH1mp4/saKU7tL9f1nzT0YsYZhojxxuYjP6sKjz+fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTZfOSS29D2LMtIgjyfs0gtQagyQtOFmi/YvmL7F6V2S4bCIQnWI0Qx9kE36JU+b63Nq28eupXxlpM3XDukBrPT5U/62LA2EOJ6vvjDSBGMZnhWKkmKTOEUtKidceC/hmQaHu9DILjboIZwmcm09Skpm/yq2/DPnGXxhXyV2ILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oo+ahGwF; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDYPmDiIbM2OUCsFgBBnlWtXe0TXQnNWbsc/jRznAIb72Vlue9M3vikAQW9Qfs7gIEf5lmjPqWmcX1LK7x9KYTe4xECfN73e+SBg1s4Uj7TTP8znF9SIqGDobkfa+A6b4Zrp03J63yCx9DneF/tEy/g90RnXjzhFEF5FDQnvNUxZ0jLmjb+PmvvxVIIXSZudDKPic/Wgx7e0xAY8el8J7Sl01AcWlCSCOvT1EH7I+YUlKuQLYDA3cyEWgFiMlD0II10lqBsLmolXWHk1xTwJh2xlw9THMKNivnYQUzAdNHHHGkL52fLKKUr4GxGQvcPeAaz7jGMFlNMYH8P05Jjq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9p34D0WEtqrUL+JW7PiSoLZLSTppAYaehaQicFx1w4=;
 b=nx/GXbSsj7Z+eK2xHrw+Ml2OdHJiS2OPfjL77ZvfYVgcGRU9zhOtDgC/+2D1oal3sGiXDxKZ7iWiaDKOLEoeNEHZWogOjymmUkI39tQl9D7LbxHGYChYb2/3KRruGZ5v7u/HiZBoVS7kfpx6LEBrOOwrDpNZAbytapEuXhAIMF4P+YAfgKDOaEAWvM1L1GOFy+Z0KYG0v3wYOAw34pceWcgOO2+BeTrUEbs2x270t0biDdhB6dBgsNuC4J5vUAtTUifjHncF8tuH2Gh0ryiDDEp6Fvr99klojS/HPHIB03pXr/AiTVqsFfEjp2HhA++k4lfaVVXdf2gPGejlDzLm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9p34D0WEtqrUL+JW7PiSoLZLSTppAYaehaQicFx1w4=;
 b=Oo+ahGwFc9cKbSzZftcrBrglVn6rKZgWPKNxvlCC3bnRIxpHQQTjb6xwLvS7u8pehWX+S6wFd2SygyU6Xg+nQxfxvJ3WSvipFBWn2ComA8yzf8oe9Cxh5PdBBrOJz7xb+XznShnZ2bo+OBgY7GDF0h44qvTr36T6a+PwNevTKoeamNzVKn4QWmLCfDuKI7eoJRXgU7ReaNPh1xO4RQr/VFI/04fwLN0okKKMr7DXhFSrS5nsOfqLmJguUlEc4ll5PiZPMCqEJuTZg6jiOw0FN5yrq3YZAGD1PF+L4JgSbSlGJVX4GKtUVn+H+eItoJdjuhwkRgGg8nnOauRF7nLyHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:27:25 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:27:25 +0000
Date: Mon, 8 Sep 2025 10:27:23 -0300
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
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 13/16] mm: update cramfs to use mmap_prepare,
 mmap_complete
Message-ID: <20250908132723.GC616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <e2fb74b295b60bcb591aba5cc521cbe1b7901cd3.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fb74b295b60bcb591aba5cc521cbe1b7901cd3.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a37463-8ff8-4b86-3833-08ddeedb72ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uq9GJoqg2FneTIq1I5qc9EGmICrZKjME7DgM5L1JilcVofR8CYb7YDFGktTw?=
 =?us-ascii?Q?BnjqwmcyrdVGiKRj+k9HlcqtCK8ZILuBcarl03311IGNxP4T2FUlJCKz/84x?=
 =?us-ascii?Q?BItsRm1AzIvoiP1Djr+DESPLu67uVShjVzlsRMprzZmBK6R5cGeFTpo0Obiy?=
 =?us-ascii?Q?XQelhewFzpaac6wCJzR9u9yYB4EMYXGplpcJ+NN03Hdq+/uAMFSf/TW7yqFn?=
 =?us-ascii?Q?mDfXGGrSw1qvotDMvgzyWIqbxmUZU2jX+3FWW7y7r8T4eTOcWGRgv5oimLir?=
 =?us-ascii?Q?lcNjTkxzgskPAQV9qMtSyEkLJkhxqxDK9uNIiBEEY+awLCLUxpdSCkJMp4nr?=
 =?us-ascii?Q?Ywb8qjUblVka5h2DY+JaJ+UfgmpGXJ7FkvtbYBi3VRpMoQz2TvQAJW0COHjv?=
 =?us-ascii?Q?QHqHVtCks6768JGJ3GYEnKVA7YLgdbI0HQKpVeOP4SNj0mUuOHQN/WzahWNF?=
 =?us-ascii?Q?MPT0OvASjdNrZymt7pp7Qfep0k7+92k4LkW34J1Qy5T9stqfqP2vuf7Hy6O8?=
 =?us-ascii?Q?V9IKxmVnBc1Q+FgqdOPtkG36ciZIz20fHq+G2i43t22xZKIuUSNoCxKBicSK?=
 =?us-ascii?Q?1SPF707HEbpD0EXYc7iygdXRzpFwrB0kpvOBvXwXkhY5ZxqNBho5aGLvpQII?=
 =?us-ascii?Q?8OQ/EB92j8JAaRRahgRPA//9Yrti2bYk3XeF8BrHJuzbCGCfqXLUAwnWndQ/?=
 =?us-ascii?Q?uq0PHjalrMWQ/v0sYZ1hEt3JVQCgzJphy8dsvdtWOHUAwOefPE7CQYVUSdsO?=
 =?us-ascii?Q?8IXq/UhEHYM+poyBOkXL2xrqBsEtvSY4UREmiyAbd5E7tUn3XqgIxksCmvi1?=
 =?us-ascii?Q?o6fdjSl+OvUCxD4WYjtzTtRmCV8pHMuDQW22gEx1RfY/1U4aw+ZzH5JaCTKb?=
 =?us-ascii?Q?fhDSVzCqGAnvO9a155hqQNFkJO33hFXYBrO1u1QglovQxxPpogNkFwFrjO5f?=
 =?us-ascii?Q?vz5jhzwif9bAomGmUh+QakKvfKVZU9PXjuussbPtKhS8RajEY7qFesr9n6Er?=
 =?us-ascii?Q?PS38gW4B5cgxTvmbXMPZ20GHBhBQWq2tYXc1y8IRE2ICO3HQt20LEsZb0aDE?=
 =?us-ascii?Q?5t13dOLR2qOkP/H+GWSlr0VoOhA8so0Rd/7GS3HO9y8S2yBZU5ZmTM2J2YrU?=
 =?us-ascii?Q?Mb5mXSj0N5Tm3VLub1+Swc7QL5ZjUBsbJHSH8YEKzru7bs9Z0PuFjcXRj5l7?=
 =?us-ascii?Q?7G+dNWxgOVIz21sAFfEkfIdg/WYmaEuwU6Iiilc3F7Sl5t9k3RusI2FbYdOk?=
 =?us-ascii?Q?UmKZbbYVKpmkIbnndfH6LfDDjIGndXl3R10DlFo73IxCVZa+mNgbaueQGmbO?=
 =?us-ascii?Q?lpPUj+qQSQQp0Y3IaeUQdHhKiEoVdO77zV9NI/M+kZKsY3bmmRYKmtRKV1VO?=
 =?us-ascii?Q?AKf22GJa7vG7JRI0P0hb2bKu3XadfAPvuTDkolL5L+Woj6g3nrZ+6d6NkvCY?=
 =?us-ascii?Q?nZRz0cGyWzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SewSrzVnveYhBlHj4DOX8dh6GBYMOvrr4kk5DK15mbbciiVOB8gJDPiraubr?=
 =?us-ascii?Q?HXsVpi69CbNZqpL3cXD9QduTlXk2ZvzmNtg3V0VoeCFHYtgaxxZ9kygj3GAn?=
 =?us-ascii?Q?7MSSGsTsLdfKRmOoQTYZVrOAvcCyH3z5xJuVUSyGgdwa84vXtBwd0UWf+wEg?=
 =?us-ascii?Q?oOjgCQHS57ZMebDWVOXlB6GssDJDIQakSkPKqU90yq2x7St3qOu2M5iEUOrl?=
 =?us-ascii?Q?zr9S9ozvjZ/nal1X1ZPqce7ckXrfAzt2JDcGROH2AiB27g8qq4BGibmw8Kkd?=
 =?us-ascii?Q?/vm0FdrOgD9eNi7qcNV5/N8xukN4kkBj2AbcwlevOOulJ2/bnrBEJUZfQex1?=
 =?us-ascii?Q?gQR5miVycJCdpjOQm1QNKg09ov3pu2cirwZAMOl/r1/HP5OjjuEcDgPNpK3p?=
 =?us-ascii?Q?90Z4QmM4M39eWsXdzs6pjOb+MNbQocNVls0v9pe8cerBfBi3Prh97aLD5vIL?=
 =?us-ascii?Q?4vaf3jbqL28fFoh2r3g1mRtQ0+dspUI1SHvWHk3D91m2DgSPYXBYTitPNfcd?=
 =?us-ascii?Q?TgSVeTnldXHS8BcBzW+oMBvdTTIUef5Umu1jx2mR8HvSvs/k0bsu1yfTaOcq?=
 =?us-ascii?Q?w0ZXV2WwTMDhcyqgeBZbo/NerihQnVBn4P0E0MJomL5r0aKf+CG3B6ww2bMp?=
 =?us-ascii?Q?VzoqT7ZQd3ADLc7tKAPxJLpIosvTJ1cbZwHYfpxlmRT17DZ8jATbU+h+PXOf?=
 =?us-ascii?Q?C3UxEPsXHCFstlqQx8INwvFwCK2zzvS/rJBuqn2ldkgNcQmXRAuF2IfJNEoy?=
 =?us-ascii?Q?h+06BzAJ6oygktQPox/D2cuBQn+ts0dlZxmj+dWABloz6ioTRqHtYnfQRKya?=
 =?us-ascii?Q?VUGKfC4gg+WeacOyDmg5x3uZaEcBduSWJg/Vj8nFWoEqgbi7iNyw7k0pKP+s?=
 =?us-ascii?Q?yCh0Gwc+1CMKMyTc1iz3LeP+qS4i23W2KSiD/t55zvbvafl29krji2Yp1k1j?=
 =?us-ascii?Q?gILxgVyclnMSOYrzG6R+t18YqigD0OGX19F0oYfvnJCGPWdhIwktWQSVeYzr?=
 =?us-ascii?Q?VtCZv0y/kz9y+7GTuJ9yZnmJnYWRXh97DKC67thLZ4ef5ilmRe0ZdPZZPGFd?=
 =?us-ascii?Q?+xU/GjZot1asIXiHFYHqfS39B1JMK7crvSqrgMTWpX7EOmtdTBi/eI0aB6dv?=
 =?us-ascii?Q?cUzudueFqVD7z+dplfpLoJyCLm+VNkG9wVEodOuH1bsGun1nObw3q4BEkdZG?=
 =?us-ascii?Q?bUuyOF8bDHj5sdKIhUOBu6dHeKbPR09N/6VnCYUQl1CecHuYSrAU2dO8KoXR?=
 =?us-ascii?Q?0OcnhdbNiuhk09hc/1qNTABLvIErCSkCrppdRpUQ7eEe+O57a9WnlzXi9pe4?=
 =?us-ascii?Q?cDx07qGUU5QtRYq/YE4eDIYEaALiLT5MENNObwTJC256wNk4bV+L+vQDOQXn?=
 =?us-ascii?Q?zOhbOj3O6zVbc1SE7ST8QXtUxB5auUkm/bsD+xiOEFZPP6GN7gQIzV8NBogp?=
 =?us-ascii?Q?l4aPYy7+/wkMfI6Xi+rVws9iUJmdAdrkdON52w5GAgmUiAJhe64vloFhTovW?=
 =?us-ascii?Q?gRBELjri5iFYmOg8OYUFUxlWTi+57vT0a6WPzLEDpPPfY2q/Pcqb4MmrnNtI?=
 =?us-ascii?Q?v3y4Me/3whUHDvzLsM4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a37463-8ff8-4b86-3833-08ddeedb72ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:27:25.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCo0VXeHpyMrIO4wQH4i5/iTzRUaewESYbg/CxPLYZsdUCEKv7Pg++5MWUWx96Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

On Mon, Sep 08, 2025 at 12:10:44PM +0100, Lorenzo Stoakes wrote:
> We thread the state through the mmap_context, allowing for both PFN map and
> mixed mapped pre-population.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/cramfs/inode.c | 134 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 92 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index b002e9b734f9..11a11213304d 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -59,6 +59,12 @@ static const struct address_space_operations cramfs_aops;
>  
>  static DEFINE_MUTEX(read_mutex);
>  
> +/* How should the mapping be completed? */
> +enum cramfs_mmap_state {
> +	NO_PREPOPULATE,
> +	PREPOPULATE_PFNMAP,
> +	PREPOPULATE_MIXEDMAP,
> +};
>  
>  /* These macros may change in future, to provide better st_ino semantics. */
>  #define OFFSET(x)	((x)->i_ino)
> @@ -342,34 +348,89 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
>  	return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
>  }
>  
> -static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int cramfs_physmem_mmap_complete(struct file *file, struct vm_area_struct *vma,
> +					const void *context)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
> -	unsigned int pages, max_pages, offset;
>  	unsigned long address, pgoff = vma->vm_pgoff;
> -	char *bailout_reason;
> -	int ret;
> +	unsigned int pages, offset;
> +	enum cramfs_mmap_state mmap_state = (enum cramfs_mmap_state)context;
> +	int ret = 0;
>  
> -	ret = generic_file_readonly_mmap(file, vma);
> -	if (ret)
> -		return ret;
> +	if (mmap_state == NO_PREPOPULATE)
> +		return 0;

It would be nicer to have different ops than this, the normal op could
just call the generic helper and then there is only the mixed map op.

Makes me wonder if putting the op in the fops was right, a
mixed/non-mixed vm_ops would do this nicely.

Jason

