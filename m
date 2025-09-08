Return-Path: <linux-fsdevel+bounces-60498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C936AB48B55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2373C536A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833572FB086;
	Mon,  8 Sep 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kU2yOKOJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AnwfP8MJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8C2FB988;
	Mon,  8 Sep 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329916; cv=fail; b=NA9a6SGPx1mWcdKsRWixieR4jR9vJ6bALR7ijcN3emxLVs7KleW+VQcHfGEBvYF6e7Koixwzq/eSHLBDzPgXj1PieRUD7i8xCDMABiPPqqF42gCgnsPSjZq7c8WQyNlrYdWHXEpUBc5UHd7PIk3jyBintP38JgOrIKDObDX1MzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329916; c=relaxed/simple;
	bh=NBIyB9KVUHGIsYQqz6oqhBya3h3lS6LB/FcAXqDhyFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eU2gUBZ9OdFfR3lp+h9m5Gq6hfCGIcHhDOqV+BqfCQ08q/pFCvmzo7itHiXPFbIDAdPdXWqYJEYQFC0tDlfFIAda3OixQy8dLQgoLZYbpFTsPjyfQDAwB6jGJeNbUdpU0qwuOibi8awCYA577fzyGzQrKWQ33nC0cYZp4mcQF2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kU2yOKOJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AnwfP8MJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AAtR7006140;
	Mon, 8 Sep 2025 11:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=awbeTVBELcexcVcF6uO1PpXHm35opz8jWAHuvNO18vs=; b=
	kU2yOKOJnhQf7MAebGmMt0UDxgJrvKHTVq31xHCT6VxdJ83V2mAAJnrvR3LJ290u
	/pQKpLuvO8fALpPj6Wdmfwp4btetMO7CBNQSRwZBW7xaOLezgF0p7tBgDB47s3r5
	fPD4y7m3UxPRlH85s1SCRz3zPt3pu0elf/7w0YDNsQ9ND2C2eU/ptpy5PptCUXxb
	d5dAfx8AbGePlfCKdAS5U4ieGZU04COhxORhCMEYEQZFwc1ECuGXAalTsTAw0Xwk
	nlRQPn4J9KdbJMyM+vXIjxjb/aeBSbYcaQ4btwMuLCADaxIkVLvUeH6pWA6gFdJA
	lM2sITt+HvP/uTuBFarYNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491w5402we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5889wZ07012806;
	Mon, 8 Sep 2025 11:11:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd895ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6XVtZ/d7lI+HIyN1gUcj4MLF0wh1jFqQKJJjflIpEHKwSaZlXmiJr5sfdg0mEi3ViEsCvOHXBHHlQV8oefGV7HeHEqNy8Jv8iewSroi/8DmsgcAJHzwBL0hWsvqCpQpH27uw8ZDNMeNJU2T8f8zn6pUR8mVKa+7Fv7zpjLRSuyMThfba+wn1rclo8OdUEeuvN9s/UM/KfzB4zuk/PII4OK1JJxmmwi2JVa9Rmb79TatzbeuVPqpa9r+s84SoA/Np91bRVz9Z20CqSZQEWUT7ozlIDj9KQs6E1yZECfPKoPdujSoTFtkSZz1z5fuBZFswhExCZZ/1nL2Qc69Tkqdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awbeTVBELcexcVcF6uO1PpXHm35opz8jWAHuvNO18vs=;
 b=YlPADDnToVWz1N3JYDZT6q0KtLU1FHbkxk7sAGGCPSLdbVAggiE+K+rnRgnVZ923KP0KyP1jlpnxnmUZO8LNJugpm4cXqwGNL5QQpZj3tIzW3nS+hJ3bVsNyUfxrkmlAx1++PRKy7NwTXFnMU+6EOm6gI1J6tJVHjmS4/vzn7+mmvoBKovbyhCf3Ut9jmBcUoFGvd/W8u+nvo3kCgadeeo55TTtAqOTdYaJP9eMQvNUZBcmgCD3JZ9rslBbXxdIgIl8xKS3jfCcmZKr288wG6bLkwTa+ZkApreK17oz//+aS7PXM5YuQ55Vklr5RzN9yLkWAzxQYBaSFgagnR42vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awbeTVBELcexcVcF6uO1PpXHm35opz8jWAHuvNO18vs=;
 b=AnwfP8MJhUvwBSCCJl1GIG06igEdKKlAZmYMOa/t26H4xf6CaLtr5v0v/BeqIiekZ6J8U1KaO9DIv9C8RQZSXh9WzEmlnbUel9HtQKiMeD9VbQvvyR2DjE5CyzvpEUoJax/zMXtXBZCcoOIrRWXhzRaV2f56HidzADwBm0SpoQo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 02/16] device/dax: update devdax to use mmap_prepare
Date: Mon,  8 Sep 2025 12:10:33 +0100
Message-ID: <85681b9c085ee723f6ad228543c300b029d49cbc.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: afc6a53d-aa10-4426-a225-08ddeec86750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxL0hQqurvRuWcS2twQ7RUQESiR/LviSJ++zc2Fsi0ObiuDI7NvX4lXml+tX?=
 =?us-ascii?Q?pI5YXpd2uSioqJCSgemfMWDnMD0m/e9R8YQxBiJfqrNErRSlWGv7kTpu9n1Q?=
 =?us-ascii?Q?/GlUWPtY85YV0BLwPPYbi4py0z3gAi6vbiQ/JGUsmh9RrzdrebhZnSDlz99N?=
 =?us-ascii?Q?tNLntJ3gTNbwkBCT1xPYLTQETFQ7K6pZtvFYoHE+SEEfeYNxYCVGcQJ2E9bf?=
 =?us-ascii?Q?RIQ5IbgTnTxnwds/ZX+Db2MHQnLC1TVOZHiEv5qWgXufIfPjo4+Bvnkbaj07?=
 =?us-ascii?Q?UtA/9XDIy0JX7mXZ5XxKGcVRUWcQHAq6uTkL4znOxflQMgWobzaD1/x1bgS7?=
 =?us-ascii?Q?ZYgiJ8K9IfGZycJRJ8M67Y9q3Evl3t347TNWu8ANWM7xHdHHedB0+5lJPHee?=
 =?us-ascii?Q?LsX37XNnaYLtLDHpByVfuO+WOe/z8NJhuyHGDw6kuayomlzG/od42Z9j/V7/?=
 =?us-ascii?Q?R6L+hsMaZzYfqg7O2JqeJ0QN9ywOLVOLe2yOBVEB1QRMlv8MlPs5ZFlXSlet?=
 =?us-ascii?Q?boR7xnRWZZpUrLq2Fo32rsm8Bxu608m9xY/c2T5KiYE04gLWOIHfZV8TxdP0?=
 =?us-ascii?Q?e8pwpsj+fx6IWmdFNzhsBlFdzJw5RqXTwQnPM+bt4BQsWi4GkugTYHKt7cHm?=
 =?us-ascii?Q?sI2HZcVrhia934j5jnvZJ3JNAWc7xpf+JPxD9JbKKuZf8cdS0YsZJCT6wH5x?=
 =?us-ascii?Q?6OQUao3G70Ft2wwEZgbnV5XXxLcZ2NKvtrZ5bTMkgUSLbc83Yl5JudaxAMYV?=
 =?us-ascii?Q?UIZHtUOiha06R7qh/ON7iQaFbhfE0bBxpow0yUdW+c9N7oyT5/2F+xJuuCPh?=
 =?us-ascii?Q?+TXilrR+2Y2CshG10tZr+1LHWSm0NIwD0CITonuH+9uZZRtreDulyqoxuoH7?=
 =?us-ascii?Q?26xqq1tdu1E2bxN3lF72x0oq42NZPa3Mlyw1LmFYTblfXC+5os9ycfKVbidB?=
 =?us-ascii?Q?5KLT7cBwzjczrLZFn9ttxMhaoEFGFB3LRcUN0i/gRlmLN0VO9NnpdPJ1YhxJ?=
 =?us-ascii?Q?SRHocoxVVmAC56jO0ZFSFzpL57LGkbJ9c890+RKIs7/RQSh7dC68ql1jWMoH?=
 =?us-ascii?Q?4Yc66uLonW4qNpzfZH0ZwYIMQWRbww0GQWmGN0IfUhOSbmr6i7Uq7DRtofgN?=
 =?us-ascii?Q?9FB0MhLJDoygZ2lqqFBUMHAQc9xWz0UPFkIoTzV844Z7D40cfgJU3BYnmNnm?=
 =?us-ascii?Q?/eD10NOVJ1e7iWVBsMjABADvzwJsemyuB29N4EDSvhKbiUObuHtVr1qP9jlT?=
 =?us-ascii?Q?vtqTkqAoFt3f/m/98b/Biq0jZh3YOAK4ddVSZOR8VeKhAVoEDJ1VnGeU6DBe?=
 =?us-ascii?Q?hL/W9C79SCGhf2Hs/YKluMDwnnwV6Jtz09+koS9DlLagNc3RN9DtEyCIhpF/?=
 =?us-ascii?Q?vQ/23gXOr/Q1XtGWZyg6ysw6N9OWQIsvw8PhPy5qnuzFPdefvssZxGYnjkDc?=
 =?us-ascii?Q?ZWkFdttN9fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DDzW0cYlpXg2M3JVdX5mcaWfqUFqOnUAN/nJNGiOEQp06IfwuiCeXs5v0tbO?=
 =?us-ascii?Q?gpf2f+cliKWd2kNstmMNiQPLvRgO5pxkuQUa22t0yvK43WJyHLOdXJxf80P3?=
 =?us-ascii?Q?oGipZA442teFUnukouuPbdM1pakLnpWQef9v4gqIh3O+yRBhePRlMTzTZ3RH?=
 =?us-ascii?Q?0pZNHW9enBiRHooxbeHiJojGqjf84XfohHjImh/UnoNC14H5G78aoha0VUOM?=
 =?us-ascii?Q?zdJsdGxmiZ2vIxVSh1/zipOceL3sJiwj+gpLKzyG4n1ZnVtfkm762NAThy3d?=
 =?us-ascii?Q?kZzC0FZjfC6T2hKWMhyqvjSfeJaD6pANf42FOguj6NIY99mC4sb8jyExJhYP?=
 =?us-ascii?Q?SuhmOUvHAKA5NNQvSbSO9eQp3Enc2U+Izsw1fzcaOjSGuwyd9zwc132PBFmH?=
 =?us-ascii?Q?kETzMnTbcdUfXQQuGuovjxGJ1wVuDamEjtUeW9HdijyZh+2r2v9L2qIXA4Hw?=
 =?us-ascii?Q?2FgPt0YgnA3zbMbXpkkTv/VCqPDA2sPdDqM2gGFCTx8R7vvZxA3HEgp11xZk?=
 =?us-ascii?Q?fCRrtCaWyq8/AahtRSk7DUNcJcaWH3OCY7ev6TZXH6BwfnBBT8+UZ8ZDrUCq?=
 =?us-ascii?Q?2YzbY+stHPz8J7sfY2gCNCyAqVRQDN53LMUngIli7W7urzkPO3yelzYqEXU0?=
 =?us-ascii?Q?9rPLLyk4y1Pv/2APVhf3dEcQ0s1fMkSQDBrFGe69Th49LDitf7yR6DxR4958?=
 =?us-ascii?Q?6byARW3iwdCwxsp3MHRGDTCCGyTBYII0QXwF5p/DU1tBvsWuaNUq93gmMX9H?=
 =?us-ascii?Q?ilhYxOg6AUZ/clNsxpfjvmf8zoAX9gCKIIfhV6FnHwRvJUvToCN9M6Dv4UnC?=
 =?us-ascii?Q?7LxztoOhmfN7GPU+s8QeJ+OeFfADzNy3er0YU0kra8HyhRQTmmGiCpvIegpi?=
 =?us-ascii?Q?S1F95Vq1voelBytHsOGMRsWawZuFoOLIRrsesHH61mRocx99wppzdI6vvhua?=
 =?us-ascii?Q?WUYSvxqOPAj7kwWbvqdhXZLyguYAXCTu2dwXtKjiw5AQGlvWxnb0NKFaU+EM?=
 =?us-ascii?Q?JFHNsarvmeWPnOjC+LrCsr/IKF4NF/qPvKDiBc2YlmQWLTwjEh5mcUehihX8?=
 =?us-ascii?Q?bdnfA9g/k+uBzjn5fAwYw/yE+dP6Y2TlQNwyrDEclMjqxdQ+mwxUPQ+LFjaG?=
 =?us-ascii?Q?ZHFKAXBRqPHmJXrE+xHD6lI33hb22Nv+gm6RiGOgN6XSmNQoAacGw/l2oxVY?=
 =?us-ascii?Q?OOvhyWH60eRKgOth/XDAEXvWaIs2W8RQH6NX5Fzehc+HMcAV+nrQHBUokEnQ?=
 =?us-ascii?Q?AS8B9wgqLOaWdY/z92EBNUTOfFwI5YYsuD2U0U8doVqveS7PmjyzvKaz38Sb?=
 =?us-ascii?Q?EgajjFJFeAp6pMham7CFohUs+g8vsx8IseZJzpvGV7wUlEqIiqLE6qdohBMZ?=
 =?us-ascii?Q?d6QdXsrcaIZvLVcfdKsWufFyAX7JQjwPzdYrzvzDJdjwrtjZp4WZTjW2H1FE?=
 =?us-ascii?Q?L2AxYixKNDjwt0ZQTtiutVhL0dz4TUI63zKbBeeIO//pSLEpP2f05Cu7ZgrE?=
 =?us-ascii?Q?mbSZ0qpdOHZSvGB7Ofwx9AXNnqWdR4F5+2JY781BXPnDQTT1IweRrNLPtHbh?=
 =?us-ascii?Q?VXJAzd0tmhp/NsCtFfzpnzl46MR1V2SBzp4KhG/cTI17slyYOV82oJMiRx7d?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PxBQRqBeEwcNQuSXHVCvkPw00ofA6nq9b7MMN8ldE/Jip6jHZOaeEUA0Azn7uC+7F/tztvPaSUzu7GM8J49rgmP3T7stGyI8AJ4+gu7q6EJeXMbt3/5VyEPQsTkONWoDX13D3UVeYJvQYtSjdmFTCzVpVmpULKBKWNQJTyvPgJlRegqH4dLQCeaVkMfqxNyvJPntgxjilR7plg6PEMJbWWZ2N9hxf58/C8gXJj4WI/YAuBPwfeCrhBFJU/vlBONIVjcgL7qFaHGnQtKiirIgyzWP9r+9B6zT2k+hAn4bcfWrTQA41yVhTRY2IupvvH6QHVL4d8NuRUdomHclD8rMptkAdjHog9I3YhMgp1ODBZ1n/0/1XJRVQPMAn8Cbfg4HHPYqwcdObp4c+t6X3ctKDJQZzO+gIH+qBjJfPTvLOEHqjECc3a/z7cPWhsr2zKzviEatciOWi3MREP/gD3Ugc0cj091gNQ7TyxAWdrs5VIo7Tojl83er5R7OYbawriFqA/wlmVXuHPuSABKqAj9xAz5l4V3S4HkqoVRqvLfECuhRJOpg1Gp1rdNuKkk3G3hnGbK4iXRHRta1RRZh445q0komoA5+HVewdpj3h8qRLf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc6a53d-aa10-4426-a225-08ddeec86750
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:05.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW6wx7x1JBYBYm1WaxcsWr0ODQiHwSWDjgBXRYTdT7NzxwytoisqkhcpZsECD+qHe45UKEX03cyDfcC2PJE2ccA2ioGR84jAV0D6eWV/KY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68beb9cd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2q_dOInNKJsfLPmpoRAA:9
X-Proofpoint-GUID: nWMTSo2gYJisiimMjz3mVaXPLgAwpEJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwMyBTYWx0ZWRfX47RYoZs8SGPC
 tD2gT3HsjJUG3Igiev6xVBz1w27w99r/f2h7ihYDyEs1vLzwc/rjeww7mMHIzclU7qOiV2PNez7
 SQRDe/zhAZLdjq+pn+uVJFLXkCTfbQVUGuRJQb+gTZ87Z4RYnSzdkL2ZegqvLU8FE5z+ghtC1Wy
 czE7zcDzYfqt/eFKot2OLPFHVs+X/+C6e0xY+Py/CqVHRs93nTrcrlmX371uKvAhuerevk2XfKn
 Q+R4una0osXA1cNYUjG+F6NCofFn/8dm2R7beUUXBbFMHLuqSCQtWQchW4uLxOFO/EberVbQi6e
 ouPtN2lUbwxl0Qusp22zry1AyjGFcr4QlXdzOy3AO7GdweBQvEE1K6L9Vj7BV2FlhtSZhWgvnm6
 8Ak2r4hw
X-Proofpoint-ORIG-GUID: nWMTSo2gYJisiimMjz3mVaXPLgAwpEJi

The devdax driver does nothing special in its f_op->mmap hook, so
straightforwardly update it to use the mmap_prepare hook instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/dax/device.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..c2181439f925 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,8 +13,9 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
-		const char *func)
+static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+		       unsigned long start, unsigned long end, struct file *file,
+		       const char *func)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
@@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	}
 
 	mask = dev_dax->align - 1;
-	if (vma->vm_start & mask || vma->vm_end & mask) {
+	if (start & mask || end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
-				current->comm, func, vma->vm_start, vma->vm_end,
+				current->comm, func, start, end,
 				mask);
 		return -EINVAL;
 	}
 
-	if (!vma_is_dax(vma)) {
+	if (!file_is_dax(file)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
 				current->comm, func);
@@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
+		     const char *func)
+{
+	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+			   vma->vm_file, func);
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
@@ -285,8 +293,9 @@ static const struct vm_operations_struct dax_vm_ops = {
 	.pagesize = dev_dax_pagesize,
 };
 
-static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
+static int dax_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct dev_dax *dev_dax = filp->private_data;
 	int rc, id;
 
@@ -297,13 +306,14 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = check_vma(dev_dax, vma, __func__);
+	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
-	vma->vm_ops = &dax_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE);
+	desc->vm_ops = &dax_vm_ops;
+	desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 
@@ -377,7 +387,7 @@ static const struct file_operations dax_fops = {
 	.open = dax_open,
 	.release = dax_release,
 	.get_unmapped_area = dax_get_unmapped_area,
-	.mmap = dax_mmap,
+	.mmap_prepare = dax_mmap_prepare,
 	.fop_flags = FOP_MMAP_SYNC,
 };
 
-- 
2.51.0


