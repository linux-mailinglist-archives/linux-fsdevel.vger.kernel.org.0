Return-Path: <linux-fsdevel+bounces-75092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHhRERxYcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:02:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A39086AA16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E3413126A13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8A5388857;
	Thu, 22 Jan 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHLzjKl8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oL6nUdpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177C480955;
	Thu, 22 Jan 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098087; cv=fail; b=URBH+8+kNSITvL3+afDHKEpbqgy54pKyv412hxuOaFT1qHT3rxISFhrjjPa2aH3JJrz64pe8FI807iFNDb1Pl8rPkWZvCSrOW1AkN5pDYByGcdyxCK5nrKt0y+LxgGgDZx4/vFUc901FCJ9S57xm55Q+xmexyOgdjn7/gp0tvFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098087; c=relaxed/simple;
	bh=MiawciDRdG0EMixQoIDseSRoBIgc4+D/sCCIMcvmBM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYo50DDwijfiw7qBUre2+oQDz6/9KkqePDNnKRyQ5L0gNposBu3XxXMrVxhxwGOb7sNj+vGJDoSB5NOtbrB6GvNT6Ht1A8ZAXao33C8W9mecgEPaUIaNW7NPi8JQoOxA3LpNg6hYY4i6NeS+NxXdYV0fHvj02eMbH7EsOl23B+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHLzjKl8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oL6nUdpG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgTmV596256;
	Thu, 22 Jan 2026 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ODJ7uyu+fp2u0R8OQXqHQj+doayFbYClNQnHGkpqfzw=; b=
	RHLzjKl8MeU7n7QjRv0F83XWHxe1kpkl4AEQsW4djHHFHK8Qll8jB1GEGIAFw/ZN
	GpKsFDYpjZbPVYOPf7jtrTEFxhGUo/iQTlHneyws935jl2GWcjZlfaKGecCSDkED
	TyDKvniqvRfViOHeU8WQsNit21mRm2YkTKVRDMPEWRuxbIji/ZHoEDR6CvjD8NcU
	7nnzO2qK/5dX1Y4ckPKFjbA6v1d/oXrozKbLxKKjaA1j1TOBn+0mi23N5oVIZzi+
	JSV09gH7tRJFuoy6OaPorgfl0IfkCMG2oDLiKUF9MlsXcLN11WM6/lCStokiSUcj
	GSn8Yj4TnW9cpc68PfuCzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5qwek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MG4SLD022453;
	Thu, 22 Jan 2026 16:06:40 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgtxd2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG1CimsIhs/rldyVOSqfOEPWM4NnbtK6OxaIQmC+rCTvEAgvSZOGh9/QfkmDpBeqhPZOwbf/2KcJNoW7cH2mBblcHHbxJqznSvEPwAai5X77sbK2iHSxzhas7hRNKHkFaepsOaeCdlZTj3bLQMDzgWxKyeUjJROm0ePSZrOKxfVUrhQfHG6cOcDwzPTZzNiBRPnQ2lpaTs9J9aFvlFdqiE9FqijrEd/bXJBTU1BlIPRxguFVRbh8pN3vqcmVaIeH8l3OZ3UGj+JoVmPo/h20MC5AdJaWyvPDhSLiVdpivF0ZuIb+oKihFARPlv1719IcX5z7xn6/HVZS3RfPiP2Cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODJ7uyu+fp2u0R8OQXqHQj+doayFbYClNQnHGkpqfzw=;
 b=kn2K38Iim8wMkSfj49nABU6CGsfp/e4w3ADWsygLcnIPh70ykSmWvDnWMpNntsDrDIWu3JweSP3faBl5LXan3TD0i0S3oHB1ZyvwxAxAv1PeRQW6BuT6xumU7wtDen/Fy/6NkEHuf/yqQmeQt/RvOg9BjFVCI59stET0vuS3Jzmy5l8Qd6xy2u+8EBYb1CmioJZ/7AKYB20KcQEjflzdCc82AikUEibLEBMZl1Jnn504Xt6us+FTyxxQteCUIyFrNuan9F4FE5Y8knW7UB8zYQ/BDeBOJEFEkqde+CEAIW2hPSXQn5ng7NKoJvAHjpZA5CdLIWNYzL89eM9On4kZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODJ7uyu+fp2u0R8OQXqHQj+doayFbYClNQnHGkpqfzw=;
 b=oL6nUdpGpjWfGKcz9fJycLbQCnXZWU+sfKRsmWc51E3IxY2Kv/i7/1UKSE29uXcfWb8fX1FNvRseLqT4ykYe9J+tRj0dgQMBMgtpLwyWBEIXi1k83F8TFwFphEONbUJkCq0T8DsaIiF2t8NpRt5QE3qrnwt4smajsC4vZqWLVgo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:06:35 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:35 +0000
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
Subject: [PATCH v2 06/13] mm: update hugetlbfs to use VMA flags on mmap_prepare
Date: Thu, 22 Jan 2026 16:06:15 +0000
Message-ID: <9226bec80c9aa3447cc2b83354f733841dba8a50.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: 74958eab-0db2-495d-e37c-08de59d03775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pNBvCVa1l/ESogaO1a/0aldRBt296hRn4hJPaY05PCFvo20kkTVxgHVs1ac6?=
 =?us-ascii?Q?oPvUqH8sGi8c6HBj2jeJj7ZUVRKXlW7lBv9hFmkw5ovXqjEm6pFnaXDq2Y7y?=
 =?us-ascii?Q?+vBGOvzuMYZ083fLWTqs7iNhhbHJQlYUmyCdRYAViyuksyf0c1eBL5e83bWN?=
 =?us-ascii?Q?zTYs9BCDNt59LgpvO2/L55IjZpytIH11LjqN0x4Zd1KJQZl8a7nYcQuT0dCo?=
 =?us-ascii?Q?cRjcfxNQnZJdNPc7LS8ILiOPVTHjYpgEn9STC6CqpLBg4xTRmHQAQ4YA3R3p?=
 =?us-ascii?Q?7qlGK5+bp5zsGtB2MNeBULMqVomg/zYiCo7KFXqzZKjBUWXWmVjH8d/WFqjg?=
 =?us-ascii?Q?cwDqJG2hB30NleR//x0IsCuEet2Uy1sUgw8uaAfEtbnH+xqN22NDbatjJvBA?=
 =?us-ascii?Q?pDSYVJ5k5i3IjFlrDgj07up1WH4m/LXNbh1Ar0i5tfFN98RD/56cOtTubxJr?=
 =?us-ascii?Q?AqAh4EPNKl344jRsSqqQpif0v6tnKgPJQoeXTZHer9tsQg1juuLJ2D89oaU9?=
 =?us-ascii?Q?0aI/LDBy7DCMwcZ9XAyyaBiAUGogJ1blbHs0XvVCI4PCANDmXzS/m7rr4iqV?=
 =?us-ascii?Q?gWGMtJKJ8XLDoJLg/2d4pBQ+rQQzdFT0d7Q+3N4X1MDf/9b80MNtd+Ovqd8U?=
 =?us-ascii?Q?tJZaDshzoCQyW/GCyy+EsWMs9P7xbrph2D4jTJBOedDyTkLnWfCR48m3PR6J?=
 =?us-ascii?Q?ygAX1p8efi5HcICWYpaEGkMNJsOoJJLRNchRDGSfP7vzskC8OID2eO9gI4Tl?=
 =?us-ascii?Q?Le/ifSKL+/CaKRl2LBJFaNT1joeXY87yMNPgYU90xgUxZvMiHkLL8Bx/gUz1?=
 =?us-ascii?Q?TzbwCatP4JOdrH5K7kWtYBZpX96hzn1sRN1+Rny5zW+42MWh0sFsF8cDCz/l?=
 =?us-ascii?Q?WvvwvD/dR2gFva2YNe8v9Fg916ZO4O0s0KTpDjIKalNKlEDiZbYw72Wiu0GQ?=
 =?us-ascii?Q?9z98PBEboLWMXAsUomMxjdRsNYypnJz9Y3mxMqlMVl5lL6dI2SK1M7fQL/AF?=
 =?us-ascii?Q?8OtG+s0h3ZH4Q4slZ3EZq8bAAaYU7C91RaTsrjV4+sdsvB1qaeBVXIhj7Sva?=
 =?us-ascii?Q?jxB5in/xUV50W+0HeRbXXcmWNC7LZTC9r0KWGeq55cZlN5CJS7mg3IjgoOwH?=
 =?us-ascii?Q?U6oJGHrvJiuegnpoWYfULTYUHHtzsG6LbZvhJ0+kw4426jdGe99csdPeKO57?=
 =?us-ascii?Q?NSNvfLXO8HQ/9RcRjadxwThWnCDm33I7kTqwr2ocfGyj3NohJsJIs02b+wkP?=
 =?us-ascii?Q?E/eiHMNniZfr/30p65pTqEzbtzeW9ZqZqMIB5osj8g4G9kxztdnO0xl79awY?=
 =?us-ascii?Q?DJpf4kwXns6dO0+ABfux//1I6H357xTKlVoTHX8+lEFcovG8oSyXiETJZFwN?=
 =?us-ascii?Q?VDh03xviacU0emEIXAqjhtKNtepA/ArFF6VMfDQ6+gSQhteY/lvsTB5KaS5A?=
 =?us-ascii?Q?ruUBGwzVUkuElEZq9N366haHiMwRJZQ/uZ1t4YwJ/vjxSAkVlmD1/fKmQiPR?=
 =?us-ascii?Q?fL+jlka03QtwsQU5ATdk50uFQPz7FNRReUCl8ODZ9rgfEik71KZko7mypJdq?=
 =?us-ascii?Q?qG15pZa5mStP6iwnX8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJxhAZm/B0Zt46/U/sFhilRJ0FKf+BmKaSnp1XsgzdazT7iaxOMxdzvKI98e?=
 =?us-ascii?Q?lHJ5S1BPN4q7QXlRfP3mtgwyc6t3EzM3uvT8o5GPYusstnT+VNTiHGhpUUNl?=
 =?us-ascii?Q?zHLbbaY6LU4NWp+8xTC7ZIqeZPxk7x4/00jaKvPgNpcU59dSXCT3oqIU/YBb?=
 =?us-ascii?Q?xtZVPW9tZBs7Bp4+kZWEl2HxrzPGthN5F/BeG67LYvACJnDVXAwyZW990+r0?=
 =?us-ascii?Q?WY1Gtmd84oKZ+K2EQUV8FggM05VTVRnU4AOqb5OHf72UUSYwJUJB9La7EUra?=
 =?us-ascii?Q?SVoPABxkxW4U2ASPzA+9djasOthC8vUJSfWEjWltxsq3oeU6QViipewvaKn8?=
 =?us-ascii?Q?r/yIqrw0GJRxNcBCr7jApGy1b15OmV51+8RdUZi69IZf3ky42wpogy8xf7+N?=
 =?us-ascii?Q?++vPUkTHM5YxS/GqP3Fu+/2TUi+WjVmIHE3MIKTQyQsfDNFr8BgdT4R3V57Z?=
 =?us-ascii?Q?u2xWZPPG+OELmpRSfqG3BkPS59FVE9V8CJyQXMArg9LaYAXC4od1VI842Ea2?=
 =?us-ascii?Q?TJ4d5mtrjQgK3RYCSRyOnaRsjzu/KhURy2LIN7xWbuEdeTsqujcz0Al9pUMh?=
 =?us-ascii?Q?7VDIWhyM2zwSuDp8CMFUd3Id0dSC7cWKoF7DHk1CnRsv6s9T0M1I33o4QuDb?=
 =?us-ascii?Q?v81SSx4sTqF7DyDAFhCVjQ7Rh8CHVnJU9TeiN5FAPY6R4HVkQy/KNSOmQDR2?=
 =?us-ascii?Q?Mb3xYU+TXw6nRzX2tDl2DV/hkVetrUMTmygBZI09Am3jJupx6jVvQd3XkMsX?=
 =?us-ascii?Q?68phcGi2VvzhI1Y2xwu7w7yikMQGp9Kr6lPxgK7qfx1uRpPpvPF9+F8dJN8P?=
 =?us-ascii?Q?jlinyQMGdGE2EowVDIaCW3DFFLe83A2N+1jcw06uq1IX0HSV4l4AiPQC/RTD?=
 =?us-ascii?Q?GxcI3zL91t9erv2Dz9CLd+RBu2DJpQGVl+ZKdEDX6RmryL38ZsM4vdFRFdi7?=
 =?us-ascii?Q?b8bftZoyvaPaBNcpuVvd96xNI8mQ7cx/gWwkX9MbMo5YL/cligDJuHUij/VT?=
 =?us-ascii?Q?M/4ubT0WsVjuG5kohGfGqxIxiLQwcBLSjtQceJEQ8IXe6ZcdiLPvzE2haZ5H?=
 =?us-ascii?Q?eMCc6wNtf7K96aApepA9gWw2GA7MCejARcEr8/xB6btN55VcuzYrWOadNWTB?=
 =?us-ascii?Q?UU/KiitJOV2TVVMi3sQAw9ce1Sl9hd2d3pSZGMe3XaVjx/xfQaeY2rPRz+Dh?=
 =?us-ascii?Q?GxF1KMFRMTl0kiEoy+4XI9Pn1nyNRVbb8fweyuK/AedmxNMSIRbED6k/blDs?=
 =?us-ascii?Q?k5A3RS4JOTOHjelCqSqwLzIVsPO5KiVbtiF1VEsHZyjDZNBdezffsRigFO6x?=
 =?us-ascii?Q?wvgGqs9P9juTLvYRzLdotn16v2+A+R6vDgjZNz91znXvTmzVSYnXQYZGt4Zc?=
 =?us-ascii?Q?ExBuXW5R+lKP/56Vo5rMEk6xhfr24fSqRGUewHoMqsE5jXw6gsr5pq0OQeQr?=
 =?us-ascii?Q?/sRSgH+/uyRhl/hkx61QhwpUkEq1QIHIcLTD1bul9I6laqTv0rSWFPtWbUNI?=
 =?us-ascii?Q?DGR6PoOaN/UK/qYius2gKzGNfCb1hXpvr9pIHeZEQ/yhEAbAazO6S7R4XqSQ?=
 =?us-ascii?Q?vwcQaTRRfckhIcOBd9+gnptB3uZrlqJRv1kIQsS62f4fk0Ue4mG0jP4nuwOO?=
 =?us-ascii?Q?ziR89H1zcirK12uSTNTtyrgPmWBDLpbryyxnmy4iFqq4QaEJ/JiMAqqppmNi?=
 =?us-ascii?Q?82Lrcxzwx1W3Rqrr2xV/ckXPK/V86QmpSL66DhBcuRyWlKCiR8gAyL3xJOXF?=
 =?us-ascii?Q?CeTKqt3QqqXnoz8EJDvktAJOBoiTR4A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UwwXPazoG8QIaN0Jv9tBoIaKZ8+Rt69mgEq7mwbXGcvq6l80oRKmmV0G/UHRA564wHyuf4DFg+lNXSGOU68qxqADdbl2B2L4is497w97cihKf/n7v8M8YoUuNK4ZvDdBn+wxEE7Ppr90eWoSlp02biARrSllOkhcEoDF5sZc7jbtVM5otH+FcbNISrdTbsCiDyKuL9tW9hUh34VRquZ1i7/4ox/q+exIpEJg8x5Sq8xgt031gTbbdhisFLNvWVFGUZjZ39rr6fNngDWKXfNgporC5Dc/KM/9affczdQKFMa8NZvtofbYhgmx4SvBLXl4rBGIxxegsw31kvcZs0DiZbjXmr0gezGAR20lhjDbwiM4buu31i0viO0otPvNj2usL40sqXAsKAdjPfY6cQxrVkmqoQRl7gw6Pxhzo5GASJBpfh08lwQGlFxTK7nZkHfNMHx0ZY2XlcAUxnc0RBQRXGoIWerj0XnU/RXHSoU4MtOgKAlVqSl5OkEYrzvfu3YQ+6ixqd8SgBNu1LC061NXWg1I9JoEKu8JVajOAXd/L/Na0f5dIFxc2wnFapQORIQMTUWxNFGGWXDdbPqvM+tIH2kgmdU/8q8OHiH2pNY2Rd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74958eab-0db2-495d-e37c-08de59d03775
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:35.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9drOgZq3DQHGNqIXzGi3k8iGjMyZST1QTpoST3OpiEYsx0DFjfjPO1p9QTCC3ReAG/8PSh+nXahn2zFaA0QvYGQ7hJkYp6qaHHwyUB/cQiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfXykFzGw53Dlko
 VNky5cPsFr267LicVC6jyJI+5cB90ooUH/MTHAMtep/Dc0RS8jLotaUTTrkwFCXSKMPi4NvJYT0
 BqifVsKXsWpZsdaSwojA41A6ElluPqknlhxc67HxB+r3yLFEnDJYWeSFmKeGXnOdJgbTxXQ3oE/
 XZp20I+j9PZo/idIckNmrAC+gwiqnaUDthWW20zKi90I5wzHKJCOS5rv8/gxp1vr0+u35dn7lIw
 KmArqF077MbqsBVESM1HNuHMUndeeUKJPvPjtL5UPycb6EZLfsfbBGeuBIuNpWyStD548CNC7pq
 gFQHZsklDGHkEA79CWfzSUPSlSvwP3QqNahFY1jBczpnWGHONg39w/BjG/3JFN5Wo2RsC9cM2JK
 afw316I+4TwQaWdBxBwlzBMMtDd01RZkC/VMyoOiCOYGmepjPyx4aGGkm6OoVQ1YaWhxjEQ+cf3
 O+rACM+1bQnWRtvsoIiOegawMqIvGpWQ266NJs3I=
X-Proofpoint-GUID: WCOi2LxD8prYZ1ARnCVEo1m5lq5pvHzQ
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=69724b12 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=atHbPFec4puc5jveiVIA:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: WCOi2LxD8prYZ1ARnCVEo1m5lq5pvHzQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75092-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A39086AA16
X-Rspamd-Action: no action

In order to update all mmap_prepare users to utilising the new VMA flags
type vma_flags_t and associated helper functions, we start by updating
hugetlbfs which has a lot of additional logic that requires updating to
make this change.

This is laying the groundwork for eliminating the vm_flags_t from struct
vm_area_desc and using vma_flags_t only, which further lays the ground for
removing the deprecated vm_flags_t type altogether.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/hugetlbfs/inode.c           | 14 +++++++-------
 include/linux/hugetlb.h        |  6 +++---
 include/linux/hugetlb_inline.h | 10 ++++++++++
 ipc/shm.c                      | 12 +++++++-----
 mm/hugetlb.c                   | 22 +++++++++++-----------
 mm/memfd.c                     |  4 ++--
 mm/mmap.c                      |  2 +-
 7 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b4c152c5c73..95a5b23b4808 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -109,7 +109,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
-	vm_flags_t vm_flags;
+	vma_flags_t vma_flags;
 
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -119,7 +119,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &hugetlb_vm_ops;
 
 	/*
@@ -148,23 +148,23 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	ret = -ENOMEM;
 
-	vm_flags = desc->vm_flags;
+	vma_flags = desc->vma_flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
 	 * flag S_PRIVATE is set.
 	 */
 	if (inode->i_flags & S_PRIVATE)
-		vm_flags |= VM_NORESERVE;
+		vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);
 
 	if (hugetlb_reserve_pages(inode,
 			desc->pgoff >> huge_page_order(h),
 			len >> huge_page_shift(h), desc,
-			vm_flags) < 0)
+			vma_flags) < 0)
 		goto out;
 
 	ret = 0;
-	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
+	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
@@ -1527,7 +1527,7 @@ static int get_hstate_idx(int page_size_log)
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
  */
 struct file *hugetlb_file_setup(const char *name, size_t size,
-				vm_flags_t acctflag, int creat_flags,
+				vma_flags_t acctflag, int creat_flags,
 				int page_size_log)
 {
 	struct inode *inode;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 94a03591990c..4e72bf66077e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -150,7 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-			   struct vm_area_desc *desc, vm_flags_t vm_flags);
+			   struct vm_area_desc *desc, vma_flags_t vma_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -529,7 +529,7 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 }
 
 extern const struct vm_operations_struct hugetlb_vm_ops;
-struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
+struct file *hugetlb_file_setup(const char *name, size_t size, vma_flags_t acct,
 				int creat_flags, int page_size_log);
 
 static inline bool is_file_hugepages(const struct file *file)
@@ -545,7 +545,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 
 #define is_file_hugepages(file)			false
 static inline struct file *
-hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
+hugetlb_file_setup(const char *name, size_t size, vma_flags_t acctflag,
 		int creat_flags, int page_size_log)
 {
 	return ERR_PTR(-ENOSYS);
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index a27aa0162918..593f5d4e108b 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -11,6 +11,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return !!(vm_flags & VM_HUGETLB);
 }
 
+static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
+{
+	return vma_flags_test(flags, VMA_HUGETLB_BIT);
+}
+
 #else
 
 static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
@@ -18,6 +23,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return false;
 }
 
+static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
+{
+	return false;
+}
+
 #endif
 
 static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3db36773dd10..2c7379c4c647 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -707,9 +707,9 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	int error;
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	const bool has_no_reserve = shmflg & SHM_NORESERVE;
 	struct file *file;
 	char name[13];
-	vm_flags_t acctflag = 0;
 
 	if (size < SHMMIN || size > ns->shm_ctlmax)
 		return -EINVAL;
@@ -738,6 +738,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
+		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;
 
@@ -749,17 +750,18 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		hugesize = ALIGN(size, huge_page_size(hs));
 
 		/* hugetlb_file_setup applies strict accounting */
-		if (shmflg & SHM_NORESERVE)
-			acctflag = VM_NORESERVE;
+		if (has_no_reserve)
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
+		vm_flags_t acctflag = 0;
+
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
-		if  ((shmflg & SHM_NORESERVE) &&
-				sysctl_overcommit_memory != OVERCOMMIT_NEVER)
+		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
 			acctflag = VM_NORESERVE;
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f4494251f5c..e6955061d751 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1193,16 +1193,16 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 
 static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = map;
 }
 
 static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
@@ -1216,7 +1216,7 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 
 static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
 
 	return ((unsigned long)desc->private_data) & flag;
 }
@@ -6564,7 +6564,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 long hugetlb_reserve_pages(struct inode *inode,
 		long from, long to,
 		struct vm_area_desc *desc,
-		vm_flags_t vm_flags)
+		vma_flags_t vma_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
@@ -6585,7 +6585,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vm_flags & VM_NORESERVE)
+	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
 	/*
@@ -6594,7 +6594,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * to reserve the full area even if read-only as mprotect() may be
 	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6628,7 +6628,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;
 
-	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
+	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6665,7 +6665,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -6729,7 +6729,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || desc->vm_flags & VM_MAYSHARE)
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..5f95f639550c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -87,7 +87,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 		idx >>= huge_page_order(h);
 
-		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
+		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
 		if (nr_resv < 0)
 			return ERR_PTR(nr_resv);
 
@@ -464,7 +464,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 	int err = 0;
 
 	if (flags & MFD_HUGETLB) {
-		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
+		file = hugetlb_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT),
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
diff --git a/mm/mmap.c b/mm/mmap.c
index 8771b276d63d..038ff5f09df0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -594,7 +594,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		 * taken when vm_ops->mmap() is called
 		 */
 		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
-				VM_NORESERVE,
+				mk_vma_flags(VMA_NORESERVE_BIT),
 				HUGETLB_ANONHUGE_INODE,
 				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
 		if (IS_ERR(file))
-- 
2.52.0


