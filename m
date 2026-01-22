Return-Path: <linux-fsdevel+bounces-75097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCa5AIpRcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:34:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA46A0A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5598B3048114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66B39DB2C;
	Thu, 22 Jan 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MAFxvZzj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qEi1Vn3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC23994CC;
	Thu, 22 Jan 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098115; cv=fail; b=ntCPvEtNke9+dCEwcPtjtQmeHxttVKcJV8/emdNoAmkFIDdA/tQb0hzaNcxqwcefG0ZbxLyhky2W1NLUP5QptPgJ1GEMqU7tV5JijCHnhzpNScA9X3ePKKHLoB3Hl1K6mYj9P8Jcm2ivBD8y0fCqGFQONoqzxOaIPUUgetCdQSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098115; c=relaxed/simple;
	bh=6aTVgIQ3W9A95nKU25jcHQLC5+8igvj+8l07NBAV8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpGS23nSxuaJqrjx+xGe49JsUevBvXL+1oFvEXn32lBUMya+B1LGjfqPi2jVhzCX1KWbn9w94cM5bXiNjrrlAd9TR/tLDECtbr62GFFJoNSOhar1ZhdgJDlRyU8GyN0DzyjQkWWL7Y4pALLDYCpsxGHpEx5vjgGngvlVzuH4Svs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MAFxvZzj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qEi1Vn3j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgN2G248898;
	Thu, 22 Jan 2026 16:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ljjDuu/4OYG090RbFla0qGxk0g386zowPTlGmvncFM4=; b=
	MAFxvZzj6a5XphC0aro734+3yDbU03tbOrKUV5RtXlrP5DNEBWR9PK8tKbJLdrcD
	UjvD5c63Sv+VJjYVOMWXOzylID1fo3cNE2f4p1R4iydU8z+TZL4bWnjqwrhN7DIb
	S96QIJDdbgxHCxsLa0y9FxNhgswoyT7qR4rVJkVSEiKgKOpd7li4pSmvHcm0ytGB
	q8xnaBkR+yoJrORgGrx3WE7WYVXbZ8+csbQa044Bcg3BPjuYjLX/wKuBTn+CTGkQ
	RMJfh+L6AAphtTphfBJLCSvXWS/ltCojhh25MYEYdmsFSvDm9N51qw6yK/dRyTJ1
	zYQTszEfg6CJB2jkXlqr/g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w000n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCP032257;
	Thu, 22 Jan 2026 16:06:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ1non/jRA7Ca9BmqlyXCmbaOrry0Y82omywy11bpIhdrMIPCt0ybPNVJOH+PIcppy2kGf3LAdhPKDX5HmkGZBjLKrA5r077mGdXujKMXK6MkQK9DJoXtpodEn4iZVRQVPT6kEZ27Vz8vxXHxyoC31I61+5m/vIV8G6x+hPbfqklqc5uj+IL2g1iiKxfCvUAahgsoZxoN9NlO1wXY6/1nCrU2j3s1KdwOI1eCCa8fL4OwN51pz8lzTmVwA+6fwIcBaxu76GmjGVOtmKoyr2vjzD/bg2ei6GA8dhM+BOKly70sSV4Y0VgS9nR0N7LlYDdUo4Vq2ylLh/TKYg8LLlhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljjDuu/4OYG090RbFla0qGxk0g386zowPTlGmvncFM4=;
 b=wD0dmN18bLMXLfAEgNVqQKVk5kmyrVInCBZKoqUwTnhWuGN7g1PjrsrRSOwL9IdcNuOD7WAWSTu/5aiJw27C6GZAfLNVk+OL9GUWDH7Tx9eBnoOrJb6jXkaqdTWl8YNpmLxnbQWAtefV9T6ODLRKGXW88HvkEyvOKXRzSqTzurcdwvZPR9u40eMsKpot+l9i4jKtXWtgbd5mpOtvQwcl19DYwzn9GxuPX1540vfuJL9qIo0R7zlRK9UOBoWI46cG6b/pdAgMMfqm8I1bJZ4W/NrXanInpZeOzI7kw4hB4/iGdzVJWTd8wHP8nOcriTveK3xeFWd4WPQlDbAcdc6aQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljjDuu/4OYG090RbFla0qGxk0g386zowPTlGmvncFM4=;
 b=qEi1Vn3joce4emYQScQDUi2LGzJ341qa3URBnOYiX3zGWxX/FfGCiJx6gsXXzOGi0jQfcL/B2zlwy8PHimKJVh49OW9A9pnKkO6az/An6h3Hy0SdF4MhlnaL3FuthsWVa4u3BIJUKSZZLYvqvdWWKJfZmpWEURxyzfiJ52sSkWE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:39 +0000
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
Subject: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
Date: Thu, 22 Jan 2026 16:06:17 +0000
Message-ID: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: e98a52ab-d7b3-43e5-3d57-08de59d03a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFaQD5TElnFinQZhPfnqx+BeN19j4LJ1GG3GB+FJYUrXFBiwC1CbrJWjuN6O?=
 =?us-ascii?Q?5fxN+dcewGCqw4DebAcotXDegq+5dQSKU/MwVElvLR9eD4p5osz7ncPYuiWL?=
 =?us-ascii?Q?+AuwTI1RxiQ1cV25AS7QxZoFgQLvXPVFixFPtf19nj4YzmKTM2U6edGK4rtt?=
 =?us-ascii?Q?6wWaw0kcJ+pqwd6yQLsDpphMnypS1BZ6bxFHqlyi8kVDinGZf+hDu4Q+Mlvw?=
 =?us-ascii?Q?UFwzhDS5CHfov0lAmv+61wwmsdoFOPXCHrUcl0G5uiUBIlen3EHGVc4obWzV?=
 =?us-ascii?Q?9A92YXnBAHmxMOi3p+SHn293BW72pfE+zKPjAIFrKT2p7C2eWD4ZeAIMKUMm?=
 =?us-ascii?Q?9PYSg8lZE+9e2z61ymdo2SSz8I0AhkUievnGbTiZBP+0CHpCqa8vl9IpUn4Q?=
 =?us-ascii?Q?hk/5j5veng4Fbt3auptTnMvGCFIQ+9vEHoSjT8XUyt2u83U+nYNAMmxoTqsO?=
 =?us-ascii?Q?7Hyx5+5Gg2pdDpmvWvO90L3lv5pyb6L+IV3F1itKw4ksd4gPrvKyTxJVcpFk?=
 =?us-ascii?Q?ymvVrMCtodHmnkZNnVx2hkwgwYdi9jo7huqXMRTzcFRqB8yhYB50jxX5ohdR?=
 =?us-ascii?Q?CfNzd2wV2JThbm7HfSSSZS7hCtrADDITK6JbgZ9LdPqpL1Fgqx6UshiAErGC?=
 =?us-ascii?Q?Je/Wx6I0k2AKn3HPXXsP4b95dMzSNhuDIyD4xaI9778HfCyriUHD9pMTdE/3?=
 =?us-ascii?Q?blXhDa6CV198F51yGIXF3a3aLZPTjenMaydrE+wH4ImQEfteWHLJ31YJyYLG?=
 =?us-ascii?Q?+2a7aGvcS9FiKE1YFEUKggDe7hYQq/pyLEWpQ7Jn2Uxg4VbFZ0uy+Rkj/49w?=
 =?us-ascii?Q?x+VENnxghEJh7ryWGobJEYWabXVhsLc/YWxDawxitsZQqcTFGUJaabQp8AFb?=
 =?us-ascii?Q?KK1i140spoai9SypOXf3bzSM8whd2U94IPoFXp0sJ5nyAAL9vxRwiw1ekJY2?=
 =?us-ascii?Q?cUxcUxJevRT9iMLnxLIIEv0X5hJC8zAwa1XJgiMeGs3g6E+CbOtjpUg+Oy+t?=
 =?us-ascii?Q?pYtr+KoIgSBJSnvCGkNU1bplIym7jGE3l4ZxDio6YJa7FA6hXU+i6Ywfd3C8?=
 =?us-ascii?Q?z+N9/KETNtQg4wwKd3xk/XzFBapLhxHmfdqbYfIteCV1Ru/IL59q2fCCFG91?=
 =?us-ascii?Q?H2AJhY+dPzcW1xU3zTobDpzYiZ9Yqn1T86uw1g1NvZETao7lIMLc1UmB38Vk?=
 =?us-ascii?Q?D/WPuyWVK5tXKdhx2DPhuJebR/gImlcOhcrYmebgzXw7R+IY3TRWWeIVwHg+?=
 =?us-ascii?Q?6zKbgDd0vnwFvQGWiCsuk4W8Exzwb6YGVwa3xSORA78RKg41sWuHBa/PFiYM?=
 =?us-ascii?Q?KgfYE6xjoSaZ7vYltYo/NAMTx9ZMCpCFGtHbDVp0uhM/Jz11ezsJTz7q0iMx?=
 =?us-ascii?Q?BfDyde5IB0z+tpnoKaFEHDSYAyp+6ILNEK36V3HcBG1YNiU1WrN9qe6CbdMM?=
 =?us-ascii?Q?nkEvLjqsEH6QBZibOZJm1ry12g6DAvs+LwHfYvyzPmcg+JsZZgchgmxRsERt?=
 =?us-ascii?Q?V/A5M7AcHnqtrVdL+a9KvH5KUVhCm+OXaWD4Dxex+nvDBDjRYzZMP6v9Toja?=
 =?us-ascii?Q?t8yyoGTuH3kA+Rs36dc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMTZUmL5StD/BzTYX4BXPntTQjRx1ASr/FgU+q/lkRdRIJHpoueHuvHhxPIp?=
 =?us-ascii?Q?DvZVyxs/YWQ2nWm/ErkTY47uur7Yfi+DWPGJc0ZpOzx9wNVXOcZEHYAIMrKP?=
 =?us-ascii?Q?2elM+CKUBgKIYcSHJ520Pkp6QWd82zBIpLLsB1m6b3LAcyoP6PBUirC0ZbSI?=
 =?us-ascii?Q?XrFxbgvnQTFjiO8bBPgokFRlcQfwdXcR4TOfEs2DhNLg5/MoXpAyR8wVHxMR?=
 =?us-ascii?Q?kGF7BjMhC58uaYyfAG1yNwLCVnC2apnuoro2vE6jtzTixoJURTK8lb6GQaHG?=
 =?us-ascii?Q?J9WgvTjh//HoXu4xxs4K4WIHJUJ6o+nMgA2Fk8LkUZUyVBc41MaQB/o9M6kI?=
 =?us-ascii?Q?G7v7ngmxX6FFGzU8YTJiN6A0MpLWaSUMcT0mNKeS5u5QdNDtIXheQG/wQriY?=
 =?us-ascii?Q?YiQxt2Oe+2dSXyuc2koTbcrP49u8aF4FKOdPgKJCfl5S4k6YKLNHUbjJkUcP?=
 =?us-ascii?Q?lcYhVl9sVFtdW+e707VmVvQde5p5u56/NK9AuSquRCFBKVaZNTtAsO9z5tcP?=
 =?us-ascii?Q?ublEZMlBsYtH98liLQnTkyI9RncIUVtQcgd1/Gox5MFtto/3YT7z4/OYO0oG?=
 =?us-ascii?Q?IkaABptK0eFNH1prKTKOZWmktgcxQStVaA1c4CMURAHXEyWXOcux8lRgrYPd?=
 =?us-ascii?Q?aa7t9CQvaUeMugPHGcfK4FCz+st4X4bj6ItnoreiktRhlSf1TrRRRfYaj0hZ?=
 =?us-ascii?Q?oPoSqhsBfqprtQvsGfAB0NhEelclO1HpdGwXVeVSpmNUKyFZejyDdSxxdAlL?=
 =?us-ascii?Q?2RJ0KBDY4it1C5shaEgtExzY1LkR3rNhtggrKE3NIuj83cxCobZOEXDp8B/I?=
 =?us-ascii?Q?ArBv+tKlftyRAaqUzyytWwpqWpfqz4j3u+UFhoh1nEZqFdV3kjVsBHQ22g0c?=
 =?us-ascii?Q?Y4MjwBSP5cWsjaQl5Befh1iMkjWETDeFOYwsAwOHriCSy+NxtY9HdbwkpIJu?=
 =?us-ascii?Q?fLb6kE+HSvRd1Wg1A48WaTOVF2Q/l+vVBx4TAouQmCwmALZhmiKiBl/4Zhs2?=
 =?us-ascii?Q?6q5bPXrx7K/Bg+R/dZqfQJlgl9m+2Y/Kv/BpFKFubnTMhdZalHTweusLPtp4?=
 =?us-ascii?Q?zEon0STAWcs1eLLMc8mPdUMliE9unFHEXOBinD25jje1fjc/7tRSVyQzdIgZ?=
 =?us-ascii?Q?XfDGdvEJehzDLu8XjzDDDduB/kd9jLygUt8xJCiwOQrcrGtpBDc8wtDd4QTJ?=
 =?us-ascii?Q?sveFmJDWT4u1/y1rgcVW29YW2CkjVd5W42x5MwcJ5tZPSRMMqm2VD2GHfMje?=
 =?us-ascii?Q?DQK9bQf+8w2JHjfqEfnnZT39bjpplKefsZaVsdYOBhZQmEUknGS8ibVx9HFK?=
 =?us-ascii?Q?LibiQvLl5ozIeIIbCqYSEBzJmvR0ppcO80NoOynuwwzZwHxFH0G8TpYAP059?=
 =?us-ascii?Q?hxAF3Q2QOPDvd1avUfl5gbSpsPWVH5Pn59UJruiLKZlbaMdgxkyb5hIUTpQP?=
 =?us-ascii?Q?dYI+CVGOcRExd7zzaOw2/R6iU/KUAuyR6aKdHnF4Srjd9sGskDQbjl6y0cIz?=
 =?us-ascii?Q?PO1dFC04KlOoQUkFbr7QpfutX1KnF8j2ShOmNsi8dZs7+hRMeJgLYCmGjLNs?=
 =?us-ascii?Q?b1XTuSl98dsqWrVFyxWTFkMGB0yV1XFhomwPfaUeDguHI9YIKI8bibAcC0re?=
 =?us-ascii?Q?130qbM7uny98SMz5R1t8OQ5Bp+kJ5KgbO1cVhF8O+EiR3v2YItKFyH+uphhR?=
 =?us-ascii?Q?hqGbyLwAslq6RRni6ABwOgqxlL9pOS+EzMqX9N1E0u8k8sQv/qhV5TUaXytN?=
 =?us-ascii?Q?yANsoveTU9Ts5vU9QCSomc7qxu/zDEw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VIuDDMyxXU70nWSK5pMGROb4h50SHzmvYzV20mDZhdLlF5rqxkW9EXAgdE5egybUhthyDRTgCXZW7YKwC9K9zXfsTw+FioWcYJexAXZDBJZrUZ5+twb3xaByEDk3w1rj0eQYbzoFKbqOk4S2nNZPoT0Nd5m7GROpsuSyXcjzN9mimC0iI5mPzK77ZazOoh/35axDZ9776ty2y0ZV/l5zooxamq9fLSlgLdr59YZqP8t9KNziQnJoGgAvLfKV1F+BTYP5YZEpjr9TSrCBVfqAN2PA4f9HYkNmH6tkypmXBfo11//TB92/djqZq8ACUL6X+iuKRkUx4JiS8HRSKTd6EzTwGhSM/MWJUH42yQSRsvMJ6by7fdNx41L8cUS+C/y2bpxlFxw14mmH0dxvI7d8FzeURI7IHh0x/RY9vnEGfSQjURQrlP4XncefjTB/ElOBVgitr3rA/nUdPpr7rojckWjN7G1PJEmPvW/jjXCCp8FKqqqGdj2ktDL6rpQ8xh13L5r8lyc/nl3dibWePWC2RVqXAyftsLrfLW6iDjMVpeNmQz0h2EFUV+SQ42226Sr0Ri61f5squ/qCpkrRhTIv1F0N5jVxnTggHhZ1CeujJCI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98a52ab-d7b3-43e5-3d57-08de59d03a14
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:39.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ei2LA7ODeKJ+uzgfdjnOCkyPVImW7YcQdWBnp5/0VHAsVqtlUGMVCdTDTQa4lAiG2Gp449VMERAP08VO7Anu3LdAl78hTARpj01myIBchU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69724b1e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=vvSCmUsU4Gqzg4pU4WgA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: Uonla_wORqndmSff8eMAdfAz1wHM3mDk
X-Proofpoint-ORIG-GUID: Uonla_wORqndmSff8eMAdfAz1wHM3mDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX1FyZH6/9LZ10
 OU8604ePlA8ugxjREvvpnXvFpQs0aI0OwxoTb+hWQ43g0KlR5wHNiJdjGrdd/XOtfT3FD/Ho/h+
 +tdluwAetrOGbb57JB29Rd394qV5nid7fvd97YqsXcqBu2Ad1hNz+TYJ35hbg0LhNg00WgqSivb
 muzeq2rrHhjjN6DrVpctHoYtt4afTVNDaeIptC5e0GAJgpTMQsuT7abQcgi4/zlzsNS0VF6Y9MN
 6hgVoM8M8HVlpZfIhmW3iXYpb942ALmFfZfs5UYbk4cZeXJPzh7Cv8yzi2tCIT8G4/HZb4guPO7
 /mzuUqBXTm+dePXGCrQ3HS3eKApKaBxy2k02n3YAo36PtyVHQKrVN2OL0g/fqdcCK21xoBMKVy7
 7XqeTd5uFHOf4JtZQHscFnb0nFjRrcmZSp0lvJBAgzYQ3KHQ+G1otk/ojwzqEB7XzWW8O3M7DEU
 5J5dxMQ4dkrgal3Yg+MmommS9K/erIBq7caWHot0=
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
	TAGGED_FROM(0.00)[bounces-75097-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 50EA46A0A8
X-Rspamd-Action: no action

In order to be able to use only vma_flags_t in vm_area_desc we must adjust
shmem file setup functions to operate in terms of vma_flags_t rather than
vm_flags_t.

This patch makes this change and updates all callers to use the new
functions.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
 drivers/gpu/drm/drm_gem.c                 |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
 drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
 fs/xfs/scrub/xfile.c                      |  3 +-
 fs/xfs/xfs_buf_mem.c                      |  2 +-
 include/linux/shmem_fs.h                  |  8 ++-
 ipc/shm.c                                 |  6 +--
 mm/memfd.c                                |  2 +-
 mm/memfd_luo.c                            |  2 +-
 mm/shmem.c                                | 59 +++++++++++++----------
 security/keys/big_key.c                   |  2 +-
 16 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9322a9287dc7..0bc36957979d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl_size = secs->size + PAGE_SIZE;
 
 	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
-				   VM_NORESERVE);
+				   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(backing)) {
 		ret = PTR_ERR(backing);
 		goto err_out_shrink;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e4df43427394..be4dca2bc34e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -130,14 +130,15 @@ int drm_gem_object_init_with_mnt(struct drm_device *dev,
 				 struct vfsmount *gemfs)
 {
 	struct file *filp;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
 
 	drm_gem_private_object_init(dev, obj, size);
 
 	if (gemfs)
 		filp = shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
-						 VM_NORESERVE);
+						 flags);
 	else
-		filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
+		filp = shmem_file_setup("drm mm object", size, flags);
 
 	if (IS_ERR(filp))
 		return PTR_ERR(filp);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 26dda55a07ff..fe1843497b27 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -496,7 +496,7 @@ static int __create_shmem(struct drm_i915_private *i915,
 			  struct drm_gem_object *obj,
 			  resource_size_t size)
 {
-	unsigned long flags = VM_NORESERVE;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
 	struct file *filp;
 
 	drm_gem_private_object_init(&i915->drm, obj, size);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index f65fe86c02b5..7b1a7d01db2b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -200,7 +200,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
 		struct address_space *mapping;
 		gfp_t mask;
 
-		filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
+		filp = shmem_file_setup("i915-shmem-tt", size,
+					mk_vma_flags(VMA_NORESERVE_BIT));
 		if (IS_ERR(filp))
 			return PTR_ERR(filp);
 
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 365c4b8b04f4..5f37c699a320 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -19,7 +19,8 @@ struct file *shmem_create_from_data(const char *name, void *data, size_t len)
 	struct file *file;
 	int err;
 
-	file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
+	file = shmem_file_setup(name, PAGE_ALIGN(len),
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(file))
 		return file;
 
diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
index 61ec6f580b62..bd5f7d0b9b62 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
@@ -143,7 +143,7 @@ static void ttm_tt_fini_shmem(struct kunit *test)
 	err = ttm_tt_init(tt, bo, 0, caching, 0);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
-	shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
+	shmem = shmem_file_setup("ttm swap", BO_SIZE, EMPTY_VMA_FLAGS);
 	tt->swap_storage = shmem;
 
 	ttm_tt_fini(tt);
diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 32530c75f038..6bd4c123d94c 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -178,5 +178,6 @@ EXPORT_SYMBOL_GPL(ttm_backup_bytes_avail);
  */
 struct file *ttm_backup_shmem_create(loff_t size)
 {
-	return shmem_file_setup("ttm shmem backup", size, 0);
+	return shmem_file_setup("ttm shmem backup", size,
+				EMPTY_VMA_FLAGS);
 }
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 611d20ab966d..f73a5ce87645 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -330,7 +330,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
 	struct page *to_page;
 	int i, ret;
 
-	swap_storage = shmem_file_setup("ttm swap", size, 0);
+	swap_storage = shmem_file_setup("ttm swap", size, EMPTY_VMA_FLAGS);
 	if (IS_ERR(swap_storage)) {
 		pr_err("Failed allocating swap storage\n");
 		return PTR_ERR(swap_storage);
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index c753c79df203..fe0584a39f16 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -61,7 +61,8 @@ xfile_create(
 	if (!xf)
 		return -ENOMEM;
 
-	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
+	xf->file = shmem_kernel_file_setup(description, isize,
+					   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(xf->file)) {
 		error = PTR_ERR(xf->file);
 		goto out_xfile;
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index dcbfa274e06d..fd6f0a5bc0ea 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -62,7 +62,7 @@ xmbuf_alloc(
 	if (!btp)
 		return -ENOMEM;
 
-	file = shmem_kernel_file_setup(descr, 0, 0);
+	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto out_free_btp;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e2069b3179c4..a8273b32e041 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -102,12 +102,10 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 extern const struct fs_parameter_spec shmem_fs_parameters[];
 extern void shmem_init(void);
 extern int shmem_init_fs_context(struct fs_context *fc);
-extern struct file *shmem_file_setup(const char *name,
-					loff_t size, unsigned long flags);
-extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
-					    unsigned long flags);
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags);
+struct file *shmem_kernel_file_setup(const char *name, loff_t size, vma_flags_t vma_flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
-		const char *name, loff_t size, unsigned long flags);
+		const char *name, loff_t size, vma_flags_t flags);
 int shmem_zero_setup(struct vm_area_struct *vma);
 int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
diff --git a/ipc/shm.c b/ipc/shm.c
index 2c7379c4c647..e8c7d1924c50 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -708,6 +708,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	const bool has_no_reserve = shmflg & SHM_NORESERVE;
+	vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 	struct file *file;
 	char name[13];
 
@@ -738,7 +739,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
-		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;
 
@@ -755,14 +755,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
-		vm_flags_t acctflag = 0;
-
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
 		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
-			acctflag = VM_NORESERVE;
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
 	error = PTR_ERR(file);
diff --git a/mm/memfd.c b/mm/memfd.c
index 5f95f639550c..f3a8950850a2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -469,7 +469,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
 	} else {
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
+		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
 	}
 	if (IS_ERR(file))
 		return file;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 4f6ba63b4310..a2629dcfd0f1 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -443,7 +443,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
-	file = shmem_file_setup("", 0, VM_NORESERVE);
+	file = shmem_file_setup("", 0, mk_vma_flags(VMA_NORESERVE_BIT));
 
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
diff --git a/mm/shmem.c b/mm/shmem.c
index 0adde3f4df27..97a8f55c7296 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3057,9 +3057,9 @@ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
 }
 
 static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
-					     struct super_block *sb,
-					     struct inode *dir, umode_t mode,
-					     dev_t dev, unsigned long flags)
+				       struct super_block *sb,
+				       struct inode *dir, umode_t mode,
+				       dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -3087,7 +3087,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	info->flags = vma_flags_test(&flags, VMA_NORESERVE_BIT)
+		? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -3140,7 +3141,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 #ifdef CONFIG_TMPFS_QUOTA
 static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	int err;
 	struct inode *inode;
@@ -3166,9 +3167,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 	return ERR_PTR(err);
 }
 #else
-static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
 }
@@ -3875,7 +3876,8 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
 
-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -3910,7 +3912,8 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int error;
 
-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto err_out;
@@ -4107,7 +4110,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return -ENAMETOOLONG;
 
 	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
-				VM_NORESERVE);
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -5108,7 +5111,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif /* CONFIG_TMPFS_QUOTA */
 
 	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
-				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
+				S_IFDIR | sbinfo->mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto failed;
@@ -5808,7 +5812,7 @@ static inline void shmem_unacct_size(unsigned long flags, loff_t size)
 
 static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				struct super_block *sb, struct inode *dir,
-				umode_t mode, dev_t dev, unsigned long flags)
+				umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
 	return inode ? inode : ERR_PTR(-ENOSPC);
@@ -5819,10 +5823,11 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long vm_flags,
+				       loff_t size, vma_flags_t flags,
 				       unsigned int i_flags)
 {
-	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	const unsigned long shmem_flags =
+		vma_flags_test(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5835,13 +5840,13 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 	if (is_idmapped_mnt(mnt))
 		return ERR_PTR(-EINVAL);
 
-	if (shmem_acct_size(flags, size))
+	if (shmem_acct_size(shmem_flags, size))
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, vm_flags);
+				S_IFREG | S_IRWXUGO, 0, flags);
 	if (IS_ERR(inode)) {
-		shmem_unacct_size(flags, size);
+		shmem_unacct_size(shmem_flags, size);
 		return ERR_CAST(inode);
 	}
 	inode->i_flags |= i_flags;
@@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
  *	checks are provided at the key or shm level rather than the inode.
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
-struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_kernel_file_setup(const char *name, loff_t size,
+				     vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
 }
@@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */
-struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
 }
@@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
  * @mnt: the tmpfs mount where the file will be created
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
 struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long flags)
+				       loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(mnt, name, size, flags, 0);
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
+		vma_flags_t flags)
 {
 	loff_t size = end - start;
 
@@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, flags);
 }
 
 /**
@@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
  */
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
-	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
 
 	if (IS_ERR(file))
 		return PTR_ERR(file);
@@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  */
 int shmem_zero_setup_desc(struct vm_area_desc *desc)
 {
-	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
 
 	if (IS_ERR(file))
 		return PTR_ERR(file);
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index d46862ab90d6..268f702df380 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 					 0, enckey);
 
 		/* save aligned data to file */
-		file = shmem_kernel_file_setup("", enclen, 0);
+		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto err_enckey;
-- 
2.52.0


