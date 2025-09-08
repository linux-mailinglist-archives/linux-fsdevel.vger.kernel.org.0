Return-Path: <linux-fsdevel+bounces-60552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41004B492D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FD13A511B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D930DD1D;
	Mon,  8 Sep 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Npo5um5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE21C07C3;
	Mon,  8 Sep 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344611; cv=fail; b=KfTjQWwmEmUYohB43Nna1G1rFzo947sTJUn2R1W8xwEn28bx8msuMzS2HZrMIbAnkh7M6Z2w7R/HkQkBNAnO+ZZd/H+ruyV4bKnr4fNHeU4Jq4K01h3+HmY+OIPI2k2gqcwvZcCaUz8LKX7WU03uWhvhBEehMCRv2SKAmhRK/FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344611; c=relaxed/simple;
	bh=oVmtvQKl34IJBg0XteiS0pbpvTxYgfGnBAKEsgwfI2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XT+UdhtecoOKRij49TEv1Cjz2/1A7+6H+zyWEMbhaL4C3M+s/VkB82/sU0Kx0NOsZ+cBB1/Hkij9fmc04FXfWgoonoWGxrdB9dUmvrmevP3NcY2saukN+bE8fUgfgJCRInrW4soPYcterk1tGLs2n9Enzn6VJ55EHJnJzFBcLtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Npo5um5t; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evDaJW2LZB0GdQBs6qDQ6zy5mLkGsKnGa9EHmoFBDNsBlUPKSy66+k/dQ53CFiTF3v1rhCu7DiASId9cGWA6f5FUiFYfI5QqcGaz45HvMiRsZ9mthC15U42dGgZiih4keozSOEyb27ml/1JBSpsEMS8JZhugRYtwCDKnarVRRbsBX9jZNYwfeiCtxLAjm8/AsWAK3JZb1xLGKOd5pb9gpEf5hpPyASTruEw5+aVtwiz1SvEQcFFrwgLvM+oQsBb/FB5Jo266YofpPXQWsrJ1y0ENznfbyH7tfL6+Tq91Xhb9V5ljy5REt46zOy2jIy5TKBCrAu/BpVhVuoVz+XystA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j/RtS/D+IIx33VOOVem8cps3PsrXPIFRtoMeCJ3Q9w=;
 b=nqneYLwtfD4Xa9GqBrIalAVls8ucEuseXMwKLAd76wg5mT3RMdfbASlb9ib/d3AyWlxe6PdNQr+nBM4q+crd5q8JKtHpcJEOoxi9DqPJNpuuhwGSi38mwFzIjRH0NuvBN0+RK3UFx2t3u5AsXVahvduiQW1BGSxLro+an4zG1KBXqxf1c1ebjUAm42lRUCK7NxHTy8QBnRTOQmSQkRt2DYvFkPBq4k7IRns2TToEhcdatFArHjLh9t/pBmRy/dhiuTHQLXaUEOtLMJlYLyn40pOfFhQSSpRt2ardLie5o2OZBx0ROmpgFqxX6r6cXImgFucAXuwUcbpmD6HJVtPg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j/RtS/D+IIx33VOOVem8cps3PsrXPIFRtoMeCJ3Q9w=;
 b=Npo5um5t3z7qxhUPzGY7iujsPh0w7SUz8nx8i/blVlrxsOTXhIxBAlzXW9n/7JrluZiMLr+pv2+IWdfLEUppAMv2DQMft8dmWQIe1/pz1b/IQoGVyx9XQOwN6MkpyBXI0hhn0C2tV7CZCqCIWnu8k+7pVNheQZl9dsuIoSMqtRvpxyIJV+Z9pvm/nsukhyilF3uEV+RIPccfzk3GkwOnBqfSZhaXAqlsNAL0c6vSkzCvQF8Et1k3zh1CghvOBf28Kj6ihDXfILDM9ObG16Rn0hBu3/pfBMFK3kTSDKpDiss+tyfSS5ytZO3g+5immer00J1rMdbreUKwYEd/gkE2/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:16:40 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 15:16:40 +0000
Date: Mon, 8 Sep 2025 12:16:37 -0300
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
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <20250908151637.GM616306@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
X-ClientProxiedBy: YT4PR01CA0426.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e1bdf9-7d13-47c6-08d6-08ddeeeab608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GEfq8SK3CQoWgLi4/E0h7epeMmhnzKB+QTpQo3eRU3bCNz1YWdn54d1egOKQ?=
 =?us-ascii?Q?ouQxI7idFPmgB73D4qSmfeoBUsM1OAzRY8AtAOJSuw7EFVACU82/8CWfYpyO?=
 =?us-ascii?Q?oJsZQRx/1AGgDxfUJNYln3ikVNZIT+EQzK0U11RkOoQvJt8dHxzTUoDY2oLO?=
 =?us-ascii?Q?9m42wZXeyIwBMl9vXywWJWr/m0Lw6dhOJbPTR5NxrZtJLM2w29+8uB6fGVJQ?=
 =?us-ascii?Q?EIkrUuFB9w5+4AFXVmgI625pVetMfJQrNPGZyMpVjpM+DvZBo+dQ1XVQv99C?=
 =?us-ascii?Q?jVt5RGt2OhL7trHj5fu9dqpPlyYo+AhCC1LZa5coH7iIpx+ZVDQ7MD6X6Zyw?=
 =?us-ascii?Q?KICtskqJl8vQxVoQULB3K93QD7mRRoJAWcK5a0siolfP9uzPXJQj1Bufgvdj?=
 =?us-ascii?Q?tr8puh+d8Y9cgnJ2nBgZ7fRqUDV8UpVWIXWHSWrpiUM3heay/UOq4RWFs06F?=
 =?us-ascii?Q?5qZofKxCO4P0abqSxqJD/Eu5MU+HcgDEpwWoLs7esU0GWVXrZke7HaBImsKD?=
 =?us-ascii?Q?3ers6g3ZRkMKPcV3wd4GzHtkVJuCQJPNeIj7zaPf4our6Qkx5ZEiWpl/4EGi?=
 =?us-ascii?Q?x3Grr0LPDSmKfUM560GN7IYK/eaD1hTpDHpQPQzQsEDxT3zIsJ6PPwf6bws+?=
 =?us-ascii?Q?rd87SiKdGxH8meqsWDmlxGCZ0hmOmLqtGoQrcW47SCkqS/0yrQ5SxIjqcbLl?=
 =?us-ascii?Q?Gm17ReTYqCj4S5XZ7Pqg0uZFUVHNjdxNyVKqWa4pdsy4uYr5ChLAthJae/uy?=
 =?us-ascii?Q?oXxo3HRPlM9iT3DLSS9v0JI4s2osQtdKF5o/EtVJSxBOps0ys7crsWaRa2ZT?=
 =?us-ascii?Q?NY7RXtUHFT8vZ2nXKYU1/i8hAWP92iL6c+3ALGC6CxPA1kfk0mMWn5r8QRnR?=
 =?us-ascii?Q?aE7wtnXiaV9Wn1VktKE2F6TtzkcQgCyuTFOCUVqurJd+vFt6l82WJA6YtpnO?=
 =?us-ascii?Q?I4QyHqKoCRfh9h08V+jKSdG7oHazxeulPAR625JZuvZC0MRLDKKaocL8aAUQ?=
 =?us-ascii?Q?a034pUt+wOvFhDoZRcXqkftuSf7IuFH3ql4XTEJaCQ4DQypc1ttTvL6i6HZL?=
 =?us-ascii?Q?ESZl5KHq9eDfWKjH3GDbdC0AzDqURDXuw3fcg4rWlUgxqK/gywAD+E4WbmJK?=
 =?us-ascii?Q?wv35RR8xGwiLegY/A6XmSrbmKISrMiG0XzdfqDnbEjCjIQ8G3iTu8KuOEE/a?=
 =?us-ascii?Q?ZlrJDRhNpMycj3fpnNBv7l/AGXrZAHsP4hCq0yieqPWEed5DFybIjMH+M6mk?=
 =?us-ascii?Q?x9ApO7yN1h/Hd7o3ks0K9XU4J5arFOyXpDynvP31xpvxKisWKxe2jb17Jt1J?=
 =?us-ascii?Q?a1kBoxoOTNAP1Tx4+W0uipZ5ML/BwEZU8r+3d0uTsDB1iiBAWykrp4jSKF9p?=
 =?us-ascii?Q?FM0DWu43708giy2+Eww7dEh69nXIY7MWB4FaJ/lqepEN1IQS0p/8J3ngyoGh?=
 =?us-ascii?Q?9en5VPMv+ao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7FJCsWxOPBRG/VWdY/N8zALehIFQ036c94s9ivCv276zNmbjChxo2KwOsFYn?=
 =?us-ascii?Q?XqY0q6mLY5W2Yx5ZCI9G5ovb5piNzD7T7E8/TbZneRG3TAIRaZLHZWxR09rf?=
 =?us-ascii?Q?ZruImfcUfHQs+TRilvAaBzBhYvKaWsPz6inNSOWLsmXqkp+8RWa8QtR9bmMC?=
 =?us-ascii?Q?262VXRnY7ye8fTxj7pGuRqjpP9wBpjuXO6HbAxO1YNQ0zl9b1qkzE/nGQ4Jy?=
 =?us-ascii?Q?yS6VhNzoOZbzcLKyhNQA7QvDSsl+ZWo/tFg07T6afoCzyKX4vRzGRjoj31Up?=
 =?us-ascii?Q?kCFtmo8ZlxpWKq5EmPkb0p+wBWiV7SEFL825r9Y4P4hhk7zhwnmRz20HVFpR?=
 =?us-ascii?Q?A3NNIFn2jiEEXS7sJ1YT5Npf7SI1WR3q6Sx2qcoLObEVmg1AHUebvbmwshJ2?=
 =?us-ascii?Q?+IGWddmnOOx3/mYuaM7mFh1ciq7C28LiNxMvRFGqKCaX19qGoYePzNcCMU/W?=
 =?us-ascii?Q?4W8EcvNNgLHpTixbaS2ivj0ZkS1T1LzUNlvn3OO/k9mYdqUZ8Fbb8zKvkYWD?=
 =?us-ascii?Q?XzbcvimnUCM+FzbCi2wCBYTCtGAqGn/vT/qmbjnInjxH5JZbcrBNLTusUNC1?=
 =?us-ascii?Q?YwIrQ/nv9AOrI1qm/OwsQD9ORqdpRKcViSoul+B+Nh4pCzfcXrt1l/7UdfXL?=
 =?us-ascii?Q?fdGhXhzYU/OncOKw95ufrH1yBDa+sjb5Bzafrf0nXr+43ePun/mqJRYcHsvU?=
 =?us-ascii?Q?3wlfVxg2rAgCdbDJElaghWHyW+mLen2FY9W+Zg30zLmcKJFpxoPy+sGn3mqA?=
 =?us-ascii?Q?VZPk6Y8TiaR06FYdf/nhYEHke0gCnn8n09chJwD40ubvSHvRadgTVsRvW7Sa?=
 =?us-ascii?Q?YHYRohJvpKDX54M/NDeVgMtH2GwDAIpVk09RLS0PAB0ygU2Y1Reoo6bJzhzC?=
 =?us-ascii?Q?C3ULhdFh3pbDO7iURNfRRbG1F3IcRKxS+7cjKlbwQn1baxnNMjR9fpqsVUQa?=
 =?us-ascii?Q?hYNgCHdV6udNmTaPaLLazznaTYpdarAHoYcRofRYP3K2iA2k1uVG6XZkye0N?=
 =?us-ascii?Q?EbRTRG5+KXfd6VnN+lGlcnXCUKCYnc3/mj70sAfE0wqn6ggBipzLzZ06lppy?=
 =?us-ascii?Q?pGZFtaizIdrkv0VsTOSazzPIR0WcW5Y6TxB8x15OlP4NJd94hBQhTjLrj7wU?=
 =?us-ascii?Q?FKXkf42air+mlHRQmJG5psKDRj9Uk73mhdKweNJE/bNHv4P1o7U/map0ZRaC?=
 =?us-ascii?Q?wSW7Hr0DTJcUArP3lCh8dvO9qVHQOckyGDBJ5Jsv1uOPVJC/gO0czY/FXWUJ?=
 =?us-ascii?Q?hXdd4kmKDP+OlIv1XRptgmwNB9bfKPieerkQ+ywBRrYMKXHgzmWUVrRqmjaL?=
 =?us-ascii?Q?54EikFLwMMA+L0RckaG6tHd6fdsOkOGpmb0QU2U+WGtSFVal6daGPrEzRX1W?=
 =?us-ascii?Q?AuhrwbVd8Cm14lX+Rwl9ETbEy38JXebh9JKBCQ77HFLVa5B6vEuO7khFT3hR?=
 =?us-ascii?Q?GsCA18aJArsZefDBhsu7kto1cTDKGcUAUGapW2yL0GGpc6sdgpoVTU8aLkgH?=
 =?us-ascii?Q?N4B2lPsRGuahIkUI13qiyS9R1eA88fKYWiRUr3Jut5ESx+6PvCb752BZaxyc?=
 =?us-ascii?Q?xOrenGxP1WzbMQB2gIo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e1bdf9-7d13-47c6-08d6-08ddeeeab608
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:16:40.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tpI3YIsTiLSBDyil/y84udvyR+SIk9BaK4Mip9D8I/ZS854FMCO4alMjdflmiBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

On Mon, Sep 08, 2025 at 03:47:34PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
> > > > Perhaps
> > > >
> > > > !vma_desc_cowable()
> > > >
> > > > Is what many drivers are really trying to assert.
> > >
> > > Well no, because:
> > >
> > > static inline bool is_cow_mapping(vm_flags_t flags)
> > > {
> > > 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> > > }
> > >
> > > Read-only means !CoW.
> >
> > What drivers want when they check SHARED is to prevent COW. It is COW
> > that causes problems for whatever the driver is doing, so calling the
> > helper cowable and making the test actually right for is a good thing.
> >
> > COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
> > something that is COW in future.
> 
> But you can't do that if !VM_MAYWRITE.

See this is my fear, the drivers are wrong and you are talking about
edge cases nobody actually knows about.

The need is the created VMA, and its dups, never, ever becomes
COWable. This is what drivers actually want. We need to give them a
clear test to do that.

Anything using remap and checking for SHARED almost certainly falls
into this category as COWing remapped memory is rare and weird.
 
> I mean probably the driver's just wrong and should use
> is_cow_mapping() tbh.

Maybe.

> I think we need to be cautious of scope here :) I don't want to
> accidentally break things this way.

IMHO it is worth doing when you get into more driver places it is far
more obvious why the VM_SHARED is being checked.

> OK I think a sensible way forward - How about I add desc_is_cowable() or
> vma_desc_cowable() and only set this if I'm confident it's correct?

I'm thinking to call it vma_desc_never_cowable() as that is much much
clear what the purpose is.

I think anyone just checking VM_SHARED should be changed over..

Jason

