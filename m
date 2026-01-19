Return-Path: <linux-fsdevel+bounces-74549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3C0D3B9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ADD4303FCFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBF2FCBFC;
	Mon, 19 Jan 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4Msj6AR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AD+Xngb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3012FF170;
	Mon, 19 Jan 2026 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857676; cv=fail; b=JBFo9K+9XqBvN0/tSQVcPUM2uGMoBudcUVUvejSROq1DoSq1jGPHQN24mSN7uPuiEkAPFamamxHpblwZJPK8qfK55nMdmk+dCgVlmVvb5xywTldOiU6KV3Vaat1BhJkyNKHL50BcZ39ni8B5nv/qs1EScRnc2Mp3lfDSvbt1OzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857676; c=relaxed/simple;
	bh=zjXIakHROFDamDX9ccqnYv7e4Xmgu4tLWNtqyz4pXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oi7CFj7vrWqeGuqPjaDyQX12N/Udo16IgnLsosjsZHUgyaDvoe9LzRkm89vYvRKR4tysVPZuN7wa9SGWt97b+Loye1P+oxGZcHsrVO5A41Qb8Pj2WEmQQBRxlUV6YG//8EK+525zCAKVrCnNFqUNdtl2EcEwAngp7V3SJqtqusg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r4Msj6AR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AD+Xngb8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDOrS1034535;
	Mon, 19 Jan 2026 21:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UDjo2nNsWLEHjXs1PGZed1/rQkkEvTUzM5Pi4fekjns=; b=
	r4Msj6ARJ82T26+sQzm5e0yW3A/Q0yPL829YnL9m2zn2O09zDvobX+VWUdjZoKKt
	k1fhNnYISWPisyZe6BcW+bku9EXjbjbQCHNgg9FvPGXM4xPeaOevRE+TqGCElJMg
	inKtZUBdKGza6CH2XF8zpHYOciVK/2dJp1iYptRzUESr1lq35Mm8JudKiub4rB/b
	ohBa4DP85OumDncNnSrFeKVv0aomVm2dNn8NXRtrofe+M7q+Noi2Co3ZrurS/rG1
	D8ZQgF7WeMA+EmaIkTPQkENPLXu2MPXVOrR1raitJx2JMIIN8VS3A3ZflkmjDEBb
	N83LxsK2roiexvssdTvx6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vtrk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIQNgU017988;
	Mon, 19 Jan 2026 21:19:52 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sb8j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0R+hrQLg0Qn78iTrLzc7Fj79q2TFSfKMEkrQe8bO4ox+vLu4UJxnYvsY9DBUSCL1aDhpCaRLSeUglm/4TQlRIUvpGj97UeE56wdgZL/tH5dNo5AY0yM8URNTwSYt/f5qJ9QhRdzPT1vQJa62UnoFc27MGdgdwff2S4Lu1NTsnZRK+ytIdkWf2sCEMXzwHcugUM5XzKb2l5Ty+lTnb7pRXMZgxpA5tNYwJq1hbbRtAs4IthZ+2qOsNoyNQpU5XxxZAlhFv31nU7GsHwflaK0OAeMTgQcfF3Hn/N/zYOi5I2nWtxpb60dV9uJzS6QvAPzFlWLodFeCOElnFbbdA2tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDjo2nNsWLEHjXs1PGZed1/rQkkEvTUzM5Pi4fekjns=;
 b=szd3jUmgNuCydZFStr5Gkzrp/BISnJqNlUAxlwVrW3hXeue5abCFJs3JK91qTuFsqZU8LRequZCFNLMuXPGaBdKRuJlhqMSN9vSBsoMMeS9Mty1nQOgegKtT9BHti/TGAaklPxPY6RtEe5IgR0qT7VmUyM43N8ztiz+OevC7yvQZNYd/w6wQtuHBnBEN0OYqDfzeVi+0OHwOX7KEEpaG7N2DDgSOnHLZ2Gh74RDRaqKkEfaGTKVqdNnFuiwNCaIjo3LySRUxRR72W9411+CuZRewJ7seOkKle06HHxkDRgt8Tj78GakX4whFCGdfJ8kCfSNzYi60VSyvORpDZUTWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDjo2nNsWLEHjXs1PGZed1/rQkkEvTUzM5Pi4fekjns=;
 b=AD+Xngb8tetrpHXDf6eiQRUCDKemYPtOFZNxqyz8ccmmiqIeVUAoBc+aYVdKbIa3N3+Viiv+T7dQYFEiOzvJjOeTNDhFHxZjF/T505ymABuNZ9n7nbDFTsLnrj9EdIXmTJZuciEcJtKtyUSa4a5bxZwf5PpLV6tMwfaHibFmmj4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:44 +0000
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
Subject: [PATCH RESEND 10/12] tools/testing/vma: separate VMA userland tests into separate files
Date: Mon, 19 Jan 2026 21:19:12 +0000
Message-ID: <85b10911ce3528223d45c6cefbea2499863cb3a4.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 973de10b-e6f9-4e3a-6c51-08de57a07750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxnWWu+7g0klO7nuErNZ+cF8R4gUxMVzSTQKpmjopvCcYrzm7frTEsRotnBa?=
 =?us-ascii?Q?Pm/duh3oZbvQj/ExcFFOI7wBu6c5kOkfK8k8fv9noe0oiVTOnCyrb8HJ0BYn?=
 =?us-ascii?Q?BVMH6Fjezfm1juJvafz5Wl++LByq2ww5AWkvhqvb1ImmaUiouRuHuDXtSlBj?=
 =?us-ascii?Q?M4sxqOmmmRCbJxMKcAk76ED9Na4jkF5EHOQpCT5v3RAZdDWsQndnk6Ytd7Lv?=
 =?us-ascii?Q?De9v8HO+lzuMTWGvCV2+drBis233vHq6u5fEXDoe7v0f6YPk0g/eV4FGcSFY?=
 =?us-ascii?Q?ZUKNSIh0j87JFN2vNZ+Ma7bbM8OYgKMhaNUCBu19EJ8tTSBUjd5G7urpZiNA?=
 =?us-ascii?Q?SGcugtp8EXNyGB1MVnCLa7YyN9IRyXJ0V/c18pi/COXPYg5NfztDyykIgvXv?=
 =?us-ascii?Q?KPQcoRyXHYtZVxNk460beSCZo16T2JgY+Kzyn6QDbzOrD5AgEMenSd5sX7S1?=
 =?us-ascii?Q?PqZxbtB0Mklw6xArYDx9h6uwk2sliqGvU69NnV9d9FnGqs1muXys8T2LSA3X?=
 =?us-ascii?Q?lAHWmchZIGnbr1zg0hTKdAZUa8T4d0Yqaa+QjOlqcePnsHLApkn3AHnNuRJA?=
 =?us-ascii?Q?q47R+wn7O+ezikLqNsZS2MYMzQ/Q+X0OoOBOMg9Gy03i3VYQFQMO2USsw3g4?=
 =?us-ascii?Q?xYiCQhBs0JwvEgN3PVPf3nfTcf1bHWf8MPzQBC2N5LUHGHF3xEBg4jQGAxfp?=
 =?us-ascii?Q?PVBq3f1nm+eNRWmwLBfqF5Xrtzig2NlPRw2FolFu0VO+UGOQ8ch4knp8H2RY?=
 =?us-ascii?Q?C6ie0wMuZVsPPNSGQIRTn1dzWVHCttvMuINmkz4oE/XdK2JNqdc3DMBZ371j?=
 =?us-ascii?Q?u87ceFh1P46Zm5h16aHwRhV9MbvUdZUA3LELovRJ1DA4N9TW6S7dVQuFEoDO?=
 =?us-ascii?Q?3IR1mnrUa77+iotiEaxFMXM6rRJXv907LqwAw64e1uwVDHWzpq5BxEjqXPhO?=
 =?us-ascii?Q?U49Q8s+4G7gFzhKb8ZZ9K3F15pklinu3pglRZ1ViKNvl4UVbD1wugev3+Mj0?=
 =?us-ascii?Q?zYLUvyNEs7ICekm5nzMntWuaJcZ5LEFpX6UGyHJ0A9VgSdDaZdX6xbF6w4XI?=
 =?us-ascii?Q?9XGHVcOwlPLee/xsGwMsJZv2U3x86FiqgdUU3CU6XR1gte60fSDSOvK3LDZd?=
 =?us-ascii?Q?5Y6q+zqSwE3OjP+FFwdUhSMcP6FBwox8UJfbPd9pVqXKt2+V29aWVufEy04t?=
 =?us-ascii?Q?QNUjNEdjFuD4g0I7Vbk6hC/sehZvE4SdvgqbtWSlQYfuYrWQq/MDSYVKxJ5u?=
 =?us-ascii?Q?yVyeb+egQYBkazDm+F6q01BHYD6sMUhzsrEELK6h/Qr/5P21IjBNOIMTgCbr?=
 =?us-ascii?Q?njCeNZ8rlzG9SEH2qhalNd048C0WocpDXAGNREt3LRhX5Hrh655bIYRKA8EP?=
 =?us-ascii?Q?4dJQ45I75BEHUP/b9Qt57ZMmCSGqyJTvRh6+/ZEE+78Cmli2heyLs5jba4Ra?=
 =?us-ascii?Q?cSIily0Xy2dSQ1piSCDhRyqJeCOFNiET9ODBehuECsnrrjulK/5y67tHBViz?=
 =?us-ascii?Q?qNPud5K1DOiL/mdKdL2Zm1y+RB1aKcxLPEA+D3fwwE+TV2OywK3HyFJHHdfE?=
 =?us-ascii?Q?yfrbdquHFDOCGtBil4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m6N4GP6prGhKpCFOiHTVTxSB56Y2p7lUjn1UwU9752Zw8MlAYJqB4qHudsRR?=
 =?us-ascii?Q?kSXVKd/H7nEIFzomJtRwlJEVXImFjc+jKIWBZcY7tHGJ4EDmCMV9N0VmAuC7?=
 =?us-ascii?Q?VUjs43N2kLyUtHRGAqrSNHaHWtccUWDBisF3CEC1uDY2w4AqkmuZ8MUTAp+G?=
 =?us-ascii?Q?8BqIfNaDbjlEz8HDgZIYBNHi1lSxJCTrSRP1JHb9CKD2DhnY5OkY8sw2scjI?=
 =?us-ascii?Q?uvu+8aaC05k16fhTUeXDaw610XpJak8uLyQZuKOAOj2hCXgiQm+tafWWvLB9?=
 =?us-ascii?Q?CB+OEdvAV4irGYWGTuxcuLEVMKoKGhsWUjjK/Tvq+EiEuJNXuLJw6wOSGa+h?=
 =?us-ascii?Q?0zv6LuZ9vx1HD13dxZfclvkAHQ08m47AquaVAMN9w0nWLEm8qyCHQyWOwrLH?=
 =?us-ascii?Q?fuIk36jx2TC9VQM1s7u/oh+3af2hCQKLUoJtOiLGwJoyeacvTIaVKX9T9PRO?=
 =?us-ascii?Q?9SYjP+EOYWeyyGTvM6Ng69KtC9SjA1LxQiTcWJqK+gPdMQ84OolbtkUXqk53?=
 =?us-ascii?Q?QyQnVX3wA2uRb6E4vGgAsF7zX3F3T/2E2tgHc53Nmvc5sQFbfVo9XkPtAOX2?=
 =?us-ascii?Q?G/G3INbKO9j7j0w7HVP2xbqzAT3BTxPodbS/0sF6x+sLmbCV0ggv+BJTA3Cb?=
 =?us-ascii?Q?N7TykJFjewGj2ZXocsb2xnMhzy2CL93XXk6YHhKBe8O9zFx6PN24v7R6qRWD?=
 =?us-ascii?Q?PuP1dNsaS90SVR91D+dvnwqtVg9mooDRVv30gVADK6TacaeC8P+Fz6Tg8UcV?=
 =?us-ascii?Q?Ru4enOXu+LiQneIhAu6HBXKT5mHFppwZ9NbufnIObUbxDCl9GNST+ShBQelj?=
 =?us-ascii?Q?ZfewDe4Tk9BK9InDAqXuurhfkrt2IBPz7KgC7mqcA8DKjY2QFfvPVAYHumOT?=
 =?us-ascii?Q?n44tFrNzwtvDwhLlHw4+PBOMx2krUjEZyF+T3sXPgcuYZRYOBTxkxr5m7bNp?=
 =?us-ascii?Q?fHc/vO8EmNH0tvY2mg/dISWzwkZsDihBGEeBCxQ6AUlOBq2+7/sqFeg7AdGB?=
 =?us-ascii?Q?CZp6wKhUunRy82ppIPryfVYqA/vb92ClcdP1IyPXqcyDR3youO9C0FWlvh8a?=
 =?us-ascii?Q?V1XSgetyaj+bwTyGWS5kwYRO8g3SJ8LZtUhikQf0EtJlhn7bdazurEHsFXAb?=
 =?us-ascii?Q?DRTEAVB7QQOafzFF9kvrKFgJB/od1Krsn+nCXVWSKj168jaDj9Sj5aNBtZZ/?=
 =?us-ascii?Q?G6qLhXFvDbH/9WjNoOfUkyRazXgd4i/4L/p80ifLzlbCkRshy5+0qkP53fl1?=
 =?us-ascii?Q?/WJOa+rEGgqu+oBBCtKecFiFfugQfHNowBONMQkzYIp9aXqySgSXWVaCk2ln?=
 =?us-ascii?Q?NMU1AvNDNwn2K48Ss03qwNOFfE3TbGeII/EnDSTGH+ngDByGjJ1+e/1IjnKy?=
 =?us-ascii?Q?KeHD2zjNgUHOthFTdP3zBwG9k3A0C6bqTuIfULLEcO+dQuA4T1RIP5SfxlUE?=
 =?us-ascii?Q?zIkGRVvsMFlaCtsjXYnA4SgmHUgEJcmylo1kcgpIqR7cdd+taSelfID7iqLd?=
 =?us-ascii?Q?LbidsijGvcCH2NrpMVN9JeugjGveq4BFXXG1QnPKh3e8Bk1qbQgvjEyXOb0u?=
 =?us-ascii?Q?3OwkM0xZAfTOYxwckCl5IsqCSWfz4yRs1hm0F/3HY+fFZ4o13KGJpuEzBHCP?=
 =?us-ascii?Q?N1bipV2kodqMwe4QEnqnXL5xR3czo7iHPrG1IMOT4hqGq1du349Y1HW7G79d?=
 =?us-ascii?Q?GvvEUZyl7O1veLchG86pM2sF/vMBRiqbUeku7X/k86cIcuORHx64H10pzVKn?=
 =?us-ascii?Q?Op9o/is1L8goHeiwDz49FFcAWKtv4QI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3+dQ0J1T9yqZq1CEFkhSk6YSGk/YAJ+LfXuuC9OH2yXVJbmi/bm0AYH7JA2ahOYVIpPufvjiPWhA7FPtgP6EjBWJcytTPwvu65KGx2CuGgMApayyG+lVUvNXHYxmiXFR/zjqXlFVgitGJuMdTqnsV0RAiXsB8faHL7iAqOPzdFpnQNUfnllCuWCiGc0linurp+WI1N0Pm1GhHBIRG2inBA9Cx6a5Xq3ICrlA+HOu4KkuKkP4Apj9K5m5cDOLIVa3Nfo7dcu/CWhztqTCp9uC873htV36TgLpSZJKVwwNSC0nYPzvIn2VaYI1Wu3hlvjr90FETMByMUmlY3O0qA4u8a/kxbzqeuRRCQfNVsbQFQP8LC8Ih35AMy3xUXLoc4776tUDX5OZMOzo1ylgXVTF/Je/8YCo9qbYf4jlPI0yC3E4JI4kNl0ywGDcqjHyH5a0gIQU+ywyXL7j0bROLFl6IGWAnB5L3YKmjh6imdZOh46zaSGDq93zaNerEpmp5BWpYoSfxgOtHoQiQcf7mcU6rR03x/nJNDHJ60UU1c1omT1RHi/PXw7XCgzv6ywjhnelfdt7DQxOoAn8vRzOMtJI7d640qk0xt0n/dJQit+Rv6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973de10b-e6f9-4e3a-6c51-08de57a07750
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:44.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZInzatZGbrR/ZBbxiE5pot3dtQpAUrEJTNeOYwV6xPNm25hDPMUZkeHP9wkIPJEnY+Rn0AKqQKi4i118xNYN5ibo3trl8RGdMx4JeP8FWEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696e9ff9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5uttRRLgS_GaOMRt2q4A:9
X-Proofpoint-GUID: 2alLrJLLiCxaUaPFkSBU7zbEPJDVeNWz
X-Proofpoint-ORIG-GUID: 2alLrJLLiCxaUaPFkSBU7zbEPJDVeNWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX7C4xDgJI86m4
 OLj/DN3KNEt9zhsStct6/+WXfm09qt280WU23u8YhDbm3wg7ODKptOPmr1NBo75NIMHUabaKb7V
 +uW2JJm+yEOiPDJ3ExLrUWRiHO80Pbb+DvBFY5Wr7ad70/D0aLnI4Vzhq1DhR3JJkI+3YEDKg/H
 Z/q7gDEJ/uvpQGp4FyH/xhFjCAAPHH31Mxj8Ia37/J9evZxNCNwYg7gwCZYyzvco9NTUKzzLz9c
 UyLNnuWxCzfe1H92BSQQrtt+KbLOy5X34R8lLd7G75SppEzAkXeJeAK814cF/BAKO/QzNtd3lBd
 gMrFWBx/5KcuUuPR5HqT1mELFlvUd9wtLGdNXWEsWYEgyUvxifv5LNyFEEjQ8V6LqXZsGnG0JRE
 TaBvEOnFIZhc2DXkSzUtfUz2tyfHieo2JJJ03BC1oy1O5AqT4RPU8zU0htISMiOd9SUsA/jkSaD
 J4qT2itotsYfGLPNvHg==

So far the userland VMA tests have been established as a rough expression
of what's been possible.

qAdapt it into a more usable form by separating out tests and shared helper
functions.

Since we test functions that are declared statically in mm/vma.c, we make
use of the trick of #include'ing kernel C files directly.

In order for the tests to continue to function, we must therefore also
this way into the tests/ directory.

We try to keep as much shared logic actually modularised into a separate
compilation unit in shared.c, however the merge_existing() and attach_vma()
helpers rely on statically declared mm/vma.c functions so these must be
declared in main.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile                 |   4 +-
 tools/testing/vma/main.c                   |  55 ++++
 tools/testing/vma/shared.c                 | 131 ++++++++
 tools/testing/vma/shared.h                 | 114 +++++++
 tools/testing/vma/{vma.c => tests/merge.c} | 332 +--------------------
 tools/testing/vma/tests/mmap.c             |  57 ++++
 tools/testing/vma/tests/vma.c              |  39 +++
 tools/testing/vma/vma_internal.h           |   9 -
 8 files changed, 406 insertions(+), 335 deletions(-)
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/shared.c
 create mode 100644 tools/testing/vma/shared.h
 rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
 create mode 100644 tools/testing/vma/tests/mmap.c
 create mode 100644 tools/testing/vma/tests/vma.c

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 66f3831a668f..94133d9d3955 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -6,10 +6,10 @@ default: vma

 include ../shared/shared.mk

-OFILES = $(SHARED_OFILES) vma.o maple-shim.o
+OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma

-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
+main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h

 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
new file mode 100644
index 000000000000..49b09e97a51f
--- /dev/null
+++ b/tools/testing/vma/main.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma_init.c"
+#include "../../../mm/vma_exec.c"
+#include "../../../mm/vma.c"
+
+/* Tests are included directly so they can test static functions in mm/vma.c. */
+#include "tests/merge.c"
+#include "tests/mmap.c"
+#include "tests/vma.c"
+
+/* Helper functions which utilise static kernel functions. */
+
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma;
+
+	vma = vma_merge_existing_range(vmg);
+	if (vma)
+		vma_assert_attached(vma);
+	return vma;
+}
+
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	int res;
+
+	res = vma_link(mm, vma);
+	if (!res)
+		vma_assert_attached(vma);
+	return res;
+}
+
+/* Main test running which invokes tests/ *.c runners. */
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+	vma_state_init();
+
+	run_merge_tests(&num_tests, &num_fail);
+	run_mmap_tests(&num_tests, &num_fail);
+	run_vma_tests(&num_tests, &num_fail);
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
new file mode 100644
index 000000000000..bda578cc3304
--- /dev/null
+++ b/tools/testing/vma/shared.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "shared.h"
+
+
+bool fail_prealloc;
+unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
+unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+struct anon_vma dummy_anon_vma;
+struct task_struct __current;
+
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (vma == NULL)
+		return NULL;
+
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vm_flags_reset(vma, vm_flags);
+	vma_assert_detached(vma);
+
+	return vma;
+}
+
+void detach_free_vma(struct vm_area_struct *vma)
+{
+	vma_mark_detached(vma);
+	vm_area_free(vma);
+}
+
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags)
+{
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
+
+	if (vma == NULL)
+		return NULL;
+
+	if (attach_vma(mm, vma)) {
+		detach_free_vma(vma);
+		return NULL;
+	}
+
+	/*
+	 * Reset this counter which we use to track whether writes have
+	 * begun. Linking to the tree will have caused this to be incremented,
+	 * which means we will get a false positive otherwise.
+	 */
+	vma->vm_lock_seq = UINT_MAX;
+
+	return vma;
+}
+
+void reset_dummy_anon_vma(void)
+{
+	dummy_anon_vma.was_cloned = false;
+	dummy_anon_vma.was_unlinked = false;
+}
+
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
+{
+	struct vm_area_struct *vma;
+	int count = 0;
+
+	fail_prealloc = false;
+	reset_dummy_anon_vma();
+
+	vma_iter_set(vmi, 0);
+	for_each_vma(*vmi, vma) {
+		detach_free_vma(vma);
+		count++;
+	}
+
+	mtree_destroy(&mm->mm_mt);
+	mm->map_count = 0;
+	return count;
+}
+
+bool vma_write_started(struct vm_area_struct *vma)
+{
+	int seq = vma->vm_lock_seq;
+
+	/* We reset after each check. */
+	vma->vm_lock_seq = UINT_MAX;
+
+	/* The vma_start_write() stub simply increments this value. */
+	return seq > -1;
+}
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma)
+{
+	vma->anon_vma = anon_vma;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	list_add(&avc->same_vma, &vma->anon_vma_chain);
+	avc->anon_vma = vma->anon_vma;
+}
+
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc)
+{
+	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
+}
+
+struct task_struct *get_current(void)
+{
+	return &__current;
+}
+
+unsigned long rlimit(unsigned int limit)
+{
+	return (unsigned long)-1;
+}
+
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
new file mode 100644
index 000000000000..6c64211cfa22
--- /dev/null
+++ b/tools/testing/vma/shared.h
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#pragma once
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "generated/bit-length.h"
+#include "maple-shared.h"
+#include "vma_internal.h"
+#include "../../../mm/vma.h"
+
+/* Simple test runner. Assumes local num_[fail, tests] counters. */
+#define TEST(name)							\
+	do {								\
+		(*num_tests)++;						\
+		if (!test_##name()) {					\
+			(*num_fail)++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
+extern bool fail_prealloc;
+
+/* Override vma_iter_prealloc() so we can choose to fail it. */
+#define vma_iter_prealloc(vmi, vma)					\
+	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
+
+#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
+
+extern unsigned long mmap_min_addr;
+extern unsigned long dac_mmap_min_addr;
+extern unsigned long stack_guard_gap;
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern struct anon_vma dummy_anon_vma;
+extern struct task_struct __current;
+
+/*
+ * Helper function which provides a wrapper around a merge existing VMA
+ * operation.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg);
+
+/*
+ * Helper function to allocate a VMA and link it to the tree.
+ *
+ * Declared in main.c as uses static VMA function.
+ */
+int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+
+/* Helper function providing a dummy vm_ops->close() method.*/
+static inline void dummy_close(struct vm_area_struct *)
+{
+}
+
+/* Helper function to simply allocate a VMA. */
+struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/* Helper function to detach and free a VMA. */
+void detach_free_vma(struct vm_area_struct *vma);
+
+/* Helper function to allocate a VMA and link it to the tree. */
+struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+		unsigned long start, unsigned long end,
+		pgoff_t pgoff, vm_flags_t vm_flags);
+
+/*
+ * Helper function to reset the dummy anon_vma to indicate it has not been
+ * duplicated.
+ */
+void reset_dummy_anon_vma(void);
+
+/*
+ * Helper function to remove all VMAs and destroy the maple tree associated with
+ * a virtual address space. Returns a count of VMAs in the tree.
+ */
+int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi);
+
+/* Helper function to determine if VMA has had vma_start_write() performed. */
+bool vma_write_started(struct vm_area_struct *vma);
+
+void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma_chain *avc, struct anon_vma *anon_vma);
+
+/* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
+void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+			    struct anon_vma_chain *avc);
+
+/* Helper function to specify a VMA's range. */
+void vma_set_range(struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   pgoff_t pgoff);
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/tests/merge.c
similarity index 82%
rename from tools/testing/vma/vma.c
rename to tools/testing/vma/tests/merge.c
index 93d21bc7e112..3708dc6945b0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1,132 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later

-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "generated/bit-length.h"
-
-#include "maple-shared.h"
-#include "vma_internal.h"
-
-/* Include so header guard set. */
-#include "../../../mm/vma.h"
-
-static bool fail_prealloc;
-
-/* Then override vma_iter_prealloc() so we can choose to fail it. */
-#define vma_iter_prealloc(vmi, vma)					\
-	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
-
-#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
-
-unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
-unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
-
-/*
- * Directly import the VMA implementation here. Our vma_internal.h wrapper
- * provides userland-equivalent functionality for everything vma.c uses.
- */
-#include "../../../mm/vma_init.c"
-#include "../../../mm/vma_exec.c"
-#include "../../../mm/vma.c"
-
-const struct vm_operations_struct vma_dummy_vm_ops;
-static struct anon_vma dummy_anon_vma;
-
-#define ASSERT_TRUE(_expr)						\
-	do {								\
-		if (!(_expr)) {						\
-			fprintf(stderr,					\
-				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
-				__FILE__, __LINE__, __FUNCTION__, #_expr); \
-			return false;					\
-		}							\
-	} while (0)
-#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
-#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
-#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
-
-#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
-
-static struct task_struct __current;
-
-struct task_struct *get_current(void)
-{
-	return &__current;
-}
-
-unsigned long rlimit(unsigned int limit)
-{
-	return (unsigned long)-1;
-}
-
-/* Helper function to simply allocate a VMA. */
-static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
-					unsigned long start,
-					unsigned long end,
-					pgoff_t pgoff,
-					vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = vm_area_alloc(mm);
-
-	if (vma == NULL)
-		return NULL;
-
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-	vm_flags_reset(vma, vm_flags);
-	vma_assert_detached(vma);
-
-	return vma;
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	int res;
-
-	res = vma_link(mm, vma);
-	if (!res)
-		vma_assert_attached(vma);
-	return res;
-}
-
-static void detach_free_vma(struct vm_area_struct *vma)
-{
-	vma_mark_detached(vma);
-	vm_area_free(vma);
-}
-
-/* Helper function to allocate a VMA and link it to the tree. */
-static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
-						 unsigned long start,
-						 unsigned long end,
-						 pgoff_t pgoff,
-						 vm_flags_t vm_flags)
-{
-	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
-
-	if (vma == NULL)
-		return NULL;
-
-	if (attach_vma(mm, vma)) {
-		detach_free_vma(vma);
-		return NULL;
-	}
-
-	/*
-	 * Reset this counter which we use to track whether writes have
-	 * begun. Linking to the tree will have caused this to be incremented,
-	 * which means we will get a false positive otherwise.
-	 */
-	vma->vm_lock_seq = UINT_MAX;
-
-	return vma;
-}
-
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
@@ -146,20 +19,6 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	return vma;
 }

-/*
- * Helper function which provides a wrapper around a merge existing VMA
- * operation.
- */
-static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
-{
-	struct vm_area_struct *vma;
-
-	vma = vma_merge_existing_range(vmg);
-	if (vma)
-		vma_assert_attached(vma);
-	return vma;
-}
-
 /*
  * Helper function which provides a wrapper around the expansion of an existing
  * VMA.
@@ -173,8 +32,8 @@ static int expand_existing(struct vma_merge_struct *vmg)
  * Helper function to reset merge state the associated VMA iterator to a
  * specified new range.
  */
-static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
-			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
+void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
+		   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
 {
 	vma_iter_set(vmg->vmi, start);

@@ -197,8 +56,8 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,

 /* Helper function to set both the VMG range and its anon_vma. */
 static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
-				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
-				   struct anon_vma *anon_vma)
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		struct anon_vma *anon_vma)
 {
 	vmg_set_range(vmg, start, end, pgoff, vm_flags);
 	vmg->anon_vma = anon_vma;
@@ -211,10 +70,9 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
  * VMA, link it to the maple tree and return it.
  */
 static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
-						struct vma_merge_struct *vmg,
-						unsigned long start, unsigned long end,
-						pgoff_t pgoff, vm_flags_t vm_flags,
-						bool *was_merged)
+		struct vma_merge_struct *vmg, unsigned long start,
+		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
+		bool *was_merged)
 {
 	struct vm_area_struct *merged;

@@ -234,72 +92,6 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
 }

-/*
- * Helper function to reset the dummy anon_vma to indicate it has not been
- * duplicated.
- */
-static void reset_dummy_anon_vma(void)
-{
-	dummy_anon_vma.was_cloned = false;
-	dummy_anon_vma.was_unlinked = false;
-}
-
-/*
- * Helper function to remove all VMAs and destroy the maple tree associated with
- * a virtual address space. Returns a count of VMAs in the tree.
- */
-static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
-{
-	struct vm_area_struct *vma;
-	int count = 0;
-
-	fail_prealloc = false;
-	reset_dummy_anon_vma();
-
-	vma_iter_set(vmi, 0);
-	for_each_vma(*vmi, vma) {
-		detach_free_vma(vma);
-		count++;
-	}
-
-	mtree_destroy(&mm->mm_mt);
-	mm->map_count = 0;
-	return count;
-}
-
-/* Helper function to determine if VMA has had vma_start_write() performed. */
-static bool vma_write_started(struct vm_area_struct *vma)
-{
-	int seq = vma->vm_lock_seq;
-
-	/* We reset after each check. */
-	vma->vm_lock_seq = UINT_MAX;
-
-	/* The vma_start_write() stub simply increments this value. */
-	return seq > -1;
-}
-
-/* Helper function providing a dummy vm_ops->close() method.*/
-static void dummy_close(struct vm_area_struct *)
-{
-}
-
-static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				     struct anon_vma_chain *avc,
-				     struct anon_vma *anon_vma)
-{
-	vma->anon_vma = anon_vma;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	list_add(&avc->same_vma, &vma->anon_vma_chain);
-	avc->anon_vma = vma->anon_vma;
-}
-
-static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
-				   struct anon_vma_chain *avc)
-{
-	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
-}
-
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
@@ -1616,39 +1408,6 @@ static bool test_merge_extend(void)
 	return true;
 }

-static bool test_copy_vma(void)
-{
-	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-	struct mm_struct mm = {};
-	bool need_locks = false;
-	VMA_ITERATOR(vmi, &mm, 0);
-	struct vm_area_struct *vma, *vma_new, *vma_next;
-
-	/* Move backwards and do not merge. */
-
-	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
-	ASSERT_NE(vma_new, vma);
-	ASSERT_EQ(vma_new->vm_start, 0);
-	ASSERT_EQ(vma_new->vm_end, 0x2000);
-	ASSERT_EQ(vma_new->vm_pgoff, 0);
-	vma_assert_attached(vma_new);
-
-	cleanup_mm(&mm, &vmi);
-
-	/* Move a VMA into position next to another and merge the two. */
-
-	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
-	vma_assert_attached(vma_new);
-
-	ASSERT_EQ(vma_new, vma_next);
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
 static bool test_expand_only_mode(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -1689,73 +1448,8 @@ static bool test_expand_only_mode(void)
 	return true;
 }

-static bool test_mmap_region_basic(void)
-{
-	struct mm_struct mm = {};
-	unsigned long addr;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, &mm, 0);
-
-	current->mm = &mm;
-
-	/* Map at 0x300000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x300000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x300, NULL);
-	ASSERT_EQ(addr, 0x300000);
-
-	/* Map at 0x250000, length 0x3000. */
-	addr = __mmap_region(NULL, 0x250000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x250, NULL);
-	ASSERT_EQ(addr, 0x250000);
-
-	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x303000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x303, NULL);
-	ASSERT_EQ(addr, 0x303000);
-
-	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
-	addr = __mmap_region(NULL, 0x24d000, 0x3000,
-			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
-			     0x24d, NULL);
-	ASSERT_EQ(addr, 0x24d000);
-
-	ASSERT_EQ(mm.map_count, 2);
-
-	for_each_vma(vmi, vma) {
-		if (vma->vm_start == 0x300000) {
-			ASSERT_EQ(vma->vm_end, 0x306000);
-			ASSERT_EQ(vma->vm_pgoff, 0x300);
-		} else if (vma->vm_start == 0x24d000) {
-			ASSERT_EQ(vma->vm_end, 0x253000);
-			ASSERT_EQ(vma->vm_pgoff, 0x24d);
-		} else {
-			ASSERT_FALSE(true);
-		}
-	}
-
-	cleanup_mm(&mm, &vmi);
-	return true;
-}
-
-int main(void)
+static void run_merge_tests(int *num_tests, int *num_fail)
 {
-	int num_tests = 0, num_fail = 0;
-
-	maple_tree_init();
-	vma_state_init();
-
-#define TEST(name)							\
-	do {								\
-		num_tests++;						\
-		if (!test_##name()) {					\
-			num_fail++;					\
-			fprintf(stderr, "Test " #name " FAILED\n");	\
-		}							\
-	} while (0)
-
 	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
@@ -1771,15 +1465,5 @@ int main(void)
 	TEST(dup_anon_vma);
 	TEST(vmi_prealloc_fail);
 	TEST(merge_extend);
-	TEST(copy_vma);
 	TEST(expand_only_mode);
-
-	TEST(mmap_region_basic);
-
-#undef TEST
-
-	printf("%d tests run, %d passed, %d failed.\n",
-	       num_tests, num_tests - num_fail, num_fail);
-
-	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
new file mode 100644
index 000000000000..bded4ecbe5db
--- /dev/null
+++ b/tools/testing/vma/tests/mmap.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_mmap_region_basic(void)
+{
+	struct mm_struct mm = {};
+	unsigned long addr;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/* Map at 0x300000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x300000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x300, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Map at 0x250000, length 0x3000. */
+	addr = __mmap_region(NULL, 0x250000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x250, NULL);
+	ASSERT_EQ(addr, 0x250000);
+
+	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x303000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x303, NULL);
+	ASSERT_EQ(addr, 0x303000);
+
+	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
+	addr = __mmap_region(NULL, 0x24d000, 0x3000,
+			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
+			     0x24d, NULL);
+	ASSERT_EQ(addr, 0x24d000);
+
+	ASSERT_EQ(mm.map_count, 2);
+
+	for_each_vma(vmi, vma) {
+		if (vma->vm_start == 0x300000) {
+			ASSERT_EQ(vma->vm_end, 0x306000);
+			ASSERT_EQ(vma->vm_pgoff, 0x300);
+		} else if (vma->vm_start == 0x24d000) {
+			ASSERT_EQ(vma->vm_end, 0x253000);
+			ASSERT_EQ(vma->vm_pgoff, 0x24d);
+		} else {
+			ASSERT_FALSE(true);
+		}
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_mmap_tests(int *num_tests, int *num_fail)
+{
+	TEST(mmap_region_basic);
+}
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
new file mode 100644
index 000000000000..6d9775aee243
--- /dev/null
+++ b/tools/testing/vma/tests/vma.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+static bool test_copy_vma(void)
+{
+	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	bool need_locks = false;
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_new, *vma_next;
+
+	/* Move backwards and do not merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	ASSERT_NE(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0);
+	ASSERT_EQ(vma_new->vm_end, 0x2000);
+	ASSERT_EQ(vma_new->vm_pgoff, 0);
+	vma_assert_attached(vma_new);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move a VMA into position next to another and merge the two. */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_assert_attached(vma_new);
+
+	ASSERT_EQ(vma_new, vma_next);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static void run_vma_tests(int *num_tests, int *num_fail)
+{
+	TEST(copy_vma);
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 8143b95dc50e..cb20382f86b9 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1127,15 +1127,6 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 	atomic_inc(&mapping->i_mmap_writable);
 }

-static inline void vma_set_range(struct vm_area_struct *vma,
-				 unsigned long start, unsigned long end,
-				 pgoff_t pgoff)
-{
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
-}
-
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
--
2.52.0

