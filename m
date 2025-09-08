Return-Path: <linux-fsdevel+bounces-60527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DFB48F91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90873AB756
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545BB30AD18;
	Mon,  8 Sep 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQirvYqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302701A5B8B;
	Mon,  8 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338221; cv=fail; b=LzuZi+RN+ChIq3W1nDMFNXmlFSno7E0VZPfjqwTrRqc00BH06K426mL3sJaugfJvk/tnUl/YTKNLQBYfBDOii2rlBOCVOy5s7dMlFo7Ol0HSk5B1AbJlqWlhtTGV5jqe6eWEBoyebEhPjMZLtX1gZqgCTvUAGjj1IIsjA8s2lFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338221; c=relaxed/simple;
	bh=5Ol3xYj2/e1SquI0+A2aVnSTXvTXjtsrHfUSdvg2sqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ppAZP/INd/ESSUSJMhlUyPIeaOcgo3C4q3n0vqOO9/Q95dekHWk1sL3jch/+GkAdvFkyMZLb7loiNfhN6H3sX/Jyr9w0IO+odIt+KJg7X6kC5xkS91+LsfAtm9qWFkEZuAYtHGtzDVmVJrbaMlXzNpeH58zM4hPlym2YjzRpEcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQirvYqD; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcR4ZZAnxPL4+qjTSpLlpOpkWcqYjXVcvbLIh5fedEYBfLAuebB3RLQ0l70terCCR/ENXWMSAk6Rlx3kvz1h518QBN+o7kPTMV6/FqhUNODCT0BFsnfXZ/q21RGA25JxsudhZ/qh9+j12L1SzcIH4f7q5L8giYzH61M4RdkkYzJgpfr4gWJFVD+RUOoTVGZBP8GxCrbZINPYzJvyAKkHKI5ePB0g7sjwaXPch+Fsjf2ju/AxBSeT5elYqPiYOpQkrC0hC5xJlgZKgo4X/LOrul/LQerFLyEZ83VZbmxd9U+F59cSNTFzlL8mfMD2xrmU79Hlet9t/z0ku2LGulX51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH5z14Q7B0/QBoBKSG4ijQ+GXDi/bIgvHpB8s+ilDts=;
 b=GTfFHdr203mPZYKA4iVYDunM5nyIYdFfnSHc5pjLtqnDHdtoOGVAM5Dy8wERKXcKV99Gfh8tINsS9qWOkc+1nhx01Susj+KDvnGHS0JZoUYG+lSm5V7CfjEGUuvb6640bl6kgR9qzHIHi+v+ZgndDFWXUvV1LNq4McQ373zGtZEbX7XCIiUxu39jhQ9Q9ZfMBHWTww6lemXerSWNNOsKBLP8YBvOCyu2Af7H8MEYs6RbsO56z5iofiPAXrcZ0znKHQEj6lGuP4C3cm74Z1jGlQxaNy7F2RcoWKZ5PhgIbOzNlV2VPshSrPmDWdkBlTmxQQWdRRFbgMDF5+/1ORDc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH5z14Q7B0/QBoBKSG4ijQ+GXDi/bIgvHpB8s+ilDts=;
 b=iQirvYqDL7Hv8sZ73ab4at4GpgzzWGWlKhsmyQ5fcpFugV6hqmPSq6WqfX3dtZqoK085ei3sKhp07P7JwCij/ARP8F5vWloeDFMfxRV3Vqupx1y9Pf3hDVoG6BPMVUj0caWwLSJZGDJuSb865vUJxR5QWUTOgf7xQfcwSC9yBzu3kYO5IWQV+eZp3LX3Pep7FSQ0DsCRG9/BbnUqd34sFUiXB7qDAR1MrfqNzVKZ2Ce5VLCZcujFBU11uVi9bQDxAj20UFfWwsQqir4wPtbVn+ocK7OaxkxgCA+pKCTXG//MjClrzKQkUOq08v5K4vQA88+Hus1Mwmakwkeb5O3gww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Mon, 8 Sep
 2025 13:30:16 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:30:16 +0000
Date: Mon, 8 Sep 2025 10:30:13 -0300
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
Subject: Re: [PATCH 16/16] kcov: update kcov to use mmap_prepare,
 mmap_complete
Message-ID: <20250908133013.GD616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <65136c2b1b3647c31bc123a7227263a99112fd44.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65136c2b1b3647c31bc123a7227263a99112fd44.1757329751.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: YT4P288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7383e5-907e-4c0f-a384-08ddeedbd866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sj1fgNpRfUmLNNjPrzEpci0TKovNAgdDYgcGqJrQrDbbdWCNAyNCku5cFa/9?=
 =?us-ascii?Q?UQFgpnicV4F7I9vGBhehKsT6eu0DiGu+l2ODJJYsAd7byI0ekxZC02HbfqGW?=
 =?us-ascii?Q?bKumacH15Qh55npj6xTLLc7WV8EkriXjl0Gqpy1V5LjDTQkxESFJ3DBI6ark?=
 =?us-ascii?Q?TFWr5qJ+e/70y/zV64Dtwlt6GHHuk4Fe+zVyRWmbdRikhI2hAhAn9S8tmZVN?=
 =?us-ascii?Q?ogg/TeZWLDK1luWaL+db1RKWeqj86a2E57TtpJX0COKD5/B4q9TVGejyV6ta?=
 =?us-ascii?Q?8lMZa7I1AfmnWtscBkiJjheR8vhu7hiW4fF1Y58GYN2JVVj3OTUvGZXNDEp3?=
 =?us-ascii?Q?zEsnG/NxZK/0/6p38etAAHlFIjER6lQpt8uRtaStBTRvNGZEOl/DB358jS+C?=
 =?us-ascii?Q?eyUeJ1uwggYKHXlKGeW6Z6oz6RwT7Tf1VhL3yNscD3rsO5mUgEj6/rXMLgbJ?=
 =?us-ascii?Q?9G6kE04+0MJPzw7GHZFfZv5NhtNpFKBAfv5iPy9fvlnSNAmZ69EjHEsEbWC7?=
 =?us-ascii?Q?ufRXP0qvQMAOi/e8yeNb3Tn8g8/oeWY3GE8di2peGno7VPtDUXxoiY/LKzxW?=
 =?us-ascii?Q?aaZwUmz7nrCuorxjQhSxcliP8hBY5KZ5DUCZgUdszm1oU5UGXAgAyt6+hH7c?=
 =?us-ascii?Q?JGnVXQkbBsB9IxxBPi1H85SbTUV2vpipEh6Cr1rgS3gOVRWUsqVwDjZEhU7z?=
 =?us-ascii?Q?8W2CPpQPM12YacZqLqRUgxAcKJ3+z8zt7sXizKFrdCV+vnrk4rRej0jtzuFh?=
 =?us-ascii?Q?+rc2sAV+0/4q2dIt5Ux/4dlg06SaLe3Ey2uB37G4Y1xm/bLHjeTBky/i4WHE?=
 =?us-ascii?Q?/Nr9WoOR78DUC0wWz9z/VakFfM/d16YKLJ7+ZWflybUR2u5smWZdSNBfpu9S?=
 =?us-ascii?Q?4uIq0OZ4uKLNtAwPBMz8Qrs/Cb8MlFfG9QR2e7g8o3M0lyyv91uUG8RE36AM?=
 =?us-ascii?Q?/AF46Bi75SFgkyHxfsJzbHKTavPH+wfL4dY28qNPZ8i2JZwlnps01vgsN4Q0?=
 =?us-ascii?Q?IY9pw35pOQwDDovnqr4yDfvw/1q2Pvv7BBMfe691GteJ93qY6n14D4N7DY3T?=
 =?us-ascii?Q?LgBLNBnt9xyy3jlBBdecnL8qjlbMCycWXiRNicLOHI04XFFkpKBYB4cZVXW7?=
 =?us-ascii?Q?LfWbzZcHQciXczSe2D8agxe2TfPZ03CEeqZNC+kxD3iFIeqq9Sd6hPW+yVT8?=
 =?us-ascii?Q?GVT8LPxseQmDoLsjBP9t14hC87qvTCkxL4rEnquQ7Vhk7928O0LZzo3VFaQs?=
 =?us-ascii?Q?wiBS7PB6Nt4Cd9l+eulf9dVm1xFx0+FZJXvOjsHYswLiv0mgkdX3RZ0TMghF?=
 =?us-ascii?Q?0Q0/U7aK3jYyqMGNaB/mx/FS+k4oi7y0viAK859gn5C5GXscpVT1zvq8bMrW?=
 =?us-ascii?Q?AOzpeBYdaFbsVSP7DPYdbPA90wzITysOQBVg26JLh+XyGO9mZrAfM5BJUBqO?=
 =?us-ascii?Q?0WpUYjnJRes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/zKPyCfBe/6J+m5XEar+lXDZ9bJMlJC54ZIXcfnDRn0pfldDdCZzorCWOPM?=
 =?us-ascii?Q?f/ugf78Fkt5y+MtRJ1Y+/eIfrhbyXvi1Z42zXaw5vZkExLO9isYis5zRctaS?=
 =?us-ascii?Q?zxFTTwIkXpzOKAucI63xu3IL0rHEh4o6NdpZ7A1C3pHdEu/AA3ce5JmetZHf?=
 =?us-ascii?Q?Uzu4VwtCc8zAtXjwKrUO/x+5tPAanTQslp9vfeNcg5fltwvGF1SDRvJvRePp?=
 =?us-ascii?Q?xTAvsRWZJzW0GfRff1FonvAI2HjSfTf3vY/8hxLVXz8viy9VPjG2EpGSiBEL?=
 =?us-ascii?Q?bHpNCqzG6MoMbZQsduYUZmd20m6GUfkZIGo10tFkHfEbYX5GQTZpkpKQjU2V?=
 =?us-ascii?Q?wWTK6Vm14w23Lmcx+dRwm+AZ+Up7nHOYt0d2tFRkpHwUWVWVIShbCSyzQYBR?=
 =?us-ascii?Q?J217cStGMlEpgX4oMr0WZ2Kf+eMn0HWn5bZabRmKyDCUMjXnMxrEd9C0Ro+E?=
 =?us-ascii?Q?QMl/sDAw91eTxwp70Sz5JRQ7hkDeL8oDeirB7n2FCW3ntwtvZriHvxp/5ckh?=
 =?us-ascii?Q?xY3UGWuRGZz10kl4mQFTTu3XM99HihRR4c4jMozo9UC0mAwvwAgsJboOZNRr?=
 =?us-ascii?Q?WkDy+dRNfENvP0d9KeFlTBJlosSe+kAlJlvZWk3Llc+DIvIO1zR500ie4t63?=
 =?us-ascii?Q?cWjxd8InLIp3tDmkWhZjeVizk6KdSGxXSMahJyUtr1sFiMBgcLxTS9wToPZ4?=
 =?us-ascii?Q?2UhJW85tTN+d4XCCRhu69WlQkXgOujC6VrbOLXZLkukyuO9FXpoC158v/Z1q?=
 =?us-ascii?Q?kppvV7ZycvSvzoUHKSanGXbyNVm1W6eFnrE8aeFLyq42Isk4yp7PrDTId99Y?=
 =?us-ascii?Q?D0aMJxkXOLQ8/QWlv8mXT+Z1oftVi5+Uc0eDBmEea+e/WaE9J36hOHAa2DGI?=
 =?us-ascii?Q?G8WF3fdXpCaK5HcK94vdhM5CCnd97KWp7lBYL0Z58/RfzTZ4rhvUMKWD3ZPP?=
 =?us-ascii?Q?O9yDJMxzZtql/uC5duHKBixFQIB+Qtv85Fj1OkuVBKpEX3mEof2/Rab+p5jj?=
 =?us-ascii?Q?sgn3x1hQyR9TM9CNN8MPd/1QRWKpD0lfxfLqtdOwTi3f6BoM4vFDgon5HVfe?=
 =?us-ascii?Q?76GakdjugnnPq3J9NAMlv3YYrLYhyWZXaLKmM48IGVUwEiJgblLVehYQONEz?=
 =?us-ascii?Q?twoLRvCyChCMMIsghtTTGTb6OAIQkcSPaL1Ia5CRnNyGj7Oeq42SSaB/s/1w?=
 =?us-ascii?Q?LSWz5qecHeqUB/I4toKcPOrsi0JFY2wMYNAxKG/xf+AV3SkmKq8gXcTw0aIw?=
 =?us-ascii?Q?vsSFN775aJlxReo5qpjuwO+97Nw6bARD+5qp0nrt33yQ5cXoZ00VZq5A6AhO?=
 =?us-ascii?Q?ivW7flb4FDmww7dHpQ0SJgUtixK9ilrgZVAn2Jq2BDpyVnWotiBXlfiIU4aG?=
 =?us-ascii?Q?E+/YPyiazMWRPO8DoI92aIUrqwvkSK9uyBs3yis3s/Ghy2wZN/D71VZBLhnl?=
 =?us-ascii?Q?jm36AByUCFGFAWRvDCkHC1bVNhsiRF8xvkcy47315xq5zvf0M8wxyZZtWUxf?=
 =?us-ascii?Q?A4twvvouLMQshWrvMkruBWRNtnj5EXD9scZfk9unmTEV4zsvl1J08cKHca8Y?=
 =?us-ascii?Q?Bou1BiARRjtvykVK7w4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7383e5-907e-4c0f-a384-08ddeedbd866
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:30:15.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIPAyt1SIUharTVbKnH+ode+hdhgODYC87gyhtAj+SIGuOMjQ96I3qN3TO5FXcek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

On Mon, Sep 08, 2025 at 12:10:47PM +0100, Lorenzo Stoakes wrote:
> Now we have the capacity to set up the VMA in f_op->mmap_prepare and then
> later, once the VMA is established, insert a mixed mapping in
> f_op->mmap_complete, do so for kcov.
> 
> We utilise the context desc->mmap_context field to pass context between
> mmap_prepare and mmap_complete to conveniently provide the size over which
> the mapping is performed.

Why?

+	    vma_desc_size(desc) != size) {
+  		res = -EINVAL;

Just call some vma_size()?

Jason

