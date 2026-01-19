Return-Path: <linux-fsdevel+bounces-74547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C86D3B986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA849300ACBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC12F9DA7;
	Mon, 19 Jan 2026 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+jfyT1C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="apMlo0OQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68E2FC009;
	Mon, 19 Jan 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857667; cv=fail; b=n5JFL2GMxWyUZMrj14CVfwdtzfZV60nzmA5Kxocu/dCdgI9lN8+cSCQXN5B5DVg0jMprJQZ87mDB2ekC8VMmUIPgueoaSql/ZNQgxfoY/zSNyUGjWk5VRfUrrnpmZ7a7fFEZOvx66rmkzhbJpxV+A7yh7MVjcmrJG3cVT5siE/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857667; c=relaxed/simple;
	bh=UA8XYMlY5RvU6vkcL0LukbpcpzFDBBk1FXzLuTHAy8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPzlYvX0asCvmxOXnFcLBGPQKFTtxHZ/uQQ9mkhFDQNBIMKd5QOS5eBd4XVtWPivjjpV0uvDP2EP48y8yz1+sm9kgAHBNDsjAPtUOpPVzFPWxP2llgtXj/2JPe1qtYd5/GXc+qoKD61vyHAIuSzno6ZqeWP6dmc7o4V87GMGmto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O+jfyT1C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=apMlo0OQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDOkJ1269382;
	Mon, 19 Jan 2026 21:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UA8XYMlY5RvU6vkcL0
	LukbpcpzFDBBk1FXzLuTHAy8k=; b=O+jfyT1CIuzJStiq3+z/5RNF2hlPoU6Usk
	pxWvpA17sMCd9I6u4H44m7dRuVjRZ2p+uI93+vYtiyfeaprxpE5uGBT/nVypzNxx
	nKroviGXVeXpcIRFysx/dUOvzjax80essCCRrgqPqF0Q3Q/42o++QUWyVbKkoMM5
	HJ+FNzmSCWfeEfUI9mJKJRoE2ewciFt360HiupBAGF1RlR93YZO2nB4prvd0nIwH
	xP4dMSXSaHfY1OCoblx3QQjDccInUJdxZhJKoGnwzf0jCLjB3Hi1DBHiRWSsGpLG
	aUMGb5GEbHZ7KcM71hpYJvt13rcHII40WcNsNjjuR1MPoYwlmgVQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8as4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:18:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKxbVd032442;
	Mon, 19 Jan 2026 21:18:49 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vchws5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUJrU3LevnqzzpMHrU4ovuyvw+LF2nLFOcjcuLKuGB0tED8QUFdMxn3WKKMdhQ53q5vzZnIDMMocG4dDFVY68Np1oylVNDGjth0UmG8Za4R6vinwzmpfABpC8DlOZaqQXjMvHk2BfrFoBqg6Wb88fzff1ZmkPNrGOh3N7AenYNazdwugRcDu5yPn6hQLMzpmUjBwXAXuXEdFi3MzbQsxLLv54aLzsdsi8oR+CyiGIERutQi+1pT1/gkxGkLKhqocmC71sxkP++j8Vsa7nlW1UP/Wp1fqn+fHX+lS6wqSTNTR/i2TTmCj212xVRfDw/gm6bjfNni12W0JkFI9eC+hEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA8XYMlY5RvU6vkcL0LukbpcpzFDBBk1FXzLuTHAy8k=;
 b=cf8BzmSL2iH4Oe60IjqQKcWOGPKO7kinTTVXY5m+Eb84QFmESf+QteMZ3jw5A+ILOlXsnXG8qe2WtwmnIgxMaP5yqk2BhcaPc7TpFxjWCYovWcwR28z2/T+BtgJNC9VXyBu4mx2GmFOz0puPFZOLZKgCvQ18R9NMcMIIkzhsyxZcUypIUKnjrjOVuAVL1RmNO+3rJUGfDh8Ki5K4VtgedWiQhnRgDpbGDmXNvrsVWnvgeM4gdhJaPcUngH0jLKuioVeqCDj1URF4fJfoBW1l7xSdB+I10iEYAhuVnkvwKd/nNTWvnQQajrXwe0yXviOIr4u+pB2gBI+5oxB+CmXtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA8XYMlY5RvU6vkcL0LukbpcpzFDBBk1FXzLuTHAy8k=;
 b=apMlo0OQgzZ4g8TdRa5twDzSgplYjm1RsyBk6W+xMOdkaQd7axNeAB0Ok5mFGF9tc6lJKifpvi5ahNRvcS0iVWeJ2tfF1UJeUCtJiFLdxVx9SbZZIpfhLIT2iMZhO424vETdPhY+44FSXFs/8ZeBIl7lElp3g3Lc5dMrBzMp3gc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:18:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:18:43 +0000
Date: Mon, 19 Jan 2026 21:18:47 +0000
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
Subject: Re: [PATCH 00/12] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <6a7510d1-5346-48cc-9746-9d5d9eb8d027@lucifer.local>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
 <20260119113302.76b21eb8be2f9d0bb076446d@linux-foundation.org>
 <e7b0dfa2-51c7-469b-a6f2-78b505c0f139@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b0dfa2-51c7-469b-a6f2-78b505c0f139@lucifer.local>
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: cc46bba5-aa0f-4e78-4cc9-08de57a05321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YaalNDTBBlBvq0UUz8AX016MtJGqiWxCmXIuc4JEJvJ81sjwPL0kjXH6mwFx?=
 =?us-ascii?Q?JxbQCo0r/AqXd+Lzx/DIY3KzH0ajbjJyEXkiXf/xuN5f+WP7BPZnSETf8FrQ?=
 =?us-ascii?Q?LqvrUQ0r9sNWGKSwOHqLn1uMHjYutsG2DHeQLQB3L1CdoJWH4WRFhtzIvkNe?=
 =?us-ascii?Q?prSOBxJGFnSq/0UOTN89Wf1hZCJumL6xuZ+fERIhBQfISQnEnbVHPmUgyWsE?=
 =?us-ascii?Q?biDXF6gOhrbpySxNrI6atto6FGv5E+TnlMYyBxnj4vIIBeEoLE0cjIgNzYZg?=
 =?us-ascii?Q?cgtnCFT/5KywB4Kb59BcxHMHbmZavmEE8H9IXFJFXZPcuGYQf1kuv0UJ4aMd?=
 =?us-ascii?Q?y45vwXbpgqewEG09ZNRO6a4xB71aFJBbMvxh2w2fb0oQ1pUZipODUZ6PFUAg?=
 =?us-ascii?Q?Rs8R3ItZ+Zcws1a7F1sK32HHA8M/2iIzJkeUjGyST1PLZ4h7NFgvoa0yd46P?=
 =?us-ascii?Q?/R6t0J8zUUiLxiS5lIntsnyarm5pQAnL8De1ZtqmElhUBS12YVdWv0U3ahdm?=
 =?us-ascii?Q?0YydX3Ov8u7rDZmbxkSzzi1QYp7u18M9dHMoWBp7qoOmoc0ngTj/xEzJ8IBy?=
 =?us-ascii?Q?cjFCeHVOitlLQvwbl/+o3Jbg2e3zRLk8AUshi8RnSS5e70zBhR3Sa3GyEy2F?=
 =?us-ascii?Q?4qIRCzPvB2UpTEI+DdKmoh7sJBjLNBB7ntOUp0ezz4+b8wVvYh02pf9JQbVN?=
 =?us-ascii?Q?akgqVEYGgRs7M3QZB2cAjqd2bB7py8uaVOjWbIGZFYOYONCWhrcwb97telOQ?=
 =?us-ascii?Q?WCsS6zBGpjhfVDdWn8h2xBszKZw/v8z2sALIq65gDN1d3bp3Wt+rSjT1jGiu?=
 =?us-ascii?Q?V1VRH/GheU7jX0FAWRb1SfSjK87erDO4f1DQOw/YfLJ23uTU4KlQ+RAa7Z0o?=
 =?us-ascii?Q?bDLVIz/derbax/p0qn8Rrqc2fXEPKhBgGzhRRLvrIk58eoW6S9iK4qRnCdeX?=
 =?us-ascii?Q?fiOPKx8saIc0EtYwtx8nOiOVkqIoHA3CzzsxegpTtsSE655p1F35QRVumI1+?=
 =?us-ascii?Q?uYfedSpvuwqaIqtbz20CEb1G3vvjfffAYloh/xQnvo8ws8qrbCGVgdWJrHyg?=
 =?us-ascii?Q?dS42/MNuFHfxUj30+nOiSU1lCSEV0QZbYLosz7OZM4vfN7xcQEfjqk2VOiXP?=
 =?us-ascii?Q?AB1kOWluVaJz5tLqFA3Pz5zPRMtnIBRgxpEmiKRRHphrHvSht8qsoMUqkYza?=
 =?us-ascii?Q?mHtvY3pJH9x+eZlFHs1QvSR4d4wozWsaFkybcVxXMOyeadps0gRmednYl074?=
 =?us-ascii?Q?KMILltNQNAFGIp4syPjVxSQr+piuk0eYaRBAgJp9elN/FK0vYaNUEhb1Yui1?=
 =?us-ascii?Q?mfHcig7Z+6yQbe0VOZd4Mg/cvNwwU9rkxgSNahMp2V/euAxQ3JqAlm8QR9I0?=
 =?us-ascii?Q?06eAZBnHdK3JMaot/+2nvlNdytTe28bkOgBYgoWM30aZC5cK5r1S8WZlFLO2?=
 =?us-ascii?Q?oMYoDYibhcAGTQYFqImK1W9qtxE8N8UBhRlKabRU0zc0fJ/REQF7I7gm8kxK?=
 =?us-ascii?Q?LPREwkuRZS58gKA2BtvCQMEWryQDxVcNiRRKh1KsC4GtW1XyGh5P6Li5d36z?=
 =?us-ascii?Q?euTczmTkmfx0p3WEX2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GU3Tt66MlYmtmwLBaW9/1qrxq1CXd0sV2dbUPksD/UuNY2/rRsK5B8MjQFcf?=
 =?us-ascii?Q?XIMpzbGccK1e+tnalqOeINp6wf9ieT2okk17Xaof+DfkAweerWLHjNpybXR/?=
 =?us-ascii?Q?cUHWC9fX4rlPsEyhc7GKz2/9YFmKfHPB1z2pOJ1NCZawgtu6ZyxzeV3Jh76i?=
 =?us-ascii?Q?UrF4L/Rp0zxXYAmulZjQd+OrgvFMHPM7hgNVd1M2Tjk+a9vPPEtXj/n9TbBX?=
 =?us-ascii?Q?/Tt368TD1NLbxHXURBX39KDuuaZl47gfc1S/uV8EPHMRxLEj9Zk4jhmB/Csv?=
 =?us-ascii?Q?XC1XkA/5J4rxhVDT4Cfu/XWhwUfu1cc6LG4iI0YX0jSYAzMBjq6k9KqwIFsF?=
 =?us-ascii?Q?OhkBL3KeM0BB0iH4ER8P554RoGJtwnECKnQOZ+iVBVF4tjToinBK1pADmX/b?=
 =?us-ascii?Q?TE0CchpR7cIuSUsiZisFiRtpy2bAlAOuDi9dY1euNPHF9cof6+eDWANAjOrj?=
 =?us-ascii?Q?VC0TK8rv6oorzwkOdLY52uHLH/4LeptI8Z5BsdcEeYtibRM8gmPMPMGPurUN?=
 =?us-ascii?Q?20J5M3fgqgYuTrCSJoo7L3Jo2juVkV9q+gQXh43/sq25OKZtzIQ/GisqvxeF?=
 =?us-ascii?Q?EuL3bDDdKv8rTdpH8nPW904MNz9ZyganTIJCrvR5AG2BiViGtVzF9iwjwaXF?=
 =?us-ascii?Q?p7cjG55HH56yl721cDHLKAawt1m2VDMTzDTh1Bn75ZnwDAFgIyvW4q7f8w3B?=
 =?us-ascii?Q?33dLQa8cwt3NoWCl2f/wJoVrvBgtvfGX1XCeGZGKLRuZtEzooKOrmk5t+/u7?=
 =?us-ascii?Q?LPfmmWAEMyHFcLgxs/CMPgPKVKv9uQYfAcISfows+uq/b5t4PwjjH+PVByO9?=
 =?us-ascii?Q?X4wp7sWVgvKSK7XRrYyBTrJzw1zYVumx5815MbkJO9OWIn6YHKbqYRV2jLAo?=
 =?us-ascii?Q?1odIR3Wn8QbQMPAiVbREDGNewo/L9jdqu/tkdnioEJ39r+oOeoxl2HDyDREC?=
 =?us-ascii?Q?//3ZHIGU8Hqbbt5adIXHi15CT1cd4zdApK15WSKgFf995yO+t6/B/b9bCOXj?=
 =?us-ascii?Q?6WjBHSF93GY/p2gsPh6aFGJVB7LQXLT4tSA/I2rNlra0NbxEnMLb2+/zUI42?=
 =?us-ascii?Q?Sq4KYrflTs0yPuP9Ui7WPbjYlhBwnKdlZh6WuapigWHIyi1dHtya6dXW9oEo?=
 =?us-ascii?Q?2WJf2C66vjl+dDD9w809roxmv5eQr8JY9fMEIX6fE93bkzjH/vrTDmo2s5z7?=
 =?us-ascii?Q?EyBRSKlL+v00A7vRAypXafVCuDRamIBU5o7i21nrmfAzoUAwdKjjSGlwuFdH?=
 =?us-ascii?Q?+JjwmwCGSCIHt9DBNJr2k46VCe+LMlTkeMjySzQtqGaublEu/j1OQ5K2+zXT?=
 =?us-ascii?Q?2bQ2hc4GsHBnzzB5GHAmx6aAl16A2l289PmffpTLcqNLUgK2YRr/LsCBiFav?=
 =?us-ascii?Q?LAkned9eSmOVNHpZr9GizWqLK3GXJ+z1zAFin8TXE+JwBQNcbgKFXmMhdoAd?=
 =?us-ascii?Q?yiF8jI/3OaQXffV17vVcf7NeQJA/Qyz4lW86jrVTN00b1xqSamr93OI8IWWw?=
 =?us-ascii?Q?DMKWQiV3/veByOgD05LkDiEMAu8K7o65uhSTkpw0H+6ssx81gvXEuUvbxo4e?=
 =?us-ascii?Q?qdQ/8HG5Xjc8nskbGifnXSsvPO2ZSWbjdBwiWhmSMVXl4u7CuzEMZuako8dF?=
 =?us-ascii?Q?dX3rafex7ENYUtjFMku2LaiTw/A5lCtGhlp+j4YJURJvxL+MR/WRQKJNExZN?=
 =?us-ascii?Q?SN/REDqvsTS7/BKhM4+zBky6h6QIoa1o23axL+/bZvuaHyHs05fnCl8VRMqE?=
 =?us-ascii?Q?vLjHgIEPdEuMGbieElkaHEBrtgBmqrs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xl0r6DbH+mRmN+HzBzmDhCEudAtTLQ1xiDGx0IJsaVnuYyn3yR1i5Y6iBME1coxyBgv5asIa/swMczQKOtxi5R19ofLrpqGIIporXVRXtg0kYr7BaJEmLnCZjNdqP7VKzlH3lcQqpWCx78AT9Y3hQphNeVbzpDgJHjfSM4h2ogj0nY2LUTAaQAQ0peQYOWQWzFniesZnk4gGh7xbB3IoUVWp13PBNuVfc8b5i9fvwn8gciACxzCQrB/sjMT71gw0KvS0dCoMhDI9CJxUJ6ib8MMYi62zQf4b5+hf/E+8C97iNpEnC+qktel7ovptaA3mQQFDiPXxxwZ0qFtSVFncTlD8JdaEqbhplGxrTDvofDklfkEdEhUeE/ZnZqejz4YL5UszEUBbHASB7/qoSTfS42kZodHusY7BbatoymB6ZcYwC7NLGMN6No3eg3/yL3pHxltoQsI+I6SKLbm13M9ZQPxPNmAU/XM6YAcgsVaqNkXIsmSdJKFDdiv+5beFRBoiHexnbJyEC3CVToTfQmVnZnRyKkm4i6xn6aXxvWGyas/B+w1+/ph3Ng1XTdWlDLBpgIjMl3tFBMRRvQZReU9dHEXYDPbbzbKt69fZA+ymwOc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46bba5-aa0f-4e78-4cc9-08de57a05321
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:18:43.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l7Ou9fK6+w0UbZ7V7PQRPB78OibEfBTev5GuzaAV3OOoN4+sGEzaYfzqJmQ2X2PKKEYB9XiVuZrlPOZ6W+r/z8sFQLf+jwn7tUefbY9+oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=684 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e9fba b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BabDg4oCxTNmhIoQOgoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX2FYLT2C2+ZK1
 4kUk2h7Hwkot1zDKNbAqI426z7TpzmV5AVnSpE6rBfy8XGT1Y1pknJxX35+97sbGfH+UMOQyPm+
 Pyhi2+b/Bz8w1Ntm8lxhNxh/MdNPSkp2CzagtQyiGkdz6RwfpVfKAv6700RP2AglCVHhFL5Bh5K
 ZhIEBtSURoJKWfMhJh562y8ZyLmaM4DfN4U4ZxJLRKWKAggOevskdewl9kaqOzyrfEGNqW2qV6r
 sVi2ZeTrXUgeruCEzB175zfsP/EotFep+HH8WLoKNak7YoS9vrfrPSLhtEVw8/lHM5C9Cq7HmWt
 NbCDPHvdoaqcqPaphMYjqSJORx3gETzZRqsWGoPD/KMcPo8YWK11XziMYq1DVz8hmQghSIxQy8S
 tJoV8VrQKuA3oprAyqxAkQxMaTnqn8t7dU3P1LI47449vN37fXVThCTd4k/7X/iFMWWa8heRZ9G
 oebW4SoM/2eUD8RRBf1uQm4lk54C6gWSRgnjkXL0=
X-Proofpoint-ORIG-GUID: fFxqauKLVVTiWPHP5YVNpkkWJ8XssKI0
X-Proofpoint-GUID: fFxqauKLVVTiWPHP5YVNpkkWJ8XssKI0

All - please disregard this version of the series, I'm about to send a
resend that's rebased on mm-unstable and fixes the merge conflict.

Thanks, Lorenzo

