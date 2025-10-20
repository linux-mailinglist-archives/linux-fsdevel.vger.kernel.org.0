Return-Path: <linux-fsdevel+bounces-64684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1859BF1067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AED974F30D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D23148BB;
	Mon, 20 Oct 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D750FPu6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2qFyJu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDD302CD5;
	Mon, 20 Oct 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962385; cv=fail; b=oDiTPaAK2Eies1oMVhBjayhF+KBi6pMCfHUO+sFVwU+3EId8A9gTchSWUO+2VwNqRgVLL+MZGFBqnjA0VSXT2TZVp2Hqe0E/meVv3dDngroFYXM9PJJrrw3BNou8i70Veuz/w+uWd90QesKgPQMO4eY2e3eKWhcssw54hOnBM+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962385; c=relaxed/simple;
	bh=NW4Wue+tox8F6fUmGJdI9fo/wTXw6EEh5nLo/Ebd/+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2iK8E801kQQfGWSfvAGz4I4LlxE1aMQt9Wu7eIPbkllNZzMlE+eVel03YcP2asdzDRs+rMxZR92VO0DgKGX+shl/yya3mKipDS4uQqcHYp7Izmmlma+KA2PL/jyEPJ2k6kVGFjU0quZLC7dfdrBEoLlfLJRfs/IKu7fwwqPv04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D750FPu6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2qFyJu8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8RkwF016825;
	Mon, 20 Oct 2025 12:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k4Z8Gkrp55J6NdvMNggSqA4WJaWtCUu6nX8MlsUMAyM=; b=
	D750FPu6XrlTTyFiAVEeR/0lByHLDFD+kCnivQbj95hrGBPYTRo+0KB/unFp8hHu
	mo0skygSYbVZveTmAIK0YCJC2UZwRD6qFJH/5mPT+9zK0CAGN4i9BsvBWiV+j08U
	xskpxi8NLX6iUUC+OE87+0PWpBnQb04qBr8FgOZLr/LMLNbkJDiez6Ymilpe+AQf
	uDRUhmocYqqa1n2hJ/dyUlOhc5hJSX2Ud+INQ7ufPXHyYYyOW6CTLI12+bFodaOq
	m6uA9hFAryVN5ZsAFXzedbj3WPxce0YYKeLY6txdpiiuELYxn7Vx546eomhyozBi
	rlJLjAXzmGt8O5TTEJlC/g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2wat4h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KA9Z9l032462;
	Mon, 20 Oct 2025 12:11:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmfad-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMYJxuNangs5gxQBJgzbA2qsvufzYoNLiaDcPQg5zzKXzEaWkv6Rd3gQ1/ckmjITY/PyI5ecZlCqG4jHYfmo0FmAS8CQNYqfjkv3D9b0xvED9cv4dftZPQ+v+ucz7s2ncrJ78ObkREBx7q3+NTU702dBrCnHsLwz4+h4sjvgKe/e1qOAkA5Fdhk5X6n8Bk2r0TaDFcFJa2FPzdltiQTr3bCnI5W2z/RNCOxuOcqRjRBBY+nQZ4nRTKTDI90oNJ+AFa+jT/CFpGyc2+EFBKmYf0bFpRhpJ/tTXe82bXj6gcEhV7iM0tD518At+NpUsMFao9hVERRnR9AX6/KoKYX38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4Z8Gkrp55J6NdvMNggSqA4WJaWtCUu6nX8MlsUMAyM=;
 b=gh1/MHjyc6c8oW6+La4P1DRu1yf4+6BNYfVWMzywBpiRJ35tuaU7yR84frJzUO5Kl8al5aun3iAcSVRF7XLDM2BG/w/Nu1lBMoO1vbEfp4NQDikKIQ26ygAkh32Lvd4ODJNQsmUADkDkLTvbl7RWb+yTEl4KYCDW8m2U4+POFq7KT9FVXk4PrCRlCxpGv/dXewu8lPZCTi78z205ZxbDwR1+1R8q4Ku3WR/KtWrGyDoeW/xmbeANp9y6HekAZTF2OnIGtwCuQrkswftyLuNHybM4AAvYUHJ+TrkLimndFC7hYqJJ2mDnPMVsfO4qqSdocMmSFgZ9dyJhfKN/sLtCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Z8Gkrp55J6NdvMNggSqA4WJaWtCUu6nX8MlsUMAyM=;
 b=u2qFyJu8bdjae7kdv7KhvnKQaLUmf/eQaP3KboTKC/AJthJW2ndoAqJnnsGWf/fkTVd14xGNiQ+lEniYzD4s8boxXjxjzTwkVDpUpmjhiwGfCNJ2G3fLR9PN5m1MgzstVKjRcppvYGxm0E7i7/F+nB54FNK3v94G07KQ58DBlK8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:56 +0000
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
Subject: [PATCH v5 08/15] mm: abstract io_remap_pfn_range() based on PFN
Date: Mon, 20 Oct 2025 13:11:25 +0100
Message-ID: <d086191bf431b58ce3b231b4f4f555d080f60327.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0680.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: c0216fc2-512d-4e96-42c3-08de0fd1dcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYjdC3K/YXM547PVkem16+JUja01cTMOfxhOVhvteMpDSqVV10lP9+JF2gOo?=
 =?us-ascii?Q?uHNcy2IFI8ox/ZoDh630+/N9Hlco8lNKg5pbEZuwjPaS0qxEMxuymcxEhIwb?=
 =?us-ascii?Q?DCv/z8Lwy7Go+ty467zXZlTojDIq+c8FkUbyzRkFJSBA7DcLgICKCfRxFNCm?=
 =?us-ascii?Q?uaScKTtc08Ip4ZQ36j6GJBF8CRz9BixRVgiOJIA/RAeFWjak9tE7QJdsC7Ol?=
 =?us-ascii?Q?lr6qjmA7SVp9cYkFoBm+XXj5obBdCJgzddKJGAdoyDGaN279T1qqJAjRwEPs?=
 =?us-ascii?Q?n9KQP7VtaNy6HW7F/ykFdxu1+t9az0Inn3Otom+oEMXrTFvSqM4cH4CPVoI+?=
 =?us-ascii?Q?mEgKqlasBimWGnD4wqBV9zKQkUhqk+CEJpM7GCPx7pLsDZnF8VLrzti5o+If?=
 =?us-ascii?Q?2JlYwIYThKz0MAguF/CFHcFEP8xtx1q83hwU8TIzsybk0AsUKv5m0DGIJYcp?=
 =?us-ascii?Q?fSmO/yJO3Tvoy9bQjc/0ds4K7s7wtV50gfDe2a8TGqJam1s15TS5eJi5tOAS?=
 =?us-ascii?Q?K/vU15nVnsWAuRrLL3xDNzbCu5adew1JqEpTSa65ZL74iKVY5VdR5ywS6hkN?=
 =?us-ascii?Q?Kd5myjdaBNuNe9+tNAvmKi4a+6y1dQnal3/XO4zQvKmRXxEcjWpuBkw1B7Iv?=
 =?us-ascii?Q?K2oEkv1YT5+I9RMg5NwvZJa7YJLtmQb81nZdVL5GaJDTlI0j8OUk1wKYhihk?=
 =?us-ascii?Q?9qoSg2fkRCDGFOYuMp/hOrWNNzt0XCYymHCXBbJwsqAuxMG7n1I5SkKaURS+?=
 =?us-ascii?Q?AH0kUkwrDhrrzQTVBNqy6m/C93fLD7liutMQC4+bNk3CkQudfGCnrqI24SGU?=
 =?us-ascii?Q?vGVZ1vc4uELHug0ZzY0SeMF2ez1uBhGUIMFp9mb9DF+Qqsocq+0DfVyJHHfo?=
 =?us-ascii?Q?hvPcLFru0v43p5/hk2ExdWOkqXxfRkcRLRq7AXFgjDjfOrdLQEUxAYceNtYC?=
 =?us-ascii?Q?qgDGvdUsFRmfBWmaW+WPApblog58MkX31cjhF+uO41SSAi+kVrptQDWIBvde?=
 =?us-ascii?Q?VXeSzCpg5Jaw5OC1U6WYzShH4qy4k2XkNBVDxYfCNhViEZrFYe33HMKkTt8t?=
 =?us-ascii?Q?LJwh8RwKvVfUW6Juj9x0Vho9AYyZNRNS5wnOF2UeMeDXGZV80kn1nlBno38P?=
 =?us-ascii?Q?N8A0frrhFzMXNrTOYYEE/h6jKMDCeOrasW0qiM1Fw7eKimCMEzOdAnmT9LCh?=
 =?us-ascii?Q?OOnKcC9sPllyV3ogSR5VSE55zDKEwOmz3C56MpPDVMAd+rnNqMS7i3AlUGlJ?=
 =?us-ascii?Q?4pzpyD6myixc3Qmxf38jO+uDKKGcV1fADDIYg44UIJA5XtNE1sNpt+5i+8U9?=
 =?us-ascii?Q?3R6tPHdR13tJRqDTGlrdv14nkIIWI929zjU9a/0G0oUz3odvQ4SiNYLi68o8?=
 =?us-ascii?Q?Ln1JdY/GUphTahAdCKCBFRZiu+Vo76QQjjzni9iwtRrbW3iT/oeAPmt6gD38?=
 =?us-ascii?Q?jf/XJJV1GqLd56hdBKqZ1JSiVSjLdiOb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+BUSDjKcl5e7VGu47hFLybhjy8Bkb9Jw9a9mfjBYq1FuIqnLzX0Zgd7HszL?=
 =?us-ascii?Q?ImdwzIRaWz2CazVEVBeav67AfowQMMZtOZHpDLVeYaY0SO39l6RnR7rO1VfW?=
 =?us-ascii?Q?JSIt9R8cnOIXxpsTdt2GYx+tdzgAWa6Ne0ijYsKGjqaGi2Pqt1WqM28JgItX?=
 =?us-ascii?Q?x3NRO4m9Y6L/TzLVWYnjC1apf+Gk449uSMgSzrPq4hTWpLZ55qxfgwaF0vbU?=
 =?us-ascii?Q?Zn16gK8+eozc2YXasrPf9Mst5OvnFLQ4yBBUtQYLrVRRiesk41EfDZxaTnn0?=
 =?us-ascii?Q?4tdq475acQ+CYyxqcXI6baOQHKW2tfYZNSvZet09CwwRItcyEIwct/F2qKtX?=
 =?us-ascii?Q?7mu/3EP6GRt8Apc0zauK08okdVQMv4KkxcfR4nWmDk84NVt4XYFyc+HLyrGr?=
 =?us-ascii?Q?/urbJCXZYGD6jNHxKi8dA4wLF6lJp71+ympLAT9OOh1v0nX++/lCSiD8aY/N?=
 =?us-ascii?Q?j/D+/vNlk+lAQZsPg8RXwPOR0v7PXkDdAnqVheGuej0vryNGmQ75D2KvzkwF?=
 =?us-ascii?Q?JVKGDWVdfqUqhbejcW8fJVyp3Y1uFgV/O5EKsgMfpLvMUGMe1ncyU5IpA5xp?=
 =?us-ascii?Q?S61FwF2loQxwfdw+t8mv+CGOoAqcslQnw8nnWJX+LfINyue3NXEfeJ+w6NbC?=
 =?us-ascii?Q?mzODmICc2cFj4izfehtqZycEc6IZUSAVXIE7fIzVc82AmGeny1L7rcY54mQs?=
 =?us-ascii?Q?amznHMuGkl+JEmoqoksAFer1CkukHxPd6M3I/Hbb4RNWQuaMQvNhAN3o2ctH?=
 =?us-ascii?Q?5wbe0ZUxRK/S71ap6tNkI01dATu3awMa9XFKZzR4cB58QDl7pIYQ76blYsmi?=
 =?us-ascii?Q?w3XzbmwnDD9V6hVI6d+RTp13MPYwPNefHnfEb/I7dHQ0qh5J3k0sj5vE5+Jh?=
 =?us-ascii?Q?LhGRNjEH0zO0uDP2u4SaGDYvAl3fWKv5w7UlotWUHjfRU1ztlWn4iayGYXlH?=
 =?us-ascii?Q?/Kze3p7rVQ/SEh69OtYziQZJ25beb8z/BSm1KBcuPUzD3QhuYAFzELXm/8is?=
 =?us-ascii?Q?Ja0pg7kZgESmu0gxpy4pB71OGUMD8aLT5Nae+bOIYgQ2AVEXbttU5H3gaqnP?=
 =?us-ascii?Q?5IiQoFjt5D+cjvbQP0hKIwlGzBthBieSGa+S9CBmRK/ct/UVDsqT314W5FFw?=
 =?us-ascii?Q?pbPoJ7zDlVz7IPThPLiSQLhsYBId2+VrHhB8YRLCCnUR53VDBqztwLrizLcy?=
 =?us-ascii?Q?QSZWD0o+jSW9xYTiJRLzclxkmcW7T1StsulgI61I/TdXqHO5P3KlIw/DYupg?=
 =?us-ascii?Q?JWqsT/etYFRp25w4OzTXsKD41ooqq0+dFXo1Q8rEx3zp16PDyUFE48/Me1wo?=
 =?us-ascii?Q?2cpqfFNNACvCYZplAKhSDyQhiz9iaY2U74trwAAU8Sjc+q0KnjBt+fGKvgW5?=
 =?us-ascii?Q?gBbh7yzPt/uXhgtHpZBHFfVxuvDfE+gBkusCn2+m2mvcep+AW3AkgxWNAhrc?=
 =?us-ascii?Q?/tyfO75EhBRGjP564wPYBOqQAVB7daiKCkN+gXFDkB1op1VD951HmuyEMbXp?=
 =?us-ascii?Q?/tlauNBWN4SaUwb1Rr/RciF0trAbIOPplbOI8ndrSApKISOQ2TduXYFI5/T6?=
 =?us-ascii?Q?HyLp6Fj4wbFDNiGan17aWhcoz3az8OUF+4S3/vMQLc9h2M6JiOk/VrpaEVoh?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/hISRaSge5ABGR8ITCIE2GjTThyGirPezfoQLiF4C/tRk7lb/VKP51ifopwFmzYd3+tv6E/Sz3cBQhLK2rbH4RxrzE64WKuE5eBxmXXq6W+nbdY5CT+6UsHhTnMkNcI18SeQlzsn4lBNQDNBxB3VZucoc27aE434FhYo9ePyo8qhRz3Eov4Wg/vdP776lwDWobh6Pzz6CxJggTn/6b8YuBDT1jdTReSsFUqKiKLd8kGWZEnpGDavq4CUuwgvB+od7bxUqIWUoxKF3O0Fv8UihKDEBTPxqN9pMgVH+95dM6hZ1kLSkqLJwWzSxwxlYscDKC2MZvsXVBs3UVkZn3ASWH3UZTQ6N6rBws/q4Bl0U5dnmluHWu1l6LjGvkbp4k3Qtozl6FfrG/IonbCrUQ+E7WnzVTE2tAI12/FW0UyBrtPnOMIAuQpyl3SpK0pwohZYIZHGOJiuQDknzAzh2LQfy1af1JQC3+bOFqk59ZooPeMNuW3Ff54mDCKbg4p0gu9ZJ7o5i0Lx4VgTpvB4n7BDzzNLRs/V+NkR0WqTNAuiZcqsWTsiA/Yi1xry3R40vydWkPu5ysYdRv9xYDEht4W52WAsdukz4NbDwg1VdqhfEZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0216fc2-512d-4e96-42c3-08de0fd1dcba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:55.9653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeKOzhNKvCJaCa5zSzVJoJNNwdqErRvL3Zoah+ki6CNxb/2o+va84q1cQar3NceimXqPDznzF4+37VtOS7Lr9v6m6ppimlu9PBw5UDqoFgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-ORIG-GUID: iOAve9le2khrsn49eX81vxF8GUj598SM
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f62710 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=4Mv9xYtVCqfn6bI3fU8A:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0/mftYM9uc0G
 figy3e5H+ZUHLLd+EquGRyz/a6jlQeq4jaq17CaecErjugaAVtv7oq4BjiK0plEtSPc0lf31ZnV
 4wSsEYKCWUa6ohwYxPe3b5xXh1stWAIuZfF6GvQZeQ63nfH1lhUo/B6oSeb71KQf6OvmQDLrYTB
 UioR0Qt/GhpC9odqGV9sJ8tZ6dlkBkv8wbNAcjIeZPFflkOJ2CbxUp85Al05OGLZDdf+DWIufOh
 Eehbas+gQIAHKcZVRqWyQS6X2rZAP6d/5Px5cAHJyEq3fFxD57ZNA2OebzeuTHbWItHtfv1uJT4
 SpTfAM+VwccUuF9OBEuT48JdlvxgWSJTSc9c2B7VR3T9ALi3O2oIL12BgEBbxWuOwOVwjiRuOpT
 pgZjkVvBm7t6iiLPQyPwQjA03eOHImzH1TdwFa/cEPVZsgoI9ec=
X-Proofpoint-GUID: iOAve9le2khrsn49eX81vxF8GUj598SM

The only instances in which we customise this function are ones in which we
customise the PFN used.

Instances where architectures were not passing the pgprot value through
pgprot_decrypted() are ones where pgprot_decrypted() was a no-op anyway, so
we can simply always pass pgprot through this function.

Use this fact to simplify the use of io_remap_pfn_range(), by abstracting
the PFN via io_remap_pfn_range_pfn() and using this instead of providing a
general io_remap_pfn_range() function per-architecture.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/csky/include/asm/pgtable.h     |  3 ---
 arch/mips/alchemy/common/setup.c    |  9 +++++----
 arch/mips/include/asm/pgtable.h     |  5 ++---
 arch/sparc/include/asm/pgtable_32.h | 12 ++++--------
 arch/sparc/include/asm/pgtable_64.h | 12 ++++--------
 include/linux/mm.h                  | 19 ++++++++++++++-----
 6 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 5a394be09c35..d606afbabce1 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -263,7 +263,4 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
-#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
-	remap_pfn_range(vma, vaddr, pfn, size, prot)
-
 #endif /* __ASM_CSKY_PGTABLE_H */
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index a7a6d31a7a41..c35b4f809d51 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -94,12 +94,13 @@ phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr, phys_addr_t size)
 	return phys_addr;
 }
 
-int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	phys_addr_t phys_addr = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
 
-	return remap_pfn_range(vma, vaddr, phys_addr >> PAGE_SHIFT, size, prot);
+	return phys_addr >> PAGE_SHIFT;
 }
-EXPORT_SYMBOL(io_remap_pfn_range);
+EXPORT_SYMBOL(io_remap_pfn_range_pfn);
+
 #endif /* CONFIG_MIPS_FIXUP_BIGPHYS_ADDR */
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index ae73ecf4c41a..9c06a612d33a 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -604,9 +604,8 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
  */
 #ifdef CONFIG_MIPS_FIXUP_BIGPHYS_ADDR
 phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size);
-int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
-#define io_remap_pfn_range io_remap_pfn_range
+unsigned long io_remap_pfn_range_pfn(unsigned long pfn, unsigned long size);
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 #else
 #define fixup_bigphys_addr(addr, size)	(addr)
 #endif /* CONFIG_MIPS_FIXUP_BIGPHYS_ADDR */
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f1538a48484a..a9f802d1dd64 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -395,12 +395,8 @@ __get_iospace (unsigned long addr)
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffUL)
 
-int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
-		    unsigned long, pgprot_t);
-
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long from, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	unsigned long long offset, space, phys_base;
 
@@ -408,9 +404,9 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 	space = GET_IOSPACE(pfn);
 	phys_base = offset | (space << 32ULL);
 
-	return remap_pfn_range(vma, from, phys_base >> PAGE_SHIFT, size, prot);
+	return phys_base >> PAGE_SHIFT;
 }
-#define io_remap_pfn_range io_remap_pfn_range
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 64b85ff9c766..615f460c50af 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1048,9 +1048,6 @@ int page_in_phys_avail(unsigned long paddr);
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffffffffffUL)
 
-int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
-		    unsigned long, pgprot_t);
-
 void adi_restore_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pte_t pte);
 
@@ -1084,9 +1081,8 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 	return 0;
 }
 
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long from, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 	int space = GET_IOSPACE(pfn);
@@ -1094,9 +1090,9 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 
 	phys_base = offset | (((unsigned long) space) << 32UL);
 
-	return remap_pfn_range(vma, from, phys_base >> PAGE_SHIFT, size, prot);
+	return phys_base >> PAGE_SHIFT;
 }
-#define io_remap_pfn_range io_remap_pfn_range
+#define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
 
 static inline unsigned long __untagged_addr(unsigned long start)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2b08ab2c42b9..89e77899a8ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3677,15 +3677,24 @@ static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
-#ifndef io_remap_pfn_range
-static inline int io_remap_pfn_range(struct vm_area_struct *vma,
-				     unsigned long addr, unsigned long pfn,
-				     unsigned long size, pgprot_t prot)
+#ifndef io_remap_pfn_range_pfn
+static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
+		unsigned long size)
 {
-	return remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));
+	return pfn;
 }
 #endif
 
+static inline int io_remap_pfn_range(struct vm_area_struct *vma,
+				     unsigned long addr, unsigned long orig_pfn,
+				     unsigned long size, pgprot_t orig_prot)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+	const pgprot_t prot = pgprot_decrypted(orig_prot);
+
+	return remap_pfn_range(vma, addr, pfn, size, prot);
+}
+
 static inline vm_fault_t vmf_error(int err)
 {
 	if (err == -ENOMEM)
-- 
2.51.0


