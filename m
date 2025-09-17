Return-Path: <linux-fsdevel+bounces-62030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E04B81FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB64A57E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3530DECB;
	Wed, 17 Sep 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YG7+MQIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7D30DD16;
	Wed, 17 Sep 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145063; cv=fail; b=T9n5joYlgPf4sKmg7rRQ3u7HvmzmVNMAWRPpzP2hgMDg4T4fipDY92iKglSp99d62xAmvOJttoXfz29FdX0z7Jr96x8EQ7Y5fQRP1s6onS2V2zvHjwm1vyXxX0jYtBUAIXsc6x8EA5zP70Rs37ST7jervyV34hZvxTlqS8miPsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145063; c=relaxed/simple;
	bh=A0+RoktkaRFYJWMsdJDxFRVa4OREq7QP1QfCgZ5B1GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwslq+7VznVJr74tq1jmbIXQgts9Z90FPb8oz1ytSrRDZ68asD7MaMcEdUsTSZk99exUsx1d1uTzaeb4uvcxtSECq1nVDUtdSFuWw/FQLkeiEfa8HT+kFbQAY3TXS/wA/kPCg3AvOSqafDCl/NoL/i8DMrYmbejaEpbr6Cpd8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YG7+MQIp; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B83OUBzgkp/zFKQwJ1fIwF2SWVuskrW6GGd7meOfpBDCvtJJSpfdEgoaZQ0VvqKWEg1IuAPJZ7cIQAzlraIuAHIAWpe2GYv2ATmcAP8pPIIFBgsEaXJAbPPuuD8B3YravtRAav2+FlDzegY0tfMv5WBMv86FSPBK+95lJxGJ6TmnSreifbwxq+jpM28Npfng5YoCOEAA1nMNduQXwto7rApxvYMP8p/UHO302V/vbAOsHDC2K4V4hgd0xpZn0vNhrvCB5c/hl1LV1WYVGB9lj4J/0W7Gz3RnYM3KQkjKkPXgVN9W55b7S0Bv/kCRvsDd6dRdXqZqgLSIKvdsYWp7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyW1gajqOgGqtroSrfGhdC2kP8n3cxZwZeFbKWpdqT8=;
 b=i01nfw+e9mJa/oNCq9rh5sCxc6dnR5jf90X/h7ZNzH7Id7qnpHv3E/uYokcrrbUco5U51r16lS/L7bBfxlbA71FaB7XUJCw9Zxo5oKkPGc+ndtPsZK/7XZUcsgbFy++6LUJdxNxO5nzDqx1T/WOm/Fo3FfUE3OkjcBLC66NUEZuNPIDyhoszr/q8AUZ7AT0eVNUSSH1nwD62BuYKN2KI2PAmK1Pz1zJGyaZIyBw6b2e4AmovbWXYX1gIREgZKQLqjKAwwlpfoUQz4/PpaYzKBWmSJzIdRGzLSessMZ5MwWpx3VL89Do8F5iqh2TEgNVJKZmeRbL13pWkWSJiNRDewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyW1gajqOgGqtroSrfGhdC2kP8n3cxZwZeFbKWpdqT8=;
 b=YG7+MQIpAEna5xqNXC8MmoBiK9d5G+EfuxzUuPjalbVP2ny2gsWDpB+IEk+nFxJOPzhCj/AVbZRkvRBb+nVp4yoCH3m+E6Tqo+MTu8esJL+vf2oqfPC/wsMbLDRihEuCODIzk4twAElhK5weaHONqLA74IbJPUtSOX4NnMeXwcNTFiOrcb0X2ZifVQXTJfuzgXAL52EiTK4L/Fyx/FlxGnNQF5kJHn03BW4Yi02ySh3AFauZlpkOD7gz8RLB+90EoPGfVyUgkw886MAdWXNSBiGTsmGcYWJ+ioJEFN2E8+aUNW/iazBhp3Gr4F47quJp/qEMstFuTRopfLqHlTFgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:37:39 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:37:39 +0000
Date: Wed, 17 Sep 2025 18:37:37 -0300
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
Subject: Re: [PATCH v4 09/14] mm: add ability to take further action in
 vm_area_desc
Message-ID: <20250917213737.GH1391379@nvidia.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <777c55010d2c94cc90913eb5aaeb703e912f99e0.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777c55010d2c94cc90913eb5aaeb703e912f99e0.1758135681.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4PR01CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3460132e-c223-4b7a-8f5a-08ddf6326cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPyoMde7amoXc9+S+TGTIwt9Zpsq5kbJnnBTiZcpTMEs/S0UHV4CB1UZLzRR?=
 =?us-ascii?Q?gb81MHVY0ahNle83MSg2u7UdytCN0yUbCjMVwlAZdwKjx1qK22SWDYjuc98B?=
 =?us-ascii?Q?P2G+Am52tikIxkR32SVfv3pGek1NrlRr5LXsdoID3E5dct8/qB9vGLXgnsQb?=
 =?us-ascii?Q?7x8AFk6U4ANZyKYcHdQubGo0jgNMujImLwb66Ru75qsXCYHmchl8Vijiplbf?=
 =?us-ascii?Q?TUXJbVBqh0kDlBuShmHBcJhrNvwzN5+XKAqf/WXZPeX6YFtbs3zu4RH4K/X5?=
 =?us-ascii?Q?BenbFzasq0sLDnWWg7akBD4wuCuNC8towZwJur/vVsrTkgxLfFdZyxE+f+aY?=
 =?us-ascii?Q?Gsx29waWXLHkz0DujLxRBXa+u2F/U+bwRW8JjF6m4fU0CxzO2v22K4of0/Cl?=
 =?us-ascii?Q?ziQIddebN5K8Nqd3T8aliQCPaRfF4wjjmXcCBLUF0aEkYYOb+sHRcjb6LUPr?=
 =?us-ascii?Q?AiuTlTlJiDZMG38veNFBQm4646ty4L9dCtfCq3Mc7v/dE3Kuu+1k+s30iCWq?=
 =?us-ascii?Q?AGf3motScYNtJxv6+p7toc599HJ9PqQZecYsHK+xYr1BWFv4KFk7JNuNTcKM?=
 =?us-ascii?Q?OBuzy4977lZxZcXicy0nMLETJP1G3x4RfEC4VhHPrX9S/ldTfUiH2Nu8Ob7w?=
 =?us-ascii?Q?P+uAQga6zYVf2Uscm40lR93NKkr1ZU7QudbfDHIFesQA9Yuxmdi7+ScHne7g?=
 =?us-ascii?Q?wPQz8o9ovkxPmGrJQjnmcxwJGXJv5/f+jjaUsR5WpdZ7xN7SdJEOD6+LCS/Y?=
 =?us-ascii?Q?XU9kk8ACmJR0w3vMex4QsdViEBWQULh+oE0WJKsCoMbjHsNJOLAmyke76PzY?=
 =?us-ascii?Q?AS0F4nNkHxN4+SBZcWInSIFi7r8/1a99idrna60cHqDjUkdgmozLJlnjO9iX?=
 =?us-ascii?Q?8aTv6uRhGtbmmV/AIKZfRMmeDH+fpaL8ZZeEjnGT79DoUuGIkz8xBN3Aixqz?=
 =?us-ascii?Q?JzovJfhvHtzMxpQ+efPsc7Mnd+bhCxIIKVgSoAWLZxUdplWE+0NQMcRWU9Z6?=
 =?us-ascii?Q?8NXorjsboLIJkGKuNj1WKFZPmy9WhFKBYRc9XV2jnMVdOvbrNxXDvHhb+3Ro?=
 =?us-ascii?Q?kBqkaunnu9Jx1ZTXs8PWPlVlOezunyl2kkLlpjgx6i7z+zaYc0g8iUrXb2yx?=
 =?us-ascii?Q?YC64cRhbXbD90qB0vdwdDWUGFsBFsbLTIErVyc7HaIF/GAr5M/KAPvHQpiAo?=
 =?us-ascii?Q?7kO67iJuahL7L0+jLIbC6Z2zwjhqD1/eVwLfWBDSqrcdMvfOOsc/mJc8PHHN?=
 =?us-ascii?Q?ZBXo8K4KyBm5m0n8+Q0K/zw2yiN3Y7hj+cdLZ/nhTDYrWNfdUn7GYTJ+uB51?=
 =?us-ascii?Q?/6L2qCJzLx56SHncvXh3m4hkmJYeuarRFqElCx2jyA4AFuadHN5I8m88kJQm?=
 =?us-ascii?Q?IvVMI9kcUcyX6SfmXg9EqnEkzjVxp2+iJygjguhfbw160SYbGA88P/2yj9ud?=
 =?us-ascii?Q?EpcDabwQIaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hyemk2U4JASYXelMhmF2K8F9ZEROpD3kn0pFo8FkYqJyl1BDWKwZE0QwUns?=
 =?us-ascii?Q?rR6fAdCePBAllUsMP/A1Y4IIm5Y0II4nCB9o1eUMDUeqAMaUeiRXHm9+KNH/?=
 =?us-ascii?Q?nGirTZysdGqbRJm0Ag6H0Ky5pMlid/KmlezCoQH2sPI6veiF4FfcjUGGh4V5?=
 =?us-ascii?Q?jA9ye4iSu8V7GNqcgIACzQvog2CPY6a812xRw9CrX8a8rFXhAcnGiMaMSbis?=
 =?us-ascii?Q?J+QtEGN60ClrGGbg7Hqi+UTw4pujgwe4eOgdgIVoty31dG/djTpVO5NebL/H?=
 =?us-ascii?Q?XHYMstz8g+dr8L4ov7rGBi4nZfLtx13d/3lwYJjGHPzSCghS4yv+lvr0o3p6?=
 =?us-ascii?Q?/IO74807b6yzYH7CHlHn7sH0P4oRR91JbNy5vXMBjwegpgVlKxE7Gy2OdyDp?=
 =?us-ascii?Q?mOUiEvrBFHjty0alKyjtk3k2oid7Ku0+oubjYtH12K7aU5YXSROZgRBHLp9w?=
 =?us-ascii?Q?vdVvlKAq+OWznZCUaLvl+AZPMOk95/icF30I4xzAprcsM2sB2/T2wplEqRlf?=
 =?us-ascii?Q?xxjfsB8PiPzv4rpF6lvwuBg/bIcewo+/1V/9vM5EUH6MTC9kVQBsAkF8p3ae?=
 =?us-ascii?Q?swhELocpdXl3/pBdPICyoZyDN8fL4pD80eYjSblRxUggd3xas72btVglgfRI?=
 =?us-ascii?Q?UNzyu1FNgaMuuHStaoDASTfVjMJVJmDbLl7NLOzU7p0P+IYhDIYlHd87/grm?=
 =?us-ascii?Q?N8dp1IrDt3nBaqybqI4cf/o/EXimDixnOn/FQEIztZMLEZmPXQz8Uhv0WUOv?=
 =?us-ascii?Q?HqcEbrlud5negwFlPeIJcQWcFT47no6N6l2rfRrdC7WRNDnI6rskLk9yBd8D?=
 =?us-ascii?Q?UAlC/UQSnYzSeEaiCnptfHwuTJcvl9KQAAT84xxyAzhDV5cY/Y/fmnZQc4pq?=
 =?us-ascii?Q?vO0elGencVpBkfn2y/WwdjTKUQ+1XBH5aaUfYk4Ah6fNfkBEaXA6YLwnPSdh?=
 =?us-ascii?Q?2pr04njvsdjEaThmFv64BU0lUB1jdIXO1uXBTUQmK1Ka58TWHAQxxKIAcZfM?=
 =?us-ascii?Q?YDXWXCrk8cuf92Z415qDPR8cVmReS8ZeEuGFTfvLvvAIEoAFvx8UiURnbubk?=
 =?us-ascii?Q?cvMyoQOYvCzx9evQVNEmVC/5NdldQmWNuLP/ZUwZAW8pAQp+RwuYvMTyzF5g?=
 =?us-ascii?Q?sOg32kX/E1WYJUf6M17a11QXtUiXAYY9tjdn7iQZfmBy0c1wKzCHnOsJc1E9?=
 =?us-ascii?Q?Vxtnsv9mQanJ2CDM3ipEPzkxfMpjomz8MjKov2lzwDo7Jo/i9hEuqq6EaTDN?=
 =?us-ascii?Q?uFlMBke1+BJtnLEvld/HNTCdoc3Mi4PsbMpn47C3n63Q7aa9JoGHW4J+L8ud?=
 =?us-ascii?Q?6ifj/BUm1Nou+04Fs1uEAMtV8yJrPWSIuW2NLXZGxkZ9xN7EbKGCN2Aqz0B8?=
 =?us-ascii?Q?PDcBFp38HxSudLXs1ZjoaRHR+nVV/4q4m7YOIilA8Ep0c8H8GTgcS8EboVSS?=
 =?us-ascii?Q?7vbRhtxQLyL6bWmjzAFq/tD5/9HEwClXfb+hiYuTxg6CFLbJYcfV9L+HwVEA?=
 =?us-ascii?Q?HHPvqdnN6c/t/Lh+Sx/ibqRHGgRB7bSDvPxtwYJ+HtJf+Y9SVetK9wpohWOC?=
 =?us-ascii?Q?c9+bIwhRWCwQPJkCoLo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3460132e-c223-4b7a-8f5a-08ddf6326cae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:37:39.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaoqNkjssdF4tWoj5ha9v78KGw4VtHo3ONsxUfl1lBNSFyHogO5gZRag7FlE7+81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464

On Wed, Sep 17, 2025 at 08:11:11PM +0100, Lorenzo Stoakes wrote:
> +static int mmap_action_finish(struct mmap_action *action,
> +		const struct vm_area_struct *vma, int err)
> +{
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
> +		return action->success_hook(vma);

I thought you were going to use a single hook function as was
suggested?

return action->finish_hook(vma, err);

> +int mmap_action_complete(struct mmap_action *action,
> +			struct vm_area_struct *vma)
> +{
> +	switch (action->type) {
> +	case MMAP_NOTHING:
> +		break;
> +	case MMAP_REMAP_PFN:
> +	case MMAP_IO_REMAP_PFN:
> +		WARN_ON_ONCE(1); /* nommu cannot handle this. */

This should be:

     if (WARN_ON_ONCE(true))
         err = -EINVAL

To abort the thing and try to recover.

> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 07167446dcf4..22ed38e8714e 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -274,6 +274,49 @@ struct mm_struct {
>  
>  struct vm_area_struct;
>  
> +
> +/* What action should be taken after an .mmap_prepare call is complete? */
> +enum mmap_action_type {
> +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> +	MMAP_REMAP_PFN,		/* Remap PFN range. */
> +};
> +
> +/*
> + * Describes an action an mmap_prepare hook can instruct to be taken to complete
> + * the mapping of a VMA. Specified in vm_area_desc.
> + */
> +struct mmap_action {
> +	union {
> +		/* Remap range. */
> +		struct {
> +			unsigned long start;
> +			unsigned long start_pfn;
> +			unsigned long size;
> +			pgprot_t pgprot;
> +		} remap;
> +	};
> +	enum mmap_action_type type;
> +
> +	/*
> +	 * If specified, this hook is invoked after the selected action has been
> +	 * successfully completed. Note that the VMA write lock still held.
> +	 *
> +	 * The absolute minimum ought to be done here.
> +	 *
> +	 * Returns 0 on success, or an error code.
> +	 */
> +	int (*success_hook)(const struct vm_area_struct *vma);
> +
> +	/*
> +	 * If specified, this hook is invoked when an error occurred when
> +	 * attempting the selection action.
> +	 *
> +	 * The hook can return an error code in order to filter the error, but
> +	 * it is not valid to clear the error here.
> +	 */
> +	int (*error_hook)(int err);
> +};

I didn't try to understand what vma_internal.h is for, but should this
block be an exact copy of the normal one? ie MMAP_IO_REMAP_PFN is missing?

Jason

