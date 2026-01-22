Return-Path: <linux-fsdevel+bounces-75093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULkRNSBRcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472A6A01E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9A7300AB36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725133859F9;
	Thu, 22 Jan 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RCk6xf7a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aW3cgQeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E9377548;
	Thu, 22 Jan 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098087; cv=fail; b=hkfr8wPaByC0VG1Un8p47CXzuFMA5+GW4ZAX97fECYt6hQJMlIDdIJsWV7eF3Nw+VuJ6O0GEVtwkKw3rz3F5/brvp0NX6goMjns3wLmbN1FhoRPxgKmGFRhH1u1l9gNEKUjDLmlpOZgK1CUe5nQbz9FyuTjGSZBj4LqkdHkCAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098087; c=relaxed/simple;
	bh=gKPCOpt0WGL543U3sntt65bDStnItLvcYAPZPwQ4Fy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DY5WnmzJ4EmWgIEqNSCxS9Qg9mKjvXRL2dUfsBlR5YoIXTE1vrLkUnvWqUXZtoOk3f+z3VM3U6C9QQqaC/b0f45fXYBvg1eOhSR8Rt6uQUB9PBZVUbyJXrKMn2TPTkfzX0fQ4jpPkTrFT5BOQctEVlx7OdS7PlgeZ7tJD01Wojg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RCk6xf7a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aW3cgQeq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgSsC248980;
	Thu, 22 Jan 2026 16:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YybXypc6SMw5xikumbVaSaazQ5JSmERR+r7jCDSzlmY=; b=
	RCk6xf7amECR+opVDtz4JW7vHyiWyrgo7eTWQT4UdhHDClzBhqyQKBxP86cnQL4q
	Z0qzmNIo7HaRt8i5hWhkIeFMRUJe1V3t7GgNCqlehfmHjoUMNkm/nPlDZgK7Z8Vq
	ohZJOvJF5bUeww4oLg2Kgcn61+lIkr7wB0YbXtYJ2c6ClB1xztat+VCDlYYkQE5R
	tmFKLkq6WdL3AlKeba42pDhWtVxoqjxVuxDDFVjEq9zYlF9oUvD4CRVLwgUzkniz
	iJhTeEfY1mM86m8IEMDERGCJ8bQcc2bbvj/6h+Jzoda2cGAsF7p8VYpHuMJAxWk1
	PmGksNU6JUxuxR+Gjod/Xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vyyyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MG4SL9022453;
	Thu, 22 Jan 2026 16:06:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgtxd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXhlBmBFvkp8hgVWlsyCGfRYG/JcXDp8mF+KWTZEtQO0XTqRT2Ah3lUD008iSjWeW9/4ih2m8xzFbQbUo1F2ToOwfDWZHgk5b6DVEhO69D4Aj0pAy2lHoRuL69xa2solTbG4NERCbqxqChIsOtJdz5foakQHN7BRbj31Js4davgVc4TCjEu0FOMBsSjs0vc0fm0tIttFt4F8EazbDg031lcStiQwGYG5JjpNqlW3HSp3rkTqGx0pR2+t8HLqV84BqikSFfJIghq67u9ZIKA8/9vNeo1JleMhjMJUL35w1lN2jisgxS3h3GKYkasQKJpStvRGMPAY/x/Q3NKP8HKsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YybXypc6SMw5xikumbVaSaazQ5JSmERR+r7jCDSzlmY=;
 b=JCba24MqcIvKlb2gJxElapirV7Do8MGSpCX10lbY9/AdHp6QpYrPo3jbxIVMsU+Y4qMDJ6/aVD+znFb67Esaq9dEnqusD0t4qV/qsOlpM6enMT/QK27d81AKAZtpxFP4m2/PmuEsRufBju90Evr63mLMzFkOcPcJZQHfZvEReJaZIkEX7uCF4BPdEgTelIrnKCE7s0yhLK00nnKRe1usNiZioAc1ZXl20WBkXk7UT/PTkK9bDJoFoDQRltrxRiZjsRhMjTC3ElavHkIUS3AyVExWan4/7dyJjpbvqd7gu5shtGUqZ6cAWLm0bu/rrmSmYalXSysGRZIyyssXmY7jZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YybXypc6SMw5xikumbVaSaazQ5JSmERR+r7jCDSzlmY=;
 b=aW3cgQeqfDhWxmy/lftApMwkzuh+SbqieOavTCNDt1lP3mSdrBA/Z7P2j1zovED15BVPa/fPx41HNBQ4o+EnBuzgf3In+xVkBO0ppqV60F1atZm9V3bduzqwAApSM6O8l55rkVlnEfJS91mVaDyl2eERFiSQKiAx/QM6CqdNElE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:06:29 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:29 +0000
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
Subject: [PATCH v2 03/13] mm: add mk_vma_flags() bitmap flag macro helper
Date: Thu, 22 Jan 2026 16:06:12 +0000
Message-ID: <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7d2701-5048-4570-10e5-08de59d033d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4vahpbsWmn3OYtb3VKj3dSI2rzo9q6T0DMPA6uI/W3jzQrjBbynZPt9F6rfO?=
 =?us-ascii?Q?YzKpklMSvMjxeO93ciKpeLwt8iu5jzwZ1GO+AtalYJWMyLAuY9nEMlGy4y+T?=
 =?us-ascii?Q?FtwL3Yn/UIzRvBT3gEPKqnK9ShWgISzpX5j3AuemtZfZwGtExG6D7/sC1BYO?=
 =?us-ascii?Q?0u2o8q9f6TnGDdVrp+Tp/AifCFfY4lMiLLTdByhcbBS79C0C6B7RZyw3MKA8?=
 =?us-ascii?Q?6wOskevwBxusmQf+O3a755DhUdfVvvjxRp8Nx3tQTxkdX2TbzToCGX91Jtyl?=
 =?us-ascii?Q?1E/DC4UK3fjYb7h1cD0ZNp0HW59guHjOEjrpIy8gaT8FBxr+Avt1kz7muzXI?=
 =?us-ascii?Q?gYz7UR1EA9709j94asio8EFzE/rM5JBObro04hbMr6Ubz6oFESyobLrnNYjy?=
 =?us-ascii?Q?mXBpy6ht8TfDcBnuUrJ1G4LM7RMm/6RbS4e2C44E02qSXBjMIKRC+O0e745d?=
 =?us-ascii?Q?r7yURccyfNdJ1F9vxqh6mys1iQxk4/hHM3zlhvxZyZaXH4wTp2NfjC64u6Re?=
 =?us-ascii?Q?cs4GO+5dJ/LPy4cT9mP/JIumJw8wmSrMnBzbs8RQWN87nwfhXWyezQABP4Dj?=
 =?us-ascii?Q?I16uIZqsVwXdmnlRheoJOIPdkaGjdHGfRhlvPGh+abi/aVNLPLSQm2MqLvO5?=
 =?us-ascii?Q?sqMsVXAd2fJDo0ELRQPwfXyi/z9ztcwyEfH0/xkWqsNOrPohcqYipGUoL3s2?=
 =?us-ascii?Q?AP4lA8BJOdZ5u1KOuo52HpxCPx8kzhSA+jfB2newyyC4k+afVOVZt9RMxECp?=
 =?us-ascii?Q?T+ECpEl0H9wH8pK8x0SMagIb0D/JqwwrY4PPkNJ7XaLsXjP53A64rUeR8e4k?=
 =?us-ascii?Q?D0LK1YxdEpb/zhvNCcloYYrO2726hM49bh1pPAJiTWBxGXJY4E56b4dUrGC+?=
 =?us-ascii?Q?EcALZIO/vAfCLSWptSq1cj8dr6EIrGy3OjCqjMdRhrXE9nmSKiXewfjVrYHo?=
 =?us-ascii?Q?kp4QmVuGP0GIuZnSMqS4FFT1EFo47kdQIW30Ww5jVJ1sH8lwuxoYDC02KU1F?=
 =?us-ascii?Q?vklCqjBLocGgK7vQOyWZf4qD+ES5vy36s59J8f0frj76/XnaYJBLJrTtiVr0?=
 =?us-ascii?Q?+7Lj/G9b7Z4y4DMYawkMY3mFX6I8fQF5I6DNmNcqwTWxISpKUPk/zzZNmczF?=
 =?us-ascii?Q?BpbYkZ7Ss2S3gBtnxA25U3DnJMLZFWJ6RZsDu73KPVMkTaFN3WKsEDUrht8P?=
 =?us-ascii?Q?c71lZ9HiUt/4EOpjI19VbeeLrpVVtnFet5EFQaUW9GFwdoPblwP8fwyTGwjb?=
 =?us-ascii?Q?6RsbnazloDR8N+r/Bbfkuw1vHe0p+F8Ue1wxDZH0C8juBclIUuhhB/xtZuBv?=
 =?us-ascii?Q?TEBQIy76am4nANxlRrTkEWmzzXTxDQL6q0wa7odibEtCXdk5e9icXvo7QGwn?=
 =?us-ascii?Q?EMNEGCMzZtS4kbbGzRuofxI+D0v3rR0BBB8iEuraCibo9eeoqLUtcuEZcNPp?=
 =?us-ascii?Q?2qfW93TEEFlMgic3487SeWlV9/yXXqKPM7YR6dRYtxx5hAhBGPgqfP8GQm9F?=
 =?us-ascii?Q?Lw9dnLqhvrqg2XnMWeFcpTgqC5nf/7zjM0oEpPcGdCM57f974sJCA27D2vJj?=
 =?us-ascii?Q?+1WMpruXlnZD0nc0cmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?taIIbedKTXQ7E3TJ6QM0uhq3eirz+wiybx4WneqNpAfIpHVOEtjQDrgYPkk3?=
 =?us-ascii?Q?krqoidn+KhcrCQBPrL7LlKs1gAqRjVqJ3qTKMJPG+DnwVmTBbUhUa9oO/BDe?=
 =?us-ascii?Q?oKu1QY9eIHE0ggKlWf8/R8KhTZmj/vO9NEAAtOPPvUiEUO+HSl6tsu+eYDvV?=
 =?us-ascii?Q?65jirNcYGr/x1VipD4BOVLYThI0U7SBnH1864QPBc0fQcDmyP6RI5MifhYXZ?=
 =?us-ascii?Q?15Un+xwFIH3cfmbPsBQ4bNG4oP0ESI8263n+lqDjOlfEwJ/08a3BjwyMlHJm?=
 =?us-ascii?Q?yaO9bG0jzLxR95QtDp/yk3UeJrZV2X3FRMqHQbJ9KPPuZOn/T7jEXZTx0Djq?=
 =?us-ascii?Q?+WshlorY+hcO+p+GrX3Da6dT8C/LnwCr7IgVT3hBMhhgHwGi/fHpMCvIX3Sj?=
 =?us-ascii?Q?MeQGcsdCXufuSOmxeDMOITIPyB7SpfGbFnL0pjn810/jmGMvNn9/wZccKPnx?=
 =?us-ascii?Q?z6Lr/12rUXPUSCO8YC3Ukcnh8POZZw/SnPkdThER8I7E0FJVCg5NX/c/KyBh?=
 =?us-ascii?Q?AjhoX5mq3LTIR589Q4ddAWteesmAz05Sn1uWp/XRziCzM7BinaHPoTATJ+qM?=
 =?us-ascii?Q?6CMSkYNnO0GrBPxBlhIHkmLBF+TQzsdLNTegrk41K2yBizPiyhtmtzmBnsUP?=
 =?us-ascii?Q?pXsJMVbsgN7kNWF64CTeCyPjTpnDHrSFiPQp7M0UNkZlShPgMPL9tKgIlcvh?=
 =?us-ascii?Q?bXWzRPNdmwfQEro9IcYVaaG1fn4IXT0AL3QcY2opgDN/8DRnFdPKJAswGsTe?=
 =?us-ascii?Q?62GZDH5Vha1Ria5K+fyTIQvR6FELWkD6LNa09tHqbs0UAoZ7WeZ9OZKibnkO?=
 =?us-ascii?Q?36w86SJlAMqHp+bQ4x+1hV93ziF6ORnXcb/3nCiguFRS6RgSWyPm/DflOHq0?=
 =?us-ascii?Q?EPs4G2QeZg9bgruKywhtphrSs7voZMymOLCLKs532rABFkTnc4K8lCmn/vaw?=
 =?us-ascii?Q?wfAJStnNtDZNu3K5HISjz1Xa6NNDkN6qEz+Dt5b3dfMk26bkQSERhu266sdh?=
 =?us-ascii?Q?pCozECi3GsegHfUlchqfyUfg0DrpzMaOijvvxWtXoZ786aKQfG2r01erxWt/?=
 =?us-ascii?Q?+FcxbT1pvEYKs2QppCsZCH073lpfR6MiZ0KKKCw+f/uezdPNE87HZavf/+Ul?=
 =?us-ascii?Q?3ZScwnbfFlwVSLh90F4O+Ot1v+zCPCEbBMhyAftD27q/ts57ZXa2S/ZvVcTF?=
 =?us-ascii?Q?z39RARKOEmCtC8+pWms1x5Q2sfMNTRfzg4hT92x5nh5jxTsvCeGwpKZmL2k9?=
 =?us-ascii?Q?+UViGHD1HU145NKm64f7rJcer0eQ2lESu98gM4q8kB0+Rkms03wZzfbK3xdM?=
 =?us-ascii?Q?eKjwQ6l3UIfbSl1B4SNwzhmgAA4z2n1X/wLKxTQAAKZqmkYCM1a2r59aBgFl?=
 =?us-ascii?Q?DZ7ciQ9SnFxXRUYP0k6VM4K0tim6DrKHvsprw3N9+9UENhyYqRyk+U5qz6uh?=
 =?us-ascii?Q?+ei8SY0SUoInATr/ItdI57IRtW4IcCq2B7JqqZkR9lt8JozOUIjQ8UfHCSFu?=
 =?us-ascii?Q?B8aB+Cv1EG2WbbWz1lKNaqXGwpxwkcjaqmPX01cwhWTNu178PJcIEa1ktUuW?=
 =?us-ascii?Q?zzrvKDzkiyJP+rqnVxb18KQSlmNHKx7tp6ps7xf17E1/EzWjqAaGPczrfFWe?=
 =?us-ascii?Q?vay5uG05UtrDFyq4HUMFu0nJjv9ZU+H23sh+kxBCk0DOjnURpP47bnD9zSr7?=
 =?us-ascii?Q?r+udYl6k+82LkJZVWznitGG/IKKVhGxNdt9tBbudZJfErIHeK7pzeNwbHJzU?=
 =?us-ascii?Q?bKABgqctoFdo/7C8fYC7Xp167v+omtM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RjHjIYQreq56uRRTXl7xHXGBQ9bWfQOmGGG6XpFxG759iB/M2s9RulM6bbTu/u1KTLZwOzo1ofnZS2ULRsG/cL/5TszAW1+x6Zwjixg3cxt2MoDxkPWvEnbL2G/Y2sL0riOkEDVIg/ufdxqXAtTivOTDSSoTlJVtJTZluloVDNlwsoV6JlbzyeDabqTJgt4if41H4y8G2xr3HhVKA33tbc8X2cd9SU/R3XPV/D9iN3g/9zSLoNA1kgTCkFfP9w6elutEDRKPtOe5kRoYSSP+WLo6DHtNkOQPsHuB0jbS9GkumwXC4EvV1OQZCaCHcpP1yAjlDV4PF653NdoljkwE++Uhcs7cSGBrbpuh2ouMvRCe3eC0+E20wlpu1Rou7RabfasNMiNCbZMIEPIOrAhyvLHB+9MBPQltwclg2Ql5H5ZvTHWY9DjIpyAHprfWPBa5f8jkG/MJTnK/QXtwuVFMRFjjybDgbztxbhdkutdTUo5stbJLAZvtByMBrq89jV6WPEPV/FqaBLNLg8YU9vAeA9V/G7eiaIoW2jcy6rS1AKl3B1Eh2qsAi6EtK9yo5U6CC1SidQQhf4nixDXB0OFd10oRxyniMC5eHT8rg+CcT6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7d2701-5048-4570-10e5-08de59d033d5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:29.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q74iPyZxLkh8f/HO/PqRnbflExerVnKliEVKJwE/YLNou+Boa2cOm+LfAxO0EcqArtoU10j1LrVm6MdLCbrJeP4kuW6Ht2Fg1+4OxgITwbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69724b0c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=X9FSn9lvzeJUOF9phsgA:9 cc=ntf awl=host:12103
X-Proofpoint-GUID: YCTS1fIez4CmEJtTmaKg99lqCGMtGzg7
X-Proofpoint-ORIG-GUID: YCTS1fIez4CmEJtTmaKg99lqCGMtGzg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX0FHve4S0sJjX
 3so5mqMxAVVmgDkRBcmFL5s6KI03SXCKpaOVpa9/z2ueMtOS2BOG6qAQ4ptAjUcy6zi3RoGvvKH
 Q5pbI6zcYGIsVin6R30oBe/f3rker9/gc0gz2jgAFtEH64vp2bqQQv00wvVwm0i6WlwDeOBGSky
 QISi/ZqpvK9N3NPA+26k0X9WmhUqr5jpLUfrtjc6osW0oU+DNA9lw3xgqjPjLIMpSzQVwHDpnZ7
 1KWqP7qYfKprdz5Pdw5+T+dYpUYKvD637KJkuCTIO3NLMC6rfxTVjMtG1krxPBS/DzS+Afi+LIj
 5KBVe5ZY69jqRizauOclbr15jNol9Wr+6WWORVIARKfsma5O0f+dawkVYqO7Y8raKAMGgAu78l2
 0DJ6aIk6ixjN9KU7kKSEf6QZu98yx8kCin9kqc/8bJNN/IBajGcEJkBSnRVeaCCH+mTSP5eGJ5o
 1GiujUG/WJvuKA2/DA02B4omR0c2JnaYSceoqTfY=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75093-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7472A6A01E
X-Rspamd-Action: no action

This patch introduces the mk_vma_flags() macro helper to allow easy
manipulation of VMA flags utilising the new bitmap representation
implemented of VMA flags defined by the vma_flags_t type.

It is a variadic macro which provides a bitwise-or'd representation of all
of each individual VMA flag specified.

Note that, while we maintain VM_xxx flags for backwards compatibility until
the conversion is complete, we define VMA flags of type vma_flag_t using
VMA_xxx_BIT to avoid confusing the two.

This helper macro therefore can be used thusly:

vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);

We allow for up to 5 flags to specified at a time which should accommodate
all current kernel uses of combined VMA flags.

Testing has demonstrated that the compiler optimises this code such that it
generates the same assembly utilising this macro as it does if the flags
were specified manually, for instance:

vma_flags_t get_flags(void)
{
	return mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
}

Generates the same code as:

vma_flags_t get_flags(void)
{
	vma_flags_t flags;

	vma_flags_clear_all(&flags);
	vma_flag_set(&flags, VMA_READ_BIT);
	vma_flag_set(&flags, VMA_WRITE_BIT);
	vma_flag_set(&flags, VMA_EXEC_BIT);

	return flags;
}

And:

vma_flags_t get_flags(void)
{
	vma_flags_t flags;
	unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);

	*bitmap = 1UL << (__force int)VMA_READ_BIT;
	*bitmap |= 1UL << (__force int)VMA_WRITE_BIT;
	*bitmap |= 1UL << (__force int)VMA_EXEC_BIT;

	return flags;
}

That is:

get_flags:
        movl    $7, %eax
        ret

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e0d31238097c..32c3b5347dc6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/args.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1026,6 +1027,38 @@ static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t b
 	return false;
 }
 
+/* Set an individual VMA flag in flags, non-atomically. */
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = flags->__vma_flags;
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
+/*
+ * Helper macro which bitwise-or combines the specified input flags into a
+ * vma_flags_t bitmap value. E.g.:
+ *
+ * vma_flags_t flags = mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,
+ * 		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+ *
+ * The compiler cleverly optimises away all of the work and this ends up being
+ * equivalent to aggregating the values manually.
+ */
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
-- 
2.52.0


