Return-Path: <linux-fsdevel+bounces-74539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3663D3B982
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DD7304B3C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DEB2FC871;
	Mon, 19 Jan 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Msp1vNkg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dK3ttXiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003312E4247;
	Mon, 19 Jan 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857625; cv=fail; b=WSEog02vLZOK70128E+EfvyuUmViNuOSTTbsQVXJQORpn8K9H2dvRc8+nbFSviLADU3Pvyf3e3zTjycgC8MXB8PW8q7AdgBJvc9dJ812zWI/BoeGPwDx+z/85XZgce0X1eW1yD96/SpEIPossmjX3/PtYLc+PYW0VP3rOhIVlPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857625; c=relaxed/simple;
	bh=lN2zo8plwuQL26iQ6jwvv/erP/1urPmDjxiTE7wFu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nXJ0bY44KPYJN+BHIbwBftjC3bWvmgTeeveLQzcPovx1LEU7+jAHNtun4c11kfSiI1W9e0rDy/0WdeWndNElNtWnkyJ3fIfbdDlFVnEeGeB6FLVBYQsQDnlYRK6OcMxa/MkNN4YEgRN+hT1PhgSvSEuqtm2B5wx5jG8xh+gaqnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Msp1vNkg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dK3ttXiG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBD3nJ2082864;
	Mon, 19 Jan 2026 21:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=H3wWfWr54kqXxPcb
	EcBZnTTXMVJOxemNERw2B1bmdbU=; b=Msp1vNkgAiEmpR8zw/UE6X0MgAtXttWZ
	KbagPfc7hXQ1Wy6l+Q/3pBJoa7EFg8oMBlOakcrRt5Yko/7kCW6ZoGu4bW0BFj1w
	amWuokXqaP6Ml1sZdTdLiCdcCoom0zCYVhWkl6480W15ADNLNeV4vZmCYgASlmE6
	MYE//KXAiwl4p2PBT0IOHpyVCZ5DzTvmQpDpW8dvFWG1+c+0bUSrYQfIrPSk3z9e
	E1teMPOxf3o+MGRbbcPLy7l7xq6KOi7LnvHz4VoSe7DTKxt+c6jqYJjL0AuTPdPa
	NVmwem+/BaWfXnmbZph3sQMxPK7Q4hwlmYaZ5/jZA78Fmr9jFncRfg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2sx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIwScu037783;
	Mon, 19 Jan 2026 21:19:22 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8s2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF+glU73lTw8HTspa9rQwLzOMq4o/0Ro3ypB5lKYLU/SLIeKnbZMijFBDIldEwQKbl3HFsPfIZLV75D5JiV8QYRgh72EBMkOicKL6zZ5E14OMKWWOBTYmxH4iHvwSA4b8MZglvS7tJAeZqZNVYl+7WxVG3kxOzO3mgFKyxtCw1ZTKTfwIVSGbXPyeNlj+vPsY5/2SOgMT64LAFpKvrSkkDiKTHeKt0rEPXHjLiqRfT07XdHOdEPZXXjKFJcKgc7SBlHWxw3JwNHBSJoqpuezXecQRmQV6msJGZT9wwYu4kBfY+/vI6X0+532WbwW+kEoPDeZlvJaii0gIfQ6b6JvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3wWfWr54kqXxPcbEcBZnTTXMVJOxemNERw2B1bmdbU=;
 b=Kly0oSUG11aZOcMdwwssAxBukABz9ePgI1C20lBxO/JtmKtNKKbh3GBHccm1iWGuSMZ5VMuC88RAl2s0q20gEGf49//LPUAhuItpXPU1k3WvfbiGKYltSha0xD/FxTNPG+c60a/6+jr8p4+9f8AHC+PfueBrRv7PdPNuG1TJL82AJk0zq2a4qHQt+rfoZ1yxIvY83ctNho4xHKoefPDwoS32vvd/g5BXgBjPMRW5iIRsH0eVW3kEy2IBoJln28Lh+QOLoPFBLBzA6wXs6oZGHh023I4Izoefny8zxzhHoGFrtnoIe1nHpHqqOgLOsrSvVzi8725+mQ1DC7LeqfQEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3wWfWr54kqXxPcbEcBZnTTXMVJOxemNERw2B1bmdbU=;
 b=dK3ttXiGa1Jtr3Yh7OZecRH+hY+5Ex/ZbTK/1LFVvRTfQ2IhxkRfJNq0rKY3ino8DERdW1EvT65O6IruCWLlkYbI4seqDqqdaZnbsQYl7oltU9vUgygKe4O3Qwds9cJ6OFdcsYs5q3b0lWzuDxoThTADVkkMcx7czSduZKbtYyg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:16 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:16 +0000
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
Subject: [PATCH RESEND 00/12] mm: add bitmap VMA flag helpers and convert all mmap_prepare to use them
Date: Mon, 19 Jan 2026 21:19:02 +0000
Message-ID: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0647.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 41302201-2e70-4f23-5b2a-08de57a06670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XpSz+k9WwXwxRUew0md8ZH+Q4pvkBdYcZEqREPnr9H6uJerX1f1pGeU7CxJu?=
 =?us-ascii?Q?xmDm5eXjIooT0rGg6LPr86g0d1M9vfZrYYkuohczbn4MEKzcJUY3XeuYeZ1R?=
 =?us-ascii?Q?qx35C8qlrcjm196jmITGSIkzOdkUazr2pfhPlm6lGWOOD02/ODf1odSGIGB2?=
 =?us-ascii?Q?2kkav3rTx4H6pW4LSoOcvCOpiWkkpIua64RGvLzJ77yRNmviZ2VqEfXz28RH?=
 =?us-ascii?Q?3UkraOdDx+MblAp3o0418SZ+YRI46mF+UM7mm+cX5umqM+GVK6hwfMAqa89v?=
 =?us-ascii?Q?OQGECda1k1LrZRrW2mhVJWyGYaJVEVXgIz+L2OsmcYCGPVkF2aUXc3mQElSb?=
 =?us-ascii?Q?1UeM35A7ZYVj//P5SzYIDR6ChGSVk5OZdLnbJl084iiWVqvWlsLn6fLjGdwQ?=
 =?us-ascii?Q?RMzdtNkwSw82LP7NjJL6vazU4Jq0IVMsRl2/RQXhuD7lSPgpdq7e2e153Iuj?=
 =?us-ascii?Q?uYhJ4iaHg0SlJvonEWyS9Rpe/xK80Tl84bGqJRAFEvKf2UzVBIvhJd5R/EKT?=
 =?us-ascii?Q?7XCNL/QkhM8rqKekv4DRktpZlfrk+jTTnC98Hp5zcCAxta0CloTzBEAwaty4?=
 =?us-ascii?Q?VEuyJm+qEQ5uj/QlYrUJYRyBUnIaVKOCdn0xz6YuiFPGH3vaM8TNPfdGiqRN?=
 =?us-ascii?Q?QbeVWC5cJorcyWev5sLyxk5WEnCc5s1rEVhzIyRFjp0b/rUZXuFjub8RDW9o?=
 =?us-ascii?Q?MD6KxpDhI4aX6REige7dNwr4HkIUXMI8pr9KA6lmaak0//HJqUBLIUKa5cAb?=
 =?us-ascii?Q?eCb9puj0gRRsp9bEQwhR4zt3tekew7nlcMMG+lO+y65ovZru7BxX6F2bI2uj?=
 =?us-ascii?Q?VDJXB2q9AYM9xZvX5zhhgUf43Y3qlE6Ij4IcETY4fveRuyw7pFO4xLqu0otc?=
 =?us-ascii?Q?uDy+b5F7JlWjXw0Jt5xjVLN76J2abtZEeEJKC0gDXprv0oWJqSIqW/PCKAGe?=
 =?us-ascii?Q?jvXdkHG9Jo46se/rWYU8cMN4nW1lBrrhqdh/qgrZ4ihBucl90tPKI+J7CxCW?=
 =?us-ascii?Q?N3BUTaMUSu0/FHkaMED+dS3/G3c09wplXqgppsk7k7brHYsgkL85ME7TbSLa?=
 =?us-ascii?Q?C54ZJzn90Fv6jEZnDhOY/ivk4hq7Umql/uVmgDl2sVHnbsPY0YbmnjGCPSPS?=
 =?us-ascii?Q?z7XLe7NIypwdX89wZ3ii7TBKN5ilVicXEeZMKROQ0nYLD2sNViImQjwHec/p?=
 =?us-ascii?Q?xj0ZTDX5s3DoeHn3DwfvZtm5Kmz39MFiwt/Dh2tJ8CwCCCh0Wa18PlPugsCd?=
 =?us-ascii?Q?6uy2h0x1XrUyloIVe1ENKWOJcAxviJGbc36Js0QnIn0ZaMflhDqXIunQOvp+?=
 =?us-ascii?Q?7JYraVfwTw5Gp5+3gGe7lFBQpz4ehz1QCQm14wgFMucs1sMPphQCSZGBT11e?=
 =?us-ascii?Q?TJDpH4pobwjz9jbzuwKbq5kG/iQjxjZ5VNMWgoHBYQJW/XE5UYS4RImIVW0O?=
 =?us-ascii?Q?nVHqUWnpmyc8PwElqfDeDWuey37KewsU8R4GOvCC14bEz2GCIfzNR2i5E73g?=
 =?us-ascii?Q?2DEPJvWoFQrLT8Gx+H9rxqYqAZmg/WurB7qpwIOaTMMQwDMcKeQIt6NVY9r2?=
 =?us-ascii?Q?CwJgo7RPzceu84KrUdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vx7k3Gb/4pjTlp2nmg29MmjjRlPGvqtK967ADN0v6oFsZCHIGN9+X41Asz9S?=
 =?us-ascii?Q?HQ/r0PtiBsJu/7N/uA6E93Qe2cZ+bQhka9HTBnc2JZsiaN0X4s3XGyqSIxKm?=
 =?us-ascii?Q?Vfmp6kcmsX9kSD5P9HxcxcQBRrzgujMSs9q09QW7hUTENUgt7HO3GP7ZWRYX?=
 =?us-ascii?Q?Yatz9x6cwj8CKgoT0wW2CoXTl9S+qGapZChe8pt39BI7BqLePqB3ELCPcb4d?=
 =?us-ascii?Q?OKcpQxr/kaD9J5ZMVeWaKzaxVUDsWHPJVwMg11mRZ/66TolvkqxXfKxqKEJ9?=
 =?us-ascii?Q?Aj8fV3txI5bCZ0/IT1WohVNeYrZtgh1zuW53MZohjByCPSWA1vjUG+h55S1S?=
 =?us-ascii?Q?uxQh5BhP7x3HdAgCR5gygYF7Wh9gE/ZgbUIwoU1PL9LlPkio+WFR8G2bl840?=
 =?us-ascii?Q?n0OCIqo9zv1rPfZsHrLmsmvdWFPI/b2Uka9otlJhz1jZ7NHkwEAXz44bPnej?=
 =?us-ascii?Q?qDHb/nfUb18iHWxThUAAxWhqRDHKh0nubgbsBiH3Gb2Uy3n4cRMtcvwIopq+?=
 =?us-ascii?Q?ZAjceeS0RAb/EiUtKXZf6t7VqsDuepgjPXlkCxp3TCO2UInxhlijNLN/NjLi?=
 =?us-ascii?Q?WDFJXiA1BUoFMvqpqizEAh9qBDwtQECgTWr0WXjk/AAfakMSWFqExPub7s2T?=
 =?us-ascii?Q?+WEge4/TAC5Kvg1rY6vxd2hO2qvSUnYHgoA5f79nMoHCTZGZd+/ZLnn6b2BM?=
 =?us-ascii?Q?JIMBAw3KU0H3RxgCceDwKNQWGCBpF0FRYr/z1rW30A1zzsMbSsuf4EjXjeMv?=
 =?us-ascii?Q?1ixoKp4h6KqumSHnuT8gBcFsQ1Abqe93maQs0HJEp5lllK3FJR2SvfXk8fnp?=
 =?us-ascii?Q?TYkXlsjMLW3g+XAPtlKQoxKYL5Lc3cT5pYad43xSoqtroSU0pmFQo03JEiJ7?=
 =?us-ascii?Q?eJsWCEIIcEB48Z7SvrNVUR6gLaW0KWTcClTi38LqHvvoUgU6HmMDOwmz+bTc?=
 =?us-ascii?Q?DDR4EMNCsD3XgG0BHrgKkcnvh2kazGHdFyxnRdBzaNR+LaSSzMopspRlSdKJ?=
 =?us-ascii?Q?ZswSbb25w+JZ1xjcnP+SDmw+NXzPjnuIf0ePnamlO+PtJqFKK8Q77Xsdyudc?=
 =?us-ascii?Q?TqXGQWgH+d5Zkp1CwxD5NGT/a1T6CgIqMI5fi9nosvqOoScEIwxqzGw1ZpYF?=
 =?us-ascii?Q?bPlIFOHr/qO3Y01CLhGMypMFdQHdXzSfPDx6RGgbHSDZ9V01vIEWebjZ+O/b?=
 =?us-ascii?Q?rMu0IOJOYRLdbzJpf42eG5eh34dHCNiAv97AOFI0aRqu0hJKXS1TBei1DKew?=
 =?us-ascii?Q?vfEn7oTiiarKVsLaRaI3U5j7M7032C8fnAetMUkRNKDH/R4dhBrZnJxT6Ek4?=
 =?us-ascii?Q?bcxSzx9FifFL1l2KETDDr0FPDI0H/6O4cKeXktqqUHALO+2dx6jYp0xTxA/W?=
 =?us-ascii?Q?TYo9LqgKUWv4uzPjrkucYcfMoBM0rdiJZg/fvMgecIRnbaIGdK3UYHucDIar?=
 =?us-ascii?Q?3emDiWuho5UnybNnRU8PSDGyv1Ny0i66ldFkqlvxPlO5swafECjFp3N7OZWe?=
 =?us-ascii?Q?PkaJg2NMUS02VQhJQbBDuGMBRy8zp+mSBeaGrV7KYRctm7G+G7VDgO53/hV7?=
 =?us-ascii?Q?h0CuBnYEWH67FxUBFFRpfdIKRGcOy45AnETZfN6399kfB5PTavSdXrOgWI69?=
 =?us-ascii?Q?kWse4RCVhEOjG2uQIMBCUCcEHzLncLCxgrAZl/wNWjxRZ22UY+tA239P9Kq0?=
 =?us-ascii?Q?kJd34U64p/bvn7C4YdqRtUUNfhMnh+Ixx8YyJcWHROVDZXyIHe2Idb4a5Yqm?=
 =?us-ascii?Q?1N/wfSaDPCYvOJEGDUlpTVst3EHwVJk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HSknyJKTMEreqoe/kunnAs1AxQdKX64cOsU7jmwphzyxWf0uUgaj7DHdju6fr/QGrSU2qjx3KtQ8QxsYXbhjjpvcvdKw0xy2aW7HRZrThCcgWohpdh3SdS8ABDvWoieocX2edmetEcD3WV159lQe8/TPsbA0jnt4ZLzIp3O4XIhPbZ/KDeCFH0el90lemHBuQXEqB3fRP0Vne+eL1/pYtjFUEFisyn9zjiKCsQFsU4HVDYuSWMgobmEmwNO1sBeUkAzLCgRIXsP3UAb8BPdGlDwXqR9wR+ELHRFl7q8W6ZtOpF4+0c9kqsP/k6WuobWWiWwzhJjYGUWw53qG7SRIj5UWHk96q4hLHwLb76K1pYCA+CnkRrMzYidaY+TXoYQS4tmEcoV4zmGTczv1f0C6a++W5RHoMNTmeIuFK/Ty6LgWPe97sX4jX6kK3NWoe2ZAiW8D3At1ZIqoyWyMK0Nl5NzBFVLG+OhCiaQN523N+n8figFwQGU64l2CK9mur/gJhfZ2/hQeahXvakO/oxbY065cZwUIePezmuh9Lx/phiEqm4y+c6jcN/p1Fva5h7dhNHk8H6Q1U9+g8LdQ5kTEnHRghJsLpgFAGbpmk1XAVU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41302201-2e70-4f23-5b2a-08de57a06670
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:16.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCK0qm9fuALFWMnB13Tayt7/Lh1hCBLAaoYN5x14SgCga+k3nTAGY/jx5wcvp/rHGECt0UhCNDIbLM3y7IOBWpFFMVXk4JpKlo5bOvzjUYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfXy3KqRqLUCA7z
 KHzdcC67Q9pugbyi0RrU240RMIpIGmIki8OdaEFc7JHb9YXjQDteO/4+KsOwbqlPHK5P3Swk2lF
 UhKUY2EaXy/G3nr+DEQohqOZUaLmtxzLdlAtOrX/BU6FtqxodWyNmn6FKCKLDxau6h+xgL1c0Gb
 wpFtk6PQ0abswJHdEMJI9PM2psqGEK1k3/NAHeOmHZTRg1ib13afAjHczoMBbNs4wX9C3TuL9Fr
 +Tfp5Iv/ko7oXI1bW4o+nVSNnmYBRdZVzmWgIhfkjbR+bHx+kTfB7IWksTQNmCnfyW3LzXCIgWr
 ETKv3UsUG45WmEUIPQLVR4HKLvqVd4NaaCtnHB7uf611Hchr3vSW3tIxh0sTHZiLqnLKM7EtuJy
 fKJhIZ/Mm3fdv1uoJGGLy0Gw+T25l7H8tb5dNNqVJ9NhyKrM/nX3C2n8fUI222tific6VD9iLdL
 +CXpZHBGgbVHprMejAA==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e9fdb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Gu8Ga86ZO7ieT4smRq8A:9
X-Proofpoint-ORIG-GUID: N2DrmTO0p8jiWbaG5iDMocQret2g2sHD
X-Proofpoint-GUID: N2DrmTO0p8jiWbaG5iDMocQret2g2sHD

We introduced the bitmap VMA type vma_flags_t in the aptly named commit
9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
future growth in VMA flags and to prevent the asinine requirement that VMA
flags be available to 64-bit kernels only if they happened to use a bit
number about 32-bits.

This is a long-term project as there are very many users of VMA flags
within the kernel that need to be updated in order to utilise this new
type.

In order to further this aim, this series adds a number of helper functions
to enable ordinary interactions with VMA flags - that is testing, setting
and clearing them.

In order to make working with VMA bit numbers less cumbersome this series
introduces the mk_vma_flags() helper macro which generates a vma_flags_t
from a variadic parameter list, e.g.:

	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
					 VMA_EXEC_BIT);

It turns out that the compiler optimises this very well to the point that
this is just as efficient as using VM_xxx pre-computed bitmap values.

This series then introduces the following functions:

	bool vma_flags_test_mask(vma_flags_t flags, vma_flags_t to_test);
	bool vma_flags_test_all_mask(vma_flags_t flags, vma_flags_t to_test);
	void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set);
	void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear);

Providing means of testing any flag, testing all flags, setting, and clearing a
specific vma_flags_t mask.

For convenience, helper macros are provided - vma_flags_test(),
vma_flags_set() and vma_flags_clear(), each of which utilise mk_vma_flags()
to make these operations easier, as well as an EMPTY_VMA_FLAGS macro to
make initialisation of an empty vma_flags_t value easier, e.g.:

	vma_flags_t flags = EMPTY_VMA_FLAGS;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	if (vma_flags_test(flags, VMA_READ_BIT)) {
		...
	}
	...
	if (vma_flags_test_all_mask(flags, VMA_REMAP_FLAGS)) {
		...
	}
	...
	vma_flags_clear(&flags, VMA_READ_BIT);

Since callers are often dealing with a vm_area_struct (VMA) or vm_area_desc
(VMA descriptor as used in .mmap_prepare) object, this series further
provides helpers for these - firstly vma_set_flags_mask() and vma_set_flags() for a
VMA:

	vma_flags_t flags = EMPTY_VMA_FLAGS:

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
	...
	vma_set_flags_mask(&vma, flags);
	...
	vma_set_flags(&vma, VMA_DONTDUMP_BIT);

Note that these do NOT ensure appropriate locks are taken and assume the
callers takes care of this.

For VMA descriptors this series adds vma_desc_[test, set,
clear]_flags_mask() and vma_desc_[test, set, clear]_flags() for a VMA
descriptor, e.g.:

	static int foo_mmap_prepare(struct vm_area_desc *desc)
	{
		...
		vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
		vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
		...
		if (vma_desc_test_flags(desc, VMA_SHARED_BIT) {
			...
		}
		...
	}

With these helpers introduced, this series then updates all mmap_prepare
users to make use of the vma_flags_t vm_area_desc->vma_flags field rather
than the legacy vm_flags_t vm_area_desc->vm_flags field.

In order to do so, several other related functions need to be updated, with
separate patches for larger changes in hugetlbfs, secretmem and shmem
before finally removing vm_area_desc->vm_flags altogether.

This lays the foundations for future elimination of vm_flags_t and
associated defines and functionality altogether in the long run, and
elimination of the use of vm_flags_t in f_op->mmap() hooks in the near term
as mmap_prepare replaces these.

There is a useful synergy between the VMA flags and mmap_prepare work here
as with this change in place, converting f_op->mmap() to f_op->mmap_prepare
naturally also converts use of vm_flags_t to vma_flags_t in all drivers
which declare mmap handlers.

This accounts for the majority of the users of the legacy vm_flags_*()
helpers and thus a large number of drivers which need to interact with VMA
flags in general.

This series also updates the userland VMA tests to account for the change,
and adds unit tests for these helper functions to assert that they behave
as expected.

In order to faciliate this change in a sensible way, the series also
separates out the VMA unit tests into - code that is duplicated from the
kernel that should be kept in sync, code that is customised for test
purposes and code that is stubbed out.

We also separate out the VMA userland tests into separate files to make it
easier to manage and to provide a sensible baseline for adding the userland
tests for these helpers.


v1 resend:
* Rebased on mm-unstable to fix vma_internal.h conflict tested and confirmed
  working.

v1:
https://lore.kernel.org/all/cover.1768834061.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (12):
  mm: rename vma_flag_test/set_atomic() to vma_test/set_atomic_flag()
  mm: add mk_vma_flags() bitmap flag macro helper
  tools: bitmap: add missing bitmap_[subset(), andnot()]
  mm: add basic VMA flag operation helper functions
  mm: update hugetlbfs to use VMA flags on mmap_prepare
  mm: update secretmem to use VMA flags on mmap_prepare
  mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
  mm: update all remaining mmap_prepare users to use vma_flags_t
  mm: make vm_area_desc utilise vma_flags_t only
  tools/testing/vma: separate VMA userland tests into separate files
  tools/testing/vma: separate out vma_internal.h into logical headers
  tools/testing/vma: add VMA userland tests for VMA flag functions

 arch/x86/kernel/cpu/sgx/ioctl.c            |    2 +-
 drivers/char/mem.c                         |    6 +-
 drivers/dax/device.c                       |   10 +-
 drivers/gpu/drm/drm_gem.c                  |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c  |    2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |    3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c      |    3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c    |    2 +-
 drivers/gpu/drm/ttm/ttm_backup.c           |    3 +-
 drivers/gpu/drm/ttm/ttm_tt.c               |    2 +-
 fs/aio.c                                   |    2 +-
 fs/erofs/data.c                            |    5 +-
 fs/ext4/file.c                             |    4 +-
 fs/hugetlbfs/inode.c                       |   14 +-
 fs/ntfs3/file.c                            |    2 +-
 fs/orangefs/file.c                         |    4 +-
 fs/ramfs/file-nommu.c                      |    2 +-
 fs/resctrl/pseudo_lock.c                   |    2 +-
 fs/romfs/mmap-nommu.c                      |    2 +-
 fs/xfs/scrub/xfile.c                       |    3 +-
 fs/xfs/xfs_buf_mem.c                       |    2 +-
 fs/xfs/xfs_file.c                          |    4 +-
 fs/zonefs/file.c                           |    3 +-
 include/linux/dax.h                        |    4 +-
 include/linux/hugetlb.h                    |    6 +-
 include/linux/hugetlb_inline.h             |   10 +
 include/linux/mm.h                         |  244 ++-
 include/linux/mm_types.h                   |    9 +-
 include/linux/shmem_fs.h                   |    8 +-
 ipc/shm.c                                  |   12 +-
 kernel/relay.c                             |    2 +-
 mm/filemap.c                               |    2 +-
 mm/hugetlb.c                               |   22 +-
 mm/internal.h                              |    2 +-
 mm/khugepaged.c                            |    2 +-
 mm/madvise.c                               |    2 +-
 mm/memfd.c                                 |    6 +-
 mm/memory.c                                |   17 +-
 mm/mmap.c                                  |   10 +-
 mm/mremap.c                                |    2 +-
 mm/secretmem.c                             |    7 +-
 mm/shmem.c                                 |   59 +-
 mm/util.c                                  |    2 +-
 mm/vma.c                                   |   13 +-
 mm/vma.h                                   |    3 +-
 security/keys/big_key.c                    |    2 +-
 tools/include/linux/bitmap.h               |   22 +
 tools/lib/bitmap.c                         |   29 +
 tools/testing/vma/Makefile                 |    7 +-
 tools/testing/vma/include/custom.h         |  119 ++
 tools/testing/vma/include/dup.h            | 1332 ++++++++++++++
 tools/testing/vma/include/stubs.h          |  428 +++++
 tools/testing/vma/main.c                   |   55 +
 tools/testing/vma/shared.c                 |  131 ++
 tools/testing/vma/shared.h                 |  114 ++
 tools/testing/vma/{vma.c => tests/merge.c} |  332 +---
 tools/testing/vma/tests/mmap.c             |   57 +
 tools/testing/vma/tests/vma.c              |  339 ++++
 tools/testing/vma/vma_internal.h           | 1847 +-------------------
 59 files changed, 3042 insertions(+), 2303 deletions(-)
 create mode 100644 tools/testing/vma/include/custom.h
 create mode 100644 tools/testing/vma/include/dup.h
 create mode 100644 tools/testing/vma/include/stubs.h
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

--
2.52.0

