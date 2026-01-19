Return-Path: <linux-fsdevel+bounces-74449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC35D3AE4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B37B305ABC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACB38E100;
	Mon, 19 Jan 2026 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bw+Q7P0k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l4gu3TXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014238B7D1;
	Mon, 19 Jan 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834364; cv=fail; b=UIK8Ck/NtuEca0KIJv0A0jaXrdlbh8RJ9gdGwjDsjvyNY3vI4g2j4naKFz+XAJ4efsAK+ySdUmk0xBjVWed57unjT5A1awtXFwL9QLiDSi7nWQ/Fp9ZntFP3q/RTMuTQiCBo3x0k/OWBc5N7FlPNRmZ44Ao3Osq6+zn6NUD1sqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834364; c=relaxed/simple;
	bh=mnZzor2W2nyPOVvFUFd1CzKiA1dklJ1P1tttQaSm0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYPyBNaRII1UqQ3dY2XuVtnE8V660hpDqg0uGmqVGg7JK9Q6PH6j2bD/Y95UcgsxnFKrrbMIl9NF0jzLvFr5eb1TpX2i7Au1Rve7UwK+8L7F6y5sZ/DRuuul7yUXeqe67y0GcO3loSA0JY4O0xnv2DfbQ74FrsRBf5B8RXmucIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bw+Q7P0k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l4gu3TXT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDXfw1037611;
	Mon, 19 Jan 2026 14:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ctA8qY8T5dYTYwkDZoWAeI+X4GSCPkORK7HeJOKMCso=; b=
	bw+Q7P0ksprDmNBWXgytaDM3FNp31FW2II3/NmTn6v1XGD0B8ZazBMFOERe64UJv
	rexcqNobcNQcnq6m1H7bfn1PdW+vRx2Vvn9BEfobrIsMG9YKf5lrs3CONzNCeny4
	fhDfvkyXELNCWY/xJUfnjQItpXNxyQu7Mh/41D6RxUSMmSPjAAwtdQZVza6B0GgW
	MBOvkViZdEsmQAtjKEF6Jhut5Q6RSdkL3I8dheuv6dPrHNZ/8itF2OxjgrunJ12e
	ikkryI7g+7Vwk5Dr8yEaxCbMW7qOBnKcA0QciuXogARqahmJpYDx89hh43/9aA6K
	J/YK+PRPyDK3bmcwlcc7ig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypt9sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JESSKr040610;
	Mon, 19 Jan 2026 14:51:39 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc8501-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDKdRGxH5A5AYlVdBJRcd+RsGEX1EIoYqTRdoYvRRyLK5dEngDGRJ5we+1QKyQVsGo4ntr+T0VGzSVXPQYra1VnzKvFuqyhd/zEc2/tQofWXn/7/mMoxMI1SHTDEXIu6pcQbJI1JuOiTbRUYXi75WvRW3XlahsIHzdQlr5uetZJDZrFzzc6AYqWnWrj+5ACkeMiLFVzM0si1x3OGNqqxZbvtclg5GPMzp3q6ipBAb7mxBgPiGIPnbDueCnHnAd0mgc/a4HV45QXLoLQZGiplEUnArOtKOR1cJ7AyR7HpgIk/VV6dojLA+pv8f3XWlCaVfJDn38KFuguDFMgCLtb0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctA8qY8T5dYTYwkDZoWAeI+X4GSCPkORK7HeJOKMCso=;
 b=rypuIT06YmSrITlpN3waRNlx4YbD7X7ttAhVD/hvDYpE5kqxylPIg+NN+/nOw5gDey/vySa7MduHgwqZNBFyvfYWV7uHIP0IGiTL0RzqFXDY2Jl+RP07rBMV+StiCs0mpXQW4jaF16yzsOB26ygo4e8FhqPX1PWLcDA49mKuv4RwOyqcNLMV0mzZ9lPUyqlM1JJ1fpHi8QQfpezMxhqGt3ifmNmMXCVDOfnlkf+Y6MtkqB/DphGbnp8GWln7FsVjagL2E456uYoKWxYtcA/V//ohypPL5jSBptJjR4f8zOJcyiRVdqujycsCqNX26VU53A4yjXiUBh/sDrS3QtcycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctA8qY8T5dYTYwkDZoWAeI+X4GSCPkORK7HeJOKMCso=;
 b=l4gu3TXTHCcjY2OLBVq02V9kERvZvXJaN1jrVQ1ga0wQQftVs4QlevYKVHASl4eM8QRXehMa0rwROTqhc0LtD8jJmNZILAlx0mkjp+GxR4Q4Oj1vLlwaQr3jwF0ytDDAPG5HBELZxLcGpyAU9stC77UxWMNV80n5wmBZBF+Jvvo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:51:34 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:34 +0000
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
Subject: [PATCH 04/12] mm: add basic VMA flag operation helper functions
Date: Mon, 19 Jan 2026 14:48:55 +0000
Message-ID: <6662dd9fe977edc7dde233edf5d762ee14a43fa0.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ed7f76-dd1a-4241-1bb7-08de576a3d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnWOie/EZRYP6uxSkJ4xvW8h4D4pDExs0e/virclpXrqR0ECMqTOg3zi7cSa?=
 =?us-ascii?Q?64IxQvcDquzc1rso0bdcHgkazhQNm8B4/ocv7f+qxtieLnU8NJdVX/zHweOp?=
 =?us-ascii?Q?4/71ZCslSCaaH6Vsuzwz/P0dT1ZKiLre8hrbswB1dXYCNOMh7egUXJ+z1LbN?=
 =?us-ascii?Q?gssLvQjmWuaMC2DV52yAbQYsTgFpvzK4ZDPs6UK8mYSElPPnC5IJDyLOCYuu?=
 =?us-ascii?Q?u3aDjTqqK5qBu4Gt9NhjrXijeEORnV7juOwOoVyUiEfPagNCwie7bv6c2P+Q?=
 =?us-ascii?Q?4dC0bBwNWPhmmWD2GggVCz9/xsOWmxv4Ob/KqpB1kKntgbq9PaDPXwJu57U5?=
 =?us-ascii?Q?uOASsBb42MdBa8E75iU55eRzGrvZlCeR578j/Gk06SRqBuVoQ3775lLc6jRp?=
 =?us-ascii?Q?zQXgphHRktMmUxG7YqtNNM3XjjlnE0W2gTa+5E+88MXjRvctFDf9xWI0wv4h?=
 =?us-ascii?Q?lnSz/U7OSCp18ePjmCqSnIJ0/EEM5kPG0ou123TPhcemz7OFs4Oy8ZDYgU+F?=
 =?us-ascii?Q?nw14z8GnR7TsuCvgYkoNiJldDCbOwQekYSfteFd7bIw2ChEfBXrrMlqdZT/F?=
 =?us-ascii?Q?QO3dZPl54nrr/Hs9wG6qOeG7z/yfkFiaOAoiPVbCdLHhyB9UVUEIEieoIxw3?=
 =?us-ascii?Q?fBtV0TupxDhNS5KCo63zkaqgoJyChuSx/ZLTwXTjwWyKuqKMz/jUbWcu6KZA?=
 =?us-ascii?Q?Msf52mBO97LMWXfO2NQSblm91+Rfc7UHSf3v/0jyfTGBwyPRF+Imu/t9iUk1?=
 =?us-ascii?Q?fcILDzwAmjUHgDRamav0GtNwYrffpyCOdz8R3n1lLDxLPDCngV5oJLEdDIvr?=
 =?us-ascii?Q?ve03tJxyVnwkiBpjYlV6XKK/p7H85eokizocAA0/Rzt26mO9BcKl6zcAmdvf?=
 =?us-ascii?Q?ztrm7u8z9kxaNus7siiaHO2UcqYXDCh5DSCBcTmaRK0z3/k40SSNYI6Hjfhz?=
 =?us-ascii?Q?tMFymP3X3YaIE6cVaT5EbynGeX1zDwr1vGASgCgUDZDe5RYAxS65F+Lg+5/Z?=
 =?us-ascii?Q?BZEEZx6u8eAsc6cSMBse//EVmOtin/AmgcyBjH05R0S8TjdvgxvgeuOYJ9vf?=
 =?us-ascii?Q?CGBvmysWoNp8oxoWDGc4ygshScIaTeZIhh+XrNacKbRmPEjJ7M5jHUwNxUvd?=
 =?us-ascii?Q?+1z6HaLmix37USH72/rehDJJyVFDaU2RvAy/UjCmrWuw74OxtJKS342ltIkr?=
 =?us-ascii?Q?yRT5tv8VG9wkA/peRZ84w4quCtMnK6QIVh8/ZFDNwE3gnqrxRXXOUlRCvtRa?=
 =?us-ascii?Q?vzy+adrx0ailQeB7pS0PzPi3QBecNGEoBBDQt9nZXk0E2prvkDs64KUKxMHr?=
 =?us-ascii?Q?j/bk1VHReoDTEfU/Mo5vq1+xx/JdlhbDAlxN8raMiBzgExu6+DXqecj96Y4o?=
 =?us-ascii?Q?fbozrzgH8R+RXm1PnOI3pG2X+yjhuw8mzUKpd6dWt2nbWTzaSLqS2CJWKfGy?=
 =?us-ascii?Q?kQHAsSneuDsOEsf0Q8lUt7oB1gmOmwSFKKM+MSoN4H2E6AVBk44EwZ9vAWRW?=
 =?us-ascii?Q?Bs637T9Or1demg9JlgrQ8HyVQOnfqDTz796vbJeBkME7CKG2q6WqQ/PRLrB2?=
 =?us-ascii?Q?c3tupy1yU9IHfR54rx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APabFCrliDxAkr6B36bIJ1z6kmsnkKX4xlOiNCxB6ZVZGOFG1HNMAQi1lk9K?=
 =?us-ascii?Q?ufNn8U6kjKYXcdA0gSmWUZMrP2dDJKnBmaM/dihusrUZ50UnHecFIJ59wlT1?=
 =?us-ascii?Q?Gsn6gTlmoliBZPf46z2VB8H0c5WNk1MAPqVEEMW3TDEA7kUM2w/u6vjrquPW?=
 =?us-ascii?Q?H4kxQZ5mGNyl5VBd86wOgkTvzksQrawbX0064u4RASITw/rQZ4/KW5KOKRud?=
 =?us-ascii?Q?RTqpDCSTLSRDESCkqZZg5udn1ASQ4XeyqRae9LNOCpGHPPORud7q/mDo1OIY?=
 =?us-ascii?Q?0964dBzuc3bngVbv+T96qoug50oz2kpMoZIKtaCKuxlp/nCqAxFpwtg9iTMm?=
 =?us-ascii?Q?L0ls27G/+1uiEImBIiy9po4+0UoHKQTxPaunH6fLT0TBLA+jV/Q7jaiIZ8Wz?=
 =?us-ascii?Q?tGeGlGDTSCf5NLZXLjVEhkLNenmZ8IA4etFUeRV3i8lEM2wOIjRFK1YcW3RE?=
 =?us-ascii?Q?k3xC2D/tP/B18AfPysR6rIfNNZKel7CW9RsarN4QLAxFQJW8WXBSPQjaKq2N?=
 =?us-ascii?Q?HF7UN1cGOsQuWlvuIW0o53atn8ARnqiLLHWKq0apTtEoQrW7A5uJjEh0Tvga?=
 =?us-ascii?Q?Edbc1js//K2VxD5iDkFgOZgs+pF7dXQF7F8VyqZ1JGYEu89NnW/GJcUYznF8?=
 =?us-ascii?Q?8GFn+VRU1kKsykb3XLJHqD18vS1GB0ehcpzgoYkwtQH1RvhXOl0Op96c75Z9?=
 =?us-ascii?Q?RarPV3nwr4hD1D+Kixz9ZF59/7QiVwYY70DBhXNXJ2YomX+7OczYMamcXRKu?=
 =?us-ascii?Q?gwWRdAys/V5Z/v2J3nfPhpDD3zNy/Lohb7nqcWuIu14MM8lHsEWNsCu3EkB7?=
 =?us-ascii?Q?Tksk7zv6P3/rdMoGLL03357cd9UILfpuG0kEJ7VgMQTqis4LcaBgNVzUxa3T?=
 =?us-ascii?Q?3sz9+lWO4ku2UZUHa79oWxBKDO/TNnXy5zgdlVxeA51aRKYRN/1BQaBXz6kf?=
 =?us-ascii?Q?xMXyVHMqiNxhMx4ti95w4AtqLA8kQdOaQf57y7O5HYoWsYx0SDZiW5xiyJtA?=
 =?us-ascii?Q?Nxf93Jm6fPEecBMFqAhFhb3/xlawjXCMqcHh9sqBrHlOvU+qLg3O5D21PKFE?=
 =?us-ascii?Q?67Vjp0+BnGnyz9ExzDZyBhKEOcnm1pQZ9AcvcVn3tc4UwAZeVeOlNdV3tn43?=
 =?us-ascii?Q?3xuCn9HCkxeGqdV55WuYq1MpaAA04Py80oDWz0IT7c3SupIo4NPDtHCDQ1lg?=
 =?us-ascii?Q?UI+AIMZMI4j0d5fJu3Tj8OWcUuyB3WW2+9MbEB1HkE1f6LKfOhBafDyDGeJF?=
 =?us-ascii?Q?1WU04OmGwTJBlFNKN1Mk7HUjqLDV5BnwOzA0OK3hpNObDOcSBrrp1YxBuiJS?=
 =?us-ascii?Q?LPA3fZ5aNX/Oev0+7QXmFzr5RWzaxZoTt26Vp1YvG1I92owsKEoQAqmQ7maw?=
 =?us-ascii?Q?eewNsEjPhl3NBAS2oRn0lRdU5XWSD8mvskvBbyczJL+K4DLfJi4bosWfzti1?=
 =?us-ascii?Q?/kfkKovGC7TOWt3/0Sm3itA4vEt4NpwSvyxnwaAr2x+cr+0pzFW6pu9jNyIW?=
 =?us-ascii?Q?FuqPsMF3Em96s5W5259qfvv+y77nZLcnaA6g07xRZJQ0sI4SbvRpEqz/aPef?=
 =?us-ascii?Q?6PYiUvuN51gjwjRwckIASK09C4mBR3EfEzsmR5olthCA0bdXBNowjWsNueAy?=
 =?us-ascii?Q?Ub9UWRHCPIm917IV/IjQnv0X8uNnGz0v/F9SvWiJmliJ2jwNYpp1NgFk6jVu?=
 =?us-ascii?Q?bfo2PcJ9Byk7pYe56fhWdJxu0CfvpOdR2/GyupB3CXyWCi/uEKjfoI2TbNVs?=
 =?us-ascii?Q?Jta+PZaqHJkgmtrJDIVoLce2ygsvN84=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V9mm3ONkfSUaKtiktIwkLnt7use6uyzUKP+25qyDwdzdXRReQ2xDxy+eKLkL+Kzl+BNb02cA4aQjWPKpJdIlat3lZcp93nRy8YL978578Pwajp+w8P2w7mIGZ/xNzt+eCTUPzvqw41/vGyUppC8kw9q6rJ5KPCogyWeZxxfShjlpeuIaANrQ5ZWpmleohC6gNHdWSm3eZos6kD4Zz0SdV42djK6Pyyj2l+sqdp0CO3HyyieRG3hoiOsL0/SHnhB+4sleQ/7u+a4shY4OirtrR3GyN1zfplD3Oo3uFYjW1YpaagKP8DB3/2v5YGYluQVW2HVaRzZ6WZE/ZKQcPHAwYvwA7RyzVcIoqpYGcEHKYhKd0M8Xs4jaNqObwKACR2m8OI1Eb5l+nSGn3MDxS5bi/ggnVrlCmzpTMP2HGKG1AV+5Xk6xLXxTEnhhLydACKL6V6jAn2+YZjQaiLWDtTTgZEK7RTs3j8thMoOSe0yEHUvI85jQZa2JvgdXBvAooXfn9xupZEmdMQz+khTv8XVSZo7D4ujp/Li/FU0EWHYNezdg546+qKyYFxMVrapGpc+8EG2N8ktIy1mFnNi4+AbRNbcMVlZRJPqlI3aGa9xmL8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ed7f76-dd1a-4241-1bb7-08de576a3d6a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:34.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot6Fdqwg6jI+sawZZiIW17Dj3CHDkGDRhNAAEOKFHyE+bryifs50Cfagm/L3BAeSx2KflTcODguqLIgP9z2PWZZshrMie3l4BsehpljomhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX0BjMc9HeoMtI
 V900+fl4n5Fww5HlDUMD79xCEag1aO6912T7BLYdr/fzfOznKyBF4rctNEPug12Lxd/CzsoVhr6
 IPKpTV4CjbV4bh9wIxeMW7CJlQi1UBNQJuAAZxE+N9iCV0pDB1uMIpTAoJVOhEUzfoHTl98Iwq+
 KkivgXyMsfAaIyrHLnti/mnaMf+I7IvP9zRaQ3qR+PKOxyAGri9pHHYqo2fjV2NEAdkeIi53GXt
 YkH0rdLUx4DhrB2PzNF9D9a+FvXTm3aLlexzkUmeMF1rY7wRXlA2mAHL3ALgDE69Tf2vufli341
 KEObxkJrQfaJbQwmG3cScGAh4MTpaMMOd0iW3LcpM9N7/TbxavuVJqJyUeI2ZD1QxxCAFc2u/hv
 S0AxE39PqunqvENzGcjBwfI1LlDUe6AWcbcavFc4pFY0X5yZzEPKLs8ZEZENV+e207CbHpLPC8V
 0nyFMG8xQiUzwJCbLyCJDTUyckSSoIFkiwvlNgXA=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e44fc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UDVvRVEZh_dx9K85IDkA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: WxMX-kPCgKi4hvHQUo2-B-EM6tebwXrh
X-Proofpoint-GUID: WxMX-kPCgKi4hvHQUo2-B-EM6tebwXrh

Now we have the mk_vma_flags() macro helper which permits easy
specification of any number of VMA flags, add helper functions which
operate with vma_flags_t parameters.

This patch provides vma_flags_test[_mask](), vma_flags_set[_mask]() and
vma_flags_clear[_mask]() respectively testing, setting and clearing flags
with the _mask variants accepting vma_flag_t parameters, and the non-mask
variants implemented as macros which accept a list of flags.

This allows us to trivially test/set/clear aggregate VMA flag values as
necessary, for instance:

	if (vma_flags_test(flags, VMA_READ_BIT, VMA_WRITE_BIT))
		goto readwrite;

	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT);

We also add a function for testing that ALL flags are set for convenience,
e.g.:

	if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) {
		/* Both READ and MAYREAD flags set */
		...
	}

The compiler generates optimal assembly for each such that they behave as
if the caller were setting the bitmap flags manually.

This is important for e.g. drivers which manipulate flag values rather than
a VMA's specific flag values.

We also add helpers for testing, setting and clearing flags for VMA's and VMA
descriptors to reduce boilerplate.

Also add the EMPTY_VMA_FLAGS define to aid initialisation of empty flags.

Finally, update the userland VMA tests to add the helpers there so they can
be utilised as part of userland testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 165 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h         |   4 +-
 tools/testing/vma/vma_internal.h | 147 +++++++++++++++++++++++----
 3 files changed, 295 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 36c3a31a4e0e..ea7c210dc684 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1062,6 +1062,171 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
 
+/*  Test each of to_test flags in flags, non-atomically. */
+static __always_inline bool vma_flags_test_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether any specified VMA flag is set, e.g.:
+ *
+ * if (vma_flags_test(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Test that ALL of the to_test flags are set, non-atomically. */
+static __always_inline bool vma_flags_test_all_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Test whether ALL specified VMA flags are set, e.g.:
+ *
+ * if (vma_flags_test_all(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Set each of the to_set flags in flags, non-atomically. */
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_set = ACCESS_PRIVATE(&to_set, __vma_flags);
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Set all specified VMA flags, e.g.:
+ *
+ * vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/* Clear all of the to-clear flags in flags, non-atomically. */
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_clear = ACCESS_PRIVATE(&to_clear, __vma_flags);
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Clear all specified individual flags, e.g.:
+ *
+ * vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
+ */
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to test that ALL specified flags are set in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline bool vma_test_all_flags_mask(struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(vma->flags, flags);
+}
+
+/*
+ * Helper macro for checking that ALL specified flags are set in a VMA, e.g.:
+ *
+ * if (vma_test_all_flags(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
+ */
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/*
+ * Helper to set all VMA flags in a VMA.
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags in a VMA, e.g.:
+ *
+ * vma_set_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ *
+ * Note: appropriate locks must be held, this function does not acquire them for
+ * you.
+ */
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to test all VMA flags in a VMA descriptor. */
+static inline bool vma_desc_test_flags_mask(struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for testing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * if (vma_desc_test_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
+ *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
+ */
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to set all VMA flags in a VMA descriptor. */
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for specifying VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+/* Helper to clear all VMA flags in a VMA descriptor. */
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for clearing VMA flags for an input pointer to a struct
+ * vm_area_desc object describing a proposed VMA, e.g.:
+ *
+ * vma_desc_clear_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 78950eb8926d..c3589bc3780e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -834,7 +834,7 @@ struct mmap_action {
 
 	/*
 	 * If specified, this hook is invoked when an error occurred when
-	 * attempting the selection action.
+	 * attempting the selected action.
 	 *
 	 * The hook can return an error code in order to filter the error, but
 	 * it is not valid to clear the error here.
@@ -858,6 +858,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
 
+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 7fa56dcc53a6..656c5fe02692 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -21,7 +21,13 @@
 
 #include <stdlib.h>
 
+#ifdef __CONCAT
+#undef __CONCAT
+#endif
+
+#include <linux/args.h>
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
@@ -38,6 +44,8 @@ extern unsigned long dac_mmap_min_addr;
 #define dac_mmap_min_addr	0UL
 #endif
 
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
 #define VM_WARN_ON(_expr) (WARN_ON(_expr))
 #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
 #define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
@@ -533,6 +541,8 @@ typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
 
+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -882,6 +892,123 @@ static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
 	return __pgprot(vm_flags);
 }
 
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	__set_bit((__force int)bit, bitmap);
+}
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flag_set(&flags, bits[i]);
+	return flags;
+}
+
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
+static __always_inline bool vma_flags_test_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_set = ACCESS_PRIVATE(&to_set, __vma_flags);
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	const unsigned long *bitmap_to_clear = ACCESS_PRIVATE(&to_clear, __vma_flags);
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline bool vma_flags_test_all_mask(vma_flags_t flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
+	const unsigned long *bitmap_to_test = ACCESS_PRIVATE(&to_test, __vma_flags);
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_test_all_flags_mask(struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(vma->flags, flags);
+}
+
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_desc_test_flags_mask(struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(desc->vma_flags, flags);
+}
+
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
@@ -1540,31 +1667,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
-#define ACCESS_PRIVATE(p, member) ((p)->member)
-
-#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
-
-static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
-{
-	unsigned int len = bitmap_size(nbits);
-
-	if (small_const_nbits(nbits))
-		*dst = 0;
-	else
-		memset(dst, 0, len);
-}
-
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
-/* Clears all bits in the VMA flags bitmap, non-atomically. */
-static inline void vma_flags_clear_all(vma_flags_t *flags)
-{
-	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
-}
-
 /*
  * Copy value to the first system word of VMA flags, non-atomically.
  *
-- 
2.52.0


