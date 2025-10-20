Return-Path: <linux-fsdevel+bounces-64696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1011BF112A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 461D434A8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861E5323411;
	Mon, 20 Oct 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XedX/zhs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="doCX3j5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55731B810;
	Mon, 20 Oct 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962395; cv=fail; b=leT8feWc1kgDIOT6vJriUx+ozZA1RRwXeqhW5t39ZaBl629z0nDHHh/4D/aJnhVMKYDR4O9fI6cEL0NT6b2Mq1cFUC+ag0pKJ7MoQ6nOxMRBIqxv2sLG4Hjlhk3Ftp6s/iLYPH7AR9jmiFbfbU0Cf1i0Jt4NOI8Q5Je+0x5Bupo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962395; c=relaxed/simple;
	bh=VY2L/N1aI2eLd9ZBkLUKCTiyaS1Pl00bO8QoHJeaCMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ewrs2aeybQbwxBIqypFgEajqktF5OpYA4tMTZ5M6E+Kv4mBIAA8o7rEeiUpla3bokCLsmhCX2/O3i1GoedbgT3zbdBBSYWi2vcfItcmeSHrA6O+fD+NpoldNtoGnchSpZuhThKcObtrpor95wZlB3dbnolSgPgBA8eOUGGUFIxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XedX/zhs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=doCX3j5f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8RmX1005909;
	Mon, 20 Oct 2025 12:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Tbd+xrtgAX7jQLjegM/oU5YYW4XrPGgQ+r1/SbDKG8A=; b=
	XedX/zhsx5Vymo6S6ayfM+NrVlVGDUrB5UFk5n3Hn0bX4BG4/jft2IyMK2PD/DzJ
	NyEfO8TGtK4A4D/T0wLp4Tls/tXuG8MuJBMFJ2Y/iFjhLolYh+N5i45zXt2wTd91
	qXA9PNTPZHPRqz8bauWFPNndM0UNVArPo84Eh2+0EVFNjiQZwFk3QTGvJFK9PKLP
	ETR8eaIEP1lxhxZJDXsciOYUX1FdW0HJe1i2pGvpJDwg6q+Nwtn1w4KH2/c3zlnw
	B9HzN+CCPNMpXFnBqbm+W7/RKVxzwCog04Ksb+BrVycgL6eGTyuay/hSYkx9Aqvp
	QK+i8uQevbOViDbWIIEYvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvt4b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAgp82009470;
	Mon, 20 Oct 2025 12:12:10 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbvbac-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP53Med+yKWpvb1nMtlUOYjM1QHM4Y6vPSUWNLUy6CrdQIBQhQ/JrI/1P3xEVey9RWqvTQ4tbRmmOEWKZpSvXn9m0JMkJEFywGE1c2k9VSvc27xx5w2xb7pHeqf3JYy9JHO/hX5taW1C6AaK1vOO0mfrPkS455+U5Tm4o9+y6L8PZgvAPpSSlICetROavMKnTKES/94uZy/NX02pkpMcFO5t/gh4fNlFX7U6EH1DqpW/SMT4YwK36J/0Crh5k45piPQFnkogNQWrw0nRk723OBkG1xpY7HdDFq6rDfHOLSQxO9BRCLIZPeJE0OCEiDwV1ZE3CalHGAU+ODyne5hM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbd+xrtgAX7jQLjegM/oU5YYW4XrPGgQ+r1/SbDKG8A=;
 b=Yqe4pq4LROPWtVyMha5Cl1gl+45IRqT0OP2Rx7w6LhbERpa2h/tUOh9wWwIgzQs5LkFCriAkaQy5gf+DbNQH1fzsJTwlP6pVSqh7GkHO57VSjPgq/5v5I7jGMAwaZFiOLF55gRZBPQo0pqVnUpBx+a0f4j9TSv3FuV5jPftLPvtRwjqhxMsCZv20NxMBe8itMNYNWyK9H51skgF3lBpBFWvX/4CuJk/finHf3YHiHiP0FCfONH1nSVU5r39Pnw/JDuDFLhBXgZpBnax3gFPb8/HAUT+ilMj8D2d7YaggxnYT1DudrdUR14aVKiZfeiZbL6dXfWMTqphF/Q+KML4dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbd+xrtgAX7jQLjegM/oU5YYW4XrPGgQ+r1/SbDKG8A=;
 b=doCX3j5fn0mudjbA+7HdxzlHzv5SVvj2XjMlSp7frnAQA/6Ynw7TN3lnfv7+yAUXUXCG4lGyZF64QNXwvIvbjuq9uUz4EdwCxBEC6oT8QckiBuae4oUVsvvj70skWPqyVmo1SxGrrRD550PIzDm1Gn/fauktqV6RJFkRto18qYU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:12:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:12:06 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v5 13/15] mm: add shmem_zero_setup_desc()
Date: Mon, 20 Oct 2025 13:11:30 +0100
Message-ID: <d9181517a7e3d6b014a5697c6990d3722c2c9fcd.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd34d0a-cf5d-4598-d10a-08de0fd1e2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JIbqlPqYtWBO1XP6ZTGbhGZNrxlK2vCYa2hTjILZ02URZKNs4+U/RW/FWKD7?=
 =?us-ascii?Q?BTRQvXYyqPid069QKNMlyVU2AsDUN9p5zASv4eWd1Fzv6Zpj3BdjTSDwqVRe?=
 =?us-ascii?Q?BJCuXnqDquEf0t9yusJpumKg7LxyWZcXd7YIekX/Auu1KJuVTbc2GzhN74XU?=
 =?us-ascii?Q?VxjpA3hcClG4VtE+Yt6AEgfeDVs8IoTTWp2UXUTCdZUjsu5wYpBMktow8Fwl?=
 =?us-ascii?Q?PbZp1gqNNtkZXLVKcaXWh1rLmVsqKLJtGwWqNKx5IMAUuWNc7kDpsCH17r91?=
 =?us-ascii?Q?lSn1MVrzVJHpHv5NyNnoNxg2NxHEZurAAjCBK5MRobaDn27ZIvxBtaM7RVVi?=
 =?us-ascii?Q?D0Pp0fLR9bkZFLD90CM5GC7iyjp8ax74qBZMeTayMiPfhmj2NJqTA8Yc95Wi?=
 =?us-ascii?Q?1nzD/wAk7Nlv7IKJnG95HrTJEhyNDBGrV3Ago8m2WISbL96NzJMlSWl8xTwH?=
 =?us-ascii?Q?YY07OBObqKpNbG7lREtFp7r0oZS7PBd99wDHjSvw/vWtl1Y53rUpZLqo2eVD?=
 =?us-ascii?Q?5CIKGvtQh0f+AqnIrkLbLUjDWqQCSjKepyRlHqPUT9h3wF+TRfs6ANnGCIbi?=
 =?us-ascii?Q?50YZbi8PFP4XvJRMlwq4gB6t+6LQJzC/ddtl8TTEYqT1A7/YyzRCM9lxuZ00?=
 =?us-ascii?Q?Hu29VeJmqimbLa6iwcEJT4BpodN+GPcQY/eu2aZZBLrrPxzOtves3r3r3+Ii?=
 =?us-ascii?Q?oLlTkz2RV9ubsLNOeIc3cdULmP2CEEKl9g3HLIxcYaU4ojd28Xh/ZaGPRmkZ?=
 =?us-ascii?Q?JlkzX85DyB9jbT9rJkhZhWENQ0zRAfCcyWyxIHgf9Ok08O78sPmYx+EYJTe2?=
 =?us-ascii?Q?lKFTfhENneoKQOlgXxcuNEpW4zWm9d4yvBPsPtJ0s2i2OfzKjnJmX/fI1Tu1?=
 =?us-ascii?Q?2GCVzHy5uHpnMXflmc/QY4YjrKMBDdz0b4RV7naouNd+LA6z6pmI3Ot4Zz3H?=
 =?us-ascii?Q?vpY+xfUmpkq3deEty9syTDLvQQBW6HBD5EwlWbj2Pah3g0nnf/uBlZTozLzP?=
 =?us-ascii?Q?WWubHeM9KNV0AHnMsIA9rzIqYZ/7yLTNpRNdZS3j8XROwxk6ZXVgQ2Hc+6c3?=
 =?us-ascii?Q?te/0jAfLiP0lX0oIai3Qlb5lJZvXvGMNuVutnDdAtNm/lNBVzd1xYME29MwT?=
 =?us-ascii?Q?VMvElyY9CAyWcvjrGeFOBYWxQJO7EnfYJO86nDd9Bxr+RuqoJcn7KbmYrgM1?=
 =?us-ascii?Q?in5uAX9p65/xcO+IoC+d/ZETNA1Yb0w6I1IL1ZESeNgZvxBKgOHNPS0K/Dka?=
 =?us-ascii?Q?Wpb9GkpmLl1/aSL/glMR9lQ3UGKisLlXmeth/GChWjV1AicJvys2+6sJu//X?=
 =?us-ascii?Q?sLut9JEBKN4ny41sgvM8Mk4YCB4b0407kbOPlRv+XRMICdBH9RBq+DkPNlGn?=
 =?us-ascii?Q?qAHmOcp+egeWc9pU+qL8qnb+L0x5LylbZ0T54tc1jjRo5Jmvt04wWI3KP72J?=
 =?us-ascii?Q?qk52URSEJ/JzH7vQutZ5zTOK0EGMVDql?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WX6wqxSsJH3QqyZGcprKfZkEC8VLAYfujaM5kxKLrGR8WZfHuTJKh4HJ2kKm?=
 =?us-ascii?Q?ODRAX426u1WSWbuqm1XXvGj88OtmRKVrdf4LGjRA4NVay1eeX3j8rZR79Cq2?=
 =?us-ascii?Q?SXO0M1Df+0rZCYTezvQHGza23LnLwPa1IadjGwm2ounBkSqRPwTohudka1vn?=
 =?us-ascii?Q?gWmlFd563Zsiw25BooaapfvTpe/rXW7LME6/bVQCVHoLdOhu3unZXtZHTeti?=
 =?us-ascii?Q?ik76GxqpP/6bBdnDm6dDdmpV5tOGbfgSqBObI8qHrJ5hQxrkFTJW8g3al/wv?=
 =?us-ascii?Q?JJUVg8aBS5Y7ghgXlxQEA4oa9p8pZcuAcsn7xzsGSXu5F2uCIYrjHzAt3+pz?=
 =?us-ascii?Q?ICDgqOiHSYSgFWuWFSpaw/RH7i6PPTMDfnKdrF7x8l32EF9nsyhJxeEiQ+sY?=
 =?us-ascii?Q?whgvbN5DQIDRIbhENq9CNFkrIkd7oEv4VaCsa/HrE22f+ECgcinnowec29yN?=
 =?us-ascii?Q?n4gQ/TAwiJaTrvFCjCdFQGKzoOmhjmoAiuCQiPK/BrnEmAKhEq9KjWYDr3B5?=
 =?us-ascii?Q?NvDZdH9M7rppWUiRpKk8mT/XnCRCEnAihneEDwvvylzn8Q9dpu2K8pfimeDE?=
 =?us-ascii?Q?xQfjfKhVQDkx4Cr8aA1sXph7CkRp2qa2sc4WFLS+idmtl8BGEUErStGeQc1G?=
 =?us-ascii?Q?kV6NRQbJ7K/Dcjg+2Y9woWmd3trn6ZSJD9wufOvNI5vyGRkAoPjMCPP5f0XX?=
 =?us-ascii?Q?PfqDOaXIV49fjIr/ArNuEsBdas20Wu9sZs9UOwmb3aSZGoidpOLFb7tQ81if?=
 =?us-ascii?Q?X44V/asVOMu0snpEuINrIrfqcHwrytnWZtch08TUKvdv0bEAuUGhHNtwlivK?=
 =?us-ascii?Q?tSCYKp87fNIg3K9M/sBU6c5AQf4C0z4595Qq86FaZy6Sb8m06eLQLCiqUIiI?=
 =?us-ascii?Q?LFtTHqceKmU+lJaCAHWrF2dLEuvzjtGHQrr+wIN8xn6hEzbqUwvtFifr54JV?=
 =?us-ascii?Q?cZHQzM8ZldJDwzATm3prHXhi4M6ZyzGv5Mxh90WJXCrDST8N47FBnW5nUYZM?=
 =?us-ascii?Q?DKtsCWqWbk3YuFgPbkGYouhkhwKGKLP8s7o5syGJeOoQ6mbBLAywWt1EuWU/?=
 =?us-ascii?Q?8g5CHt+gVa87qYiSkToDl5njScmY+VZyGI2CkMYDxGuKrwKznp8FouEfFBXw?=
 =?us-ascii?Q?/4ErIo9k3lYacmVTjf+s4+SZv7puLkz2fBKYyZNk3ELaegTIsbzPzm1inJ4H?=
 =?us-ascii?Q?Z8GDMQXfx7Ld7Y10fk//RyVU30S6RTQF6LGCKk+nu0KPl/P0YPz3LWM+K4Ok?=
 =?us-ascii?Q?iYlVd0VriC5//aBrKKpa05H6Gct//rU0hLAMoHM9eo+UyH0YhXKzVVEtG+f0?=
 =?us-ascii?Q?jG53m4gWU+G1JwaSE1TL9FNTeeLgCWIDmo0/Rzo9gkmlcXjerqXdWecHXyHD?=
 =?us-ascii?Q?t9XyMk2MV/pSXk3vbukbCZPJVqgPt3Va9M9+7b+F8ExydccY1gQrts8kZ+92?=
 =?us-ascii?Q?sjztYYNemaKZPTil293yVfsB/l/TFlTuNuO0Fkjvahmeb89YYpXeonErE73G?=
 =?us-ascii?Q?AS3IsS8icHEgMfLmDbxBvTwpvrOiUpGNnUQ8FAILAgmyGmWyJQSRgzeI62Af?=
 =?us-ascii?Q?NxHfSA/YmxIO4ogPfbdOo5GQYF6nIdXHNNB2r2RG8x3ayWGskPfDVoHU/q7f?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YMfs0kl0aVNL/SvxyBkCkkvFtQwdwXXBst86UIf++iV2ETRjKTCi++78PXXQ2xssMKJbv2i0g4H78ew/uFoiy2Yc9ZkA5sI4lKqfUxLbtziSawbdzDbJoZnhC884MWTlJZ78FmPNGzjAWT/w+8PVjm3tdH11U7BFxrZbiBcfPysGMi1vcriCD9YYRYyf09Zb05FpIU70l7a4v5uQTmMbGf5Jt3F7Zm18MVAuT2JJ5Zab/wGpc567tYtgr3dV0FBqFLawESwNXPGIaMEwo9YNrAqbZSWYatZYhc4iJRXl566ERxEONPpBVabzwKXvwyXnmFP2Kss9vAPyESJRlFyz2dUfScsJ7b+ss7jg/iEWRKZzzoXuXYCPLAv911sGnhcqDjkLhsyS7svMTn542wceCABTr9KI+TNG4S5iUL4MrvczJADpG1rvaQcoNh4f/5hoo+tXGOYIojy3knCdJfi41V1ksLsijCVN6iKzHM+RExEn9JxKvPrr6xrypFgxm86RswHiwBAjck82GqnMPu235ttHQt9Z01De4X4+v/PIx7/5jiPPKZmVQljorp+4HI8zG9hDgNxLi/AlvbAe/WTgB/CBjdrD3k8PKLq2ooHYWpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd34d0a-cf5d-4598-d10a-08de0fd1e2cf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:12:06.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRFSlqwLgK+odjiFIN8QEHCBBAqdH3cUg0eDE5FLYCbF59dYGa/sFvpFwGx+hWCESLkRvuvthko6+Kg4O3bcSEjSdriNDtD20je1MDx9FcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxPfTwHEYbGIZ
 WrWH0/siAwoCPFJsSPmq1JQRW4gDM75PMdoAvBtBVDnUGSw8ykniXZJWLNx2OSRJKc3IY9ObFKS
 SawT9YvtmJEklAcWNsveQGB+m+REhH03aEOidl0T/0MpggIOCqNcSEyFQIvT8XHLqg9sDfdnYZ8
 LciXUWaSzfWuPecYggprKM0ukxWbk9Bc0VwNUak8/gOWqeZknvASKo91a/rGIoJ1O/iUB/dbFeV
 iewrrg+BvCkfo7Lu/qkmvFGujsMchKC8J5yYghbFxbld9VGVy7XFAg+0V47EI3+uUeCGdmWjFkX
 tQXZQ3Jn9yFtQWBrWHP08GB78tNToHZbv5xlla2wFB1Go5I/rc4kJtorxlC8qYU7GDNON0dQtY+
 9o5WGh3V70wmHZzlxblnSPzDDXq7aLJE5rckB2T6nWsqJdt1Jow=
X-Proofpoint-ORIG-GUID: okvuu7hU-4_ecdGeJh3LvKXmaazEAN__
X-Proofpoint-GUID: okvuu7hU-4_ecdGeJh3LvKXmaazEAN__
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f6271b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=McSR8okSZ11kpnvm8pAA:9 cc=ntf awl=host:12092

Add the ability to set up a shared anonymous mapping based on a VMA
descriptor rather than a VMA.

This is a prerequisite for converting to the char mm driver to use the
mmap_prepare hook.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/shmem_fs.h |  3 ++-
 mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0e47465ef0fd..5b368f9549d6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -94,7 +94,8 @@ extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
 					    unsigned long flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
 		const char *name, loff_t size, unsigned long flags);
-extern int shmem_zero_setup(struct vm_area_struct *);
+int shmem_zero_setup(struct vm_area_struct *vma);
+int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
diff --git a/mm/shmem.c b/mm/shmem.c
index ec03089bd9e6..b50ce7dbc84a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5877,14 +5877,9 @@ struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-/**
- * shmem_zero_setup - setup a shared anonymous mapping
- * @vma: the vma to be mmapped is prepared by do_mmap
- */
-int shmem_zero_setup(struct vm_area_struct *vma)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
 {
-	struct file *file;
-	loff_t size = vma->vm_end - vma->vm_start;
+	loff_t size = end - start;
 
 	/*
 	 * Cloning a new file under mmap_lock leads to a lock ordering conflict
@@ -5892,7 +5887,18 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	file = shmem_kernel_file_setup("dev/zero", size, vma->vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+}
+
+/**
+ * shmem_zero_setup - setup a shared anonymous mapping
+ * @vma: the vma to be mmapped is prepared by do_mmap
+ * Returns: 0 on success, or error
+ */
+int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -5904,6 +5910,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	return 0;
 }
 
+/**
+ * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
+ * descriptor for convenience.
+ * @desc: Describes VMA
+ * Returns: 0 on success, or error
+ */
+int shmem_zero_setup_desc(struct vm_area_desc *desc)
+{
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	desc->vm_file = file;
+	desc->vm_ops = &shmem_anon_vm_ops;
+
+	return 0;
+}
+
 /**
  * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
  * @mapping:	the folio's address_space
-- 
2.51.0


