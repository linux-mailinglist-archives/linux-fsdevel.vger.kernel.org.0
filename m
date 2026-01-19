Return-Path: <linux-fsdevel+bounces-74447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B600D3AD64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0037310FB41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24238B7C9;
	Mon, 19 Jan 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YIB14lQN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G7E/ST/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B92389E14;
	Mon, 19 Jan 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834361; cv=fail; b=TyrdE80G6NMjfinIqBNGvVRbcUwxmetvxVM+nP9lKnWL54vG1IABf10SQwqT6Yie6dBGi34v6cOSG3XSJiRb2F+zWff1ttS4Cl2wDVghVyWneHuh3lKJgOyKdkTbeKAAEi+4PDWM8iWIBmanF8CgS5AlMdPanifOx1n1cnNX32E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834361; c=relaxed/simple;
	bh=PfjG83ic66b4jk2kFkM5inpD1efrGgZxVPOePBAf7+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHLhiukFUGA5XbP7u6Js6/EO2JuVp9YlmWWEDff2y5Qu5kjBnKogg8t3/rxgkvM1EqRutwjC9qU6VY/9zkD24pQy3+qYxJrlsBSlto+300H4gdWXlk1h6oaAyLQdWWwCK0waUkqVyJ5CStLxgM6TljGsLVi0S6eR7glj0eImvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YIB14lQN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G7E/ST/b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDPrP1429457;
	Mon, 19 Jan 2026 14:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BBXQMc4RBl04Qu8JMQmgjrnjmvhBSBUfejRsR2TByeE=; b=
	YIB14lQNT4K6oRIzwfzMSzquOvLpOgdn2fMFGONbIAvI70A5JBWJxESdh1lVqoIo
	8+cgKtG8VkfOFP7Pkbhznho++DdKOWgit3uyQGuRZ/E8nlV+tp8NBaYZL+bgAHzl
	Ph2Il/1SgQVPPP88bsXhvhj/zsdYezS8M117h2n0mUBVdi/ebfP5ODR7IhG/ShMh
	Vt53Up28U0m5qeJtkdUt3R/I1MyaCNYto68NrgMQoCnFG5utNsbtAx7/O6PXyJjc
	n2t5Smo/FxXJdRyJplYEJ7wezbJWsRg9J9e+BinNDiz08EKpNXlBMRaYHq/Dsgh2
	VdfW5oETC+7U+OwZUuj/yQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5jafs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JD0a8Z022493;
	Mon, 19 Jan 2026 14:51:47 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc7wef-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiRK/dGFO/FKEaxPc9LA/vNO2qe5zs6IL0uWtbQlwKjJAHnB1WnXHuHXigvXSXF1p6P8wApIJYemAo9whTki6UvUAz+tFLoP/Wvh2mNmSy9cp9MJM4A6+o8d/bClfkClcZCKe2mG7k0yRZgEpbG6zhgVWG3eUuM5XiEZq/vbn7NZcJkb7kpkAyVlgkwkPp8rpjA0HUIhdPvWJk37Hv0fY8L9w/DQyic1VTCchKx0dL9/92kdjlvlX0H9+taoPZAgVttjl6K0W7TKNptKANStYh2T8BwDWFcUrE4jCQMsELTs/x87ur+LMBUMeDEJsf1ngXSDqWUcuRMi1hm8Oz2MTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBXQMc4RBl04Qu8JMQmgjrnjmvhBSBUfejRsR2TByeE=;
 b=VcEsOp2TXfyk3LpOkZlcL1r8k9n4t9pOder42PtlYQLg+7nMb49TSUgvbVGd0eFqT6EdGnw7rutwRdQjYzy6M1GSp/RItFM+AUxobIgmSjNNxNZ+TyrblnrLNvRf6Tu/MDh9lYFkIKR2YEnaS59/bYvxwZv2srdkOnQ++VbRS1Ie1XWVDZ5w3ngc7tAdQ5fUw7iVwF8pRpahl+zPZd83mVbbAMKonDOWMuF4NUVE2eXg6PggnOt+DPmA882VA1UTFGWCORfL0ejWaaEluyw2La6mEmaQkK5NSJX6rBX7lzx6qdHOishloPHYssScDwEqn6GuxdRmHqSihtqgoyB/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBXQMc4RBl04Qu8JMQmgjrnjmvhBSBUfejRsR2TByeE=;
 b=G7E/ST/b+prRUVTQ/6v/3HAL9qLc6vvJWTSPWo7dDXuGC+xFpsH95FBffAP7Y+yabKoL3wuMfz5TsBZMTFrxhDbDYCH6s1qvJpj9+ynKWbAazkYY5IdWD5iOU67H+HulgV2xoQh3u4R9Y+grt0aV2oFGxutZbUFxiXJs+sJ3wtk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 14:51:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:40 +0000
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
Subject: [PATCH 06/12] mm: update secretmem to use VMA flags on mmap_prepare
Date: Mon, 19 Jan 2026 14:48:57 +0000
Message-ID: <669265753a1ec8d75a1a0893babfaf19a973a7b9.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ea8952-0160-4b8b-56e1-08de576a40b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bd8Kd2Kb46Hw+AeoviTthKqQ7Wv7KzQ3DOFv/XBVUkapHwT09r7SAChXyLi7?=
 =?us-ascii?Q?ikNcq38Bz7L1JaKMGsQ5X3+26vH3UKcGj+68+RoNl94ZEpbGGGk+6d4Ecj1U?=
 =?us-ascii?Q?4zq/pFLvtBxwyc6UbXAPf9109IKbsmiDoR5f57Vii45gXM//idAVZWDidZcB?=
 =?us-ascii?Q?8Bx7FX/HSjJGRT3ZjEJXLwd1416AepaP4F49FrGYMflbu7iPA6v7K70yr5RH?=
 =?us-ascii?Q?hln6ggspr64wawuCPmM1JooE6wSP682JtTUw4rdMDB0DhJEbt7PZZMROkAcC?=
 =?us-ascii?Q?cNfwdJ66r1IJKv6j5Y9w6FYPfeu/uppsO+DStSB/cLMkHpIT8l+Me4FHY9n1?=
 =?us-ascii?Q?RedFvmv22MB5AyKL6bDg1XVQFfV3HlZI8ZZ2bluWHsv1BZ/Op6Np5W0ruGqa?=
 =?us-ascii?Q?Qnhw4b9bxYuIDJSOwS0aQYcGr6Y2/hvKu/VI8iyRKNlhKxahTzoXZ3EzUUov?=
 =?us-ascii?Q?dg7Mix2UCvmVXgSYzvQwFv/yx9PkdjG4zcV8UIxcUibMb7z5jxlJFdwotb+u?=
 =?us-ascii?Q?6HWg+a7H0koASoWbmXZEnAMn+Ig2EUlHyGKEbTM+BYxq6D1Rd4Y2+0p1Sb8v?=
 =?us-ascii?Q?V+deYAE3jbfUWItIkRNvookUmn5pM4Kne+NYgxDAUs1Bh+61f7Mp58dyTmVO?=
 =?us-ascii?Q?N4K6ogdZepkma6M45zuc6Oe4F3n8+XKNpSOmC7f8QVgqKnlreYLf11yWF/6P?=
 =?us-ascii?Q?1tZO6gEXy5PTLuxctsW6mCsI2wMvq2CdzWJ2xMya/Z1l4ZMfq4zaZUOO7pJB?=
 =?us-ascii?Q?Eg3KMdF13tu7covwqPEBDY12Z9H9wPAEXWJApUOUR+A2u3ncaJ9a7B+X9cxz?=
 =?us-ascii?Q?61n1AoFYKV9P2XZStLeG0UQp6ZN+/3PuaUIaZlnpabRJwh67YG5GGREKd3T1?=
 =?us-ascii?Q?wYfFJAzn4Qu52i243xuqfH0KP9NXt/ur34Zdfty6KDvTX7oUWZ1bLoKPhkjS?=
 =?us-ascii?Q?9oZ6x3m1n1+cFdE+WHAYHLNua/BJS78hSNNXUGsjS7OsLacTr6AxqYRzMieW?=
 =?us-ascii?Q?PMrc/Um1vcRzGLC0AqQIQoccMa3XJ1XCqFEfWWl+tWir95Q2rlxnPhbpT9WO?=
 =?us-ascii?Q?PX0F6bRgpV9w7/TMY9m9dJQQwV8cdlXBu4acP5P+UidebAKzvbA49s6lKYhi?=
 =?us-ascii?Q?eFpUOXe7NbfwrLDt4PrkdbV7thGDzFvnr0PjtuXPE/korguMl54gOUGEGuFK?=
 =?us-ascii?Q?/sqaLAnx4vXo2IkgcFH9xXqthWYZvGFo2ziSShrCLPARKPmL3/9V4RzHKW9V?=
 =?us-ascii?Q?83m6NtYvKB9WnGtS0x6ndcmsifwc7Jc1Sgr6si0zG+4gu7iQcB6znO6ntsEh?=
 =?us-ascii?Q?DWQE5uyA9kr7hxOCtfmj0lDpAf+YliLsQguE6h3XOwR7UH3uRteK5xgrzpxK?=
 =?us-ascii?Q?l1Y3SiwKjch9dLak4GubQDEDLxMZOvwr13Fy6OoxU3b4g6UK6Gy2VgqXvKDi?=
 =?us-ascii?Q?0/zBlj/Kxaib1kIP1WjtJC0MvRiyR7B25c4p5NbbUqwoNN4AjHmc+3ZtVIbd?=
 =?us-ascii?Q?6pkl9ImPGRTV00amvEHlUChUPkDUuP149Mw1UZ78lrnFpLK7S8+7gdpGNfAj?=
 =?us-ascii?Q?fd61brwpzHTVP/wAgg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e0dx1AY+jFnL684M6iwtrICuaaIMbwt/SH7VnTMqCOn7hn7/SJ5s2WWnBP8x?=
 =?us-ascii?Q?T/POHS2t4/fWuf7EHW9n1iJRn5Z8njqr5/2p9OamUmcUGCHo2qWn+2IQ0Vac?=
 =?us-ascii?Q?dZeZUcOzJ1JVgJ+F8X4BVR/qMXAB9Ph/97ktG9iIvawCLv5Lf3vWwV/9xf9B?=
 =?us-ascii?Q?I9GBKqtyW8vE049Ms3PW/U2rQPXGYoXDkwF3qCCcS6OvIu6vCUW5yvh40Pp+?=
 =?us-ascii?Q?nSPyvtKmR1R9OKssqsagKXuG79Z+4CJuBeTpxbOMJ8FJLg136/IdfdUvTRzh?=
 =?us-ascii?Q?QQ3pcdlcKcdnh7SV1BOMiElfCAK8i33O722uk09Vs4W7uGC8ClkUQV2cSTbR?=
 =?us-ascii?Q?IdLVHEt/AoRbydE24JuYGH48BsMZtFpnyftpeotbujBO5XqIQJwgmujYUzl2?=
 =?us-ascii?Q?adJE1mXLR7vVcwOxYZWsddFQe4FjNRraFDO5evkt4vJZQakyzwW/FmkwPo4u?=
 =?us-ascii?Q?OibiVvsNvcpd32UwnydgzRJU/ShgKEI2oPWl/+jbndeGMzPGPx8dI32f/iqH?=
 =?us-ascii?Q?7v+DpIhjfa4Nmt42StGs7KpsFa9JuycAKK5scn1sZfzghT+Yl0XHT1hgsuNJ?=
 =?us-ascii?Q?Fvm8SO02eLpgVQ3MQHui1Lkf4xycZU/QLGwCA4l+wIiifidLg5aR/cifhvQW?=
 =?us-ascii?Q?nQnIBQRBjworTCRxbKEpxTnItpWyZAMmVd+AhOASJgFrtxeVkPpDZBenpN9E?=
 =?us-ascii?Q?tkotBpEdbGrEkyRPjvxA/Pic/7dzcltJUIcMW0d3RsY4HD5u73/2nSz8Oebe?=
 =?us-ascii?Q?kDlQPaBTA8Uk4kSOKMmlTYUS4pivPA4kdK9CwYpFHX6pWTxQJs4ZuRUnZmxr?=
 =?us-ascii?Q?vciwc4dChy9J0vwsKq23YXUn0QIEazPMVsWEx1dDBzEMlR4d/ejYuhr9PR42?=
 =?us-ascii?Q?RtxCKWyBU4BO3BwMu/Qot79MsK976ClXUFpomTm03J0Id9b9WWvoIw4xri3l?=
 =?us-ascii?Q?HMPop4e2VkYSA4kKoWOpLZv5UDCk5LL0LKajq1Bmbu4k3NBfZnQkFeas4tEn?=
 =?us-ascii?Q?xsmPi1oOdd8vpE8eZZ3ms5rc7xQRorXhfmdinaGdiSIo95NTNpftWe6UwfnC?=
 =?us-ascii?Q?6nRLzXdbuj0+4B/WFjgB3gFF2ReKUIb6bF3L7sxDyFjnynJBDvDk1osj3Y7W?=
 =?us-ascii?Q?6R41yn9JfDAeeeVLRknlk416xA/zsqH26vrHH2/nZxF96br6USpxk/UDVkzv?=
 =?us-ascii?Q?GR4myves9DRQQ3SKwTUIU7Ettjn2PjcSko/IvvcgSsYvrPTZzjdF5gWnBJTQ?=
 =?us-ascii?Q?TlflIuQrTWj4I0FRaNwbWgzJRguSqOfOvv9Ra18bo2wDuP9OhYdSPfK9ACBj?=
 =?us-ascii?Q?LNIa5GCAtauE/pFtcVwRVG7vY4flwcL/7bQLGxlhz2z/ylPgyyW6NX0rq5U5?=
 =?us-ascii?Q?YISt+UeJMThz7RuiKyh/CHaDRw+VJUKSkRhmsOFXjfLi7un6yG+pVxC5t2+w?=
 =?us-ascii?Q?fp0R8AZfrKMZ3doHugj9WJ4H9a5mJq5Dtfjr1nI1OmXOidAVURAXhURmSvFZ?=
 =?us-ascii?Q?gEPAy9aP31wXG0vc+OuJzPnVJlbtmQMMnTIaTCgbDWMPTOUBSUa7Mn/HIuai?=
 =?us-ascii?Q?6xVOai9AmyeDKUAtPi5U9IRLvbRNgHOV9DzFrGzqbOW9ShN1WKZBcq1b5p9m?=
 =?us-ascii?Q?GyJq/PFusEh/5/mrmWPMUZVsoGNWTASlt74zHU50JTQbOlRbJqpVw5AUcPv5?=
 =?us-ascii?Q?Yp+4HqoMKaa1unKh//OhDc+TeWc8b2amijwRmP/Ku6NIDmPeW7FRD4a02qD5?=
 =?us-ascii?Q?jD1HeY+duN9cKktVi+fPWtVYWpmluLI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zgjMp3Dwtp+kphAxpqXXj4yL7VLJW/+rS67GbaARn3AalCe0le964bA7ORCmbTc98R+YbY6XQ7sTKHZvAcs3CbPDjrADA+hHDPV8f9DpWy+/Uf8FmY9hGUztd0AJrrrEWeThuiOfC9ijWfrfPSW1DV6MJV9VevSAz748RlL69UwtWTibkdgDu4f8ZjXy2gNyQVll/Fe9Tm869lfgQ6dE5Vv11oLI4FTAUF9pBdTnRi9UchOEX+tjTJV3JlQuoIfqqWxBSqLS6o2+p74QqZu3G6bqWObnbsNm6RBAqG73O0MF+3Y5j8gNO+eFWUDSQ4ebC7TYLXAElhrgkw8w1I163N4ixx30wuZqwZ1f1iBmH3ob6rCHiQVYiwRP7WwmTH3jmxIfrRfcfTEGKOSp+6Q/ss2vv3PKGT8dHq8OZWzO+9nUL70OiNRd1iEj1ZYD6R5Jtmjz+iHGkCw+K5bAlX4VeVrwDt96+BsZr3bB0x18IzvawVbPAT2YoMuAd/zViWLLOaP0CR2/nBn2RwqgL68P2lh4oUWgzGrMc1eSqrvFk64W2HgcuM1ijK9cYD8gMyRjUBkwS9pv0K8D10LdWWjRMeOYCVmvLCuOSe20lyTRzJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ea8952-0160-4b8b-56e1-08de576a40b9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:40.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAv2CCJSFgjRBFIhGJafm9Tvc+irm9bU+jD5VBnP/1UvsHUeeMQb7KjA2oTB2budaY8bqw5nUUlCEPnxYZoKXSoLyEi8sVrlk/pf+QzIeFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX1A1qJPgwH2t8
 Hk5bYTRhxANxp4frgWW/iAo2SQwQO65z7WsmhxnHAGutvrLjJYDF9zhgieYTPqrNC3FOtIym7gS
 53qyiQgkNJIcB10GFNitz0MJSDHvDOeu8Ljn03xiIDx/xXeba6g/CUqvjhXjgSOA/sGHd7ViEm9
 I5k1GAONKMmukwJIb3ZunHAf8ii2ulfwMnMBm2uKgo/wEIZuusIL8MNHHNCCe/ERADoE1VJNPpX
 UkT9cb/aRyHqdKE+A33c4m3/0zuhDj/1cv1dZ+sa3xXSIccNrhfNpN8AtAoTcJLyuJVZrQwZ1hn
 g1VIdwbc0fnz3FvE0c6X4IJgSsiJSmKElhTypAuKVgKjFrjsLV2TFyhtSezqfh+c7HVxKbBRzQ6
 dBPXA1mamzB/nIkohdGSieuc28C1T6tPUry/xkoGc/xSPb1dGIgixZagvzGUt+6b6pVLUkaLBm3
 jFayo17GMl4u+5fhLTLwRghg46qeU2jPtKlzcDRE=
X-Proofpoint-GUID: vx-bnnTTyHka_Ifvw0ko9oJGkJo8ymLR
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696e4505 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1EN7IFrRoGoyj_JuQOoA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: vx-bnnTTyHka_Ifvw0ko9oJGkJo8ymLR

This patch updates secretmem to use the new vma_flags_t type which will
soon supersede vm_flags_t altogether.

In order to make this change we also have to update mlock_future_ok(), we
replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
which also simplifies the invocation here.

This is laying the groundwork for eliminating the vm_flags_t in
vm_area_desc and more broadly throughout the kernel.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h  | 2 +-
 mm/mmap.c      | 8 ++++----
 mm/mremap.c    | 2 +-
 mm/secretmem.c | 7 +++----
 mm/vma.c       | 2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 27509a909915..da78f187412c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1044,7 +1044,7 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
 		unsigned long bytes);
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 35d11f08005d..d7a5b44fd6e0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
-			unsigned long bytes)
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
+		     unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
 
-	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+	if (!is_vma_locked || capable(CAP_IPC_LOCK))
 		return true;
 
 	locked_pages = bytes >> PAGE_SHIFT;
@@ -416,7 +416,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!can_do_mlock())
 			return -EPERM;
 
-	if (!mlock_future_ok(mm, vm_flags, len))
+	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
 		return -EAGAIN;
 
 	if (file) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 8391ae17de64..2be876a70cc0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1740,7 +1740,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
 
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, vrm->delta))
 		return -EAGAIN;
 
 	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
diff --git a/mm/secretmem.c b/mm/secretmem.c
index edf111e0a1bb..11a779c812a7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -122,13 +122,12 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
 	const unsigned long len = vma_desc_size(desc);
 
-	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
 		return -EINVAL;
 
-	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
+	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
+	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
 		return -EAGAIN;
-
-	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
 	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
diff --git a/mm/vma.c b/mm/vma.c
index 3dbe414eff89..8f1ea5c66cb9 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3049,7 +3049,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* mlock limit tests */
-	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, grow << PAGE_SHIFT))
 		return -ENOMEM;
 
 	/* Check to ensure the stack will not grow into a hugetlb-only region */
-- 
2.52.0


