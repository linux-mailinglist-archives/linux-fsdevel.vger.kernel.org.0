Return-Path: <linux-fsdevel+bounces-74559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02BFD3BB91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 00:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30FF7300AACF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5452DB7A9;
	Mon, 19 Jan 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/XmYs/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A516FC3;
	Mon, 19 Jan 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864450; cv=fail; b=SL/tHvZXY+wdIwrxfjkjxD0G5a+dujMjNx889ZmHGJz60xZCtZvQihUd3Nd6fENe5MkCD5yUwbJR5iA5xucSPNyQQFwg+9UTjvEwLg0JcGYWM9SbN2K2KVHFIestm6h13TQS3lXpKJ2mxBXa92hFMfw1Qz5wAwTd5Gb80M2h0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864450; c=relaxed/simple;
	bh=HQPt6PBszCETuKAyzgpAe7NV+wRk2CM2JQvy7oTPsJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V9ggvDu9HzQ0QgHk3ipUgK9laYQZYo2OEqFwIxFDYhzBlRoEcYiPx802IRzwrAYsUGDCCQHJwCqFbUJERIiLqROry6wXIfp0dbJS9uiN0N3QVGH9zYyrQ9j6G730Ryg9mPkGJGgyCOPPxkMZnC4C3DidSHz+tMQrIzpdnJaAmrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/XmYs/K; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTdnZjUSfD0hQOAVdnQQ9I9EcNFa0WAHKCCZ1+goBsbm+u4gQmY8Uu4NEZdnvHEQUvYxJAa7kQYpb6XRXxg5dN9bXkS8yVNV2zRIykOr37ktearzQTghOzBQE3llg29Me20c5VYximektU/u0sTl9Ghn2tmVB1oc94XnqJPdQfGwCn2n6o1paHNjcuMGJIsvJGFiVLnF6ufrsvackgZTn1OXyDyngwFq0OKQ1piUAv/bFnJUCWCS9SqDUnxX1TdHtuDq8N2lZ7rnRVAbz6+cXi2z1B0b2v8LRZ7n61NOhnBeaG04VwWaK2KKnNGwm6/Qp/Uswvh+C8G2/UMYX/jJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQPt6PBszCETuKAyzgpAe7NV+wRk2CM2JQvy7oTPsJA=;
 b=dMSwHoCD3Z9+lliiHsOosO8Jds7ie/mwB5KZlY3J1BDMn+wJAHI/MkwK8bYQk0fw4iDhVQ9aEyManRE/nmhRV/l0HLGMwujOYhI0yihNCka2TBbnzW/gZcExtR228jW1WD11mq9fOiocW5OSjDOdoiHAzBxyoLkpYyljwoTxybMRMDUqO0pvB/dsILCveBJ6HmmjmzIU/VsidsGyw6HFcAdis4ZFVjuL9em7xX6YTPRTLIYoIthVB+uY4QZE6zDvfy0brYsBwtYOz58QSsKzW82C6FzNLxfDqQ/H2AZZxgsRzn2Bl+Y468db6Z25qpwP68FzVaWwrrNgImkLVXb9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQPt6PBszCETuKAyzgpAe7NV+wRk2CM2JQvy7oTPsJA=;
 b=s/XmYs/K/R+xDW2KkDwzwXUFyJH2QctSj7qqNrwvzuXvSzqz8mLyBQkYwpSP7Rh8ndlurGJz0pjKECU9STQpRmmAVOdmXAZoywpY+k8ngEl6tQigiQTXTkqX/vGJLkDhwk7VUS/Oj1ohT/DGBRJv6nICzFVL0YhDjT+hdcxP51ZJ8DdVxAF3DTZBzp7xahZjEnqeyjhndEoJn8OlTWy2dsiDJpXvml6/EqDX+WthutN+gfX3/JyWqm0pqk9tXLuLiTH2DI0gG58mwbyY2Jq7WDLNisdm1a0eknUSv+6EPR/mWZrykhJ73AmSozjqufHJ+gWXL6ILTb9L2wYmRB3Ueg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:14:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 23:14:04 +0000
Date: Mon, 19 Jan 2026 19:14:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
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
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
	linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <20260119231403.GS1134360@nvidia.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MN0P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 217281e7-f4bf-44fa-a633-08de57b07019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erSQpTz4FnhZ6yvd2UKP0wFq3r3bexz1JlmEC2PREYTNqJQXohSY9xP+4Dts?=
 =?us-ascii?Q?I7SKRcty9jt2hX1TZt2X3b6lbcnDWWAgVjpv2dU/qFz8PF3lCUwWHzjZ4nLG?=
 =?us-ascii?Q?6k611tBDc5CrRneCT0G58y4/61txgLrVDHxd2nfme5lppv4DzJNKkBIl61IB?=
 =?us-ascii?Q?j+9SO7xOPvSnBxPb4FDjDSNkoBRHAN8+QGe3a3vEHzJLZtQVlNXvml9c8TxV?=
 =?us-ascii?Q?e3B+j68vHekXOlCyzU4nXK6wLZmBpHXq91aFmiYGHsfcN0tURVrZbc+HDFb+?=
 =?us-ascii?Q?WTIr2wWWSMeRJCH9MD5L6VHuqTZWcFJYnnzfVmrpYjGf9e1pt3a2r/UGuJ/6?=
 =?us-ascii?Q?OhoVgbWIAb7iX5bqsg/ssJxgCa7ylg9W65RzqQvvYAsxX9tlBApnoB54LRCX?=
 =?us-ascii?Q?vUoKFsQcHTU0wPCJJdXnbYZQaH+w5jfoUaUY6pG7D07jfCJKgp4hIFWX0zT/?=
 =?us-ascii?Q?o51H4lgbifLPCqFXFeeW736RDNcdO/vnLIS8wLPO+vlUC6uh/UpMr6lQykT0?=
 =?us-ascii?Q?ZvgqVrAkjQsDirrvy766zrcXc00rvJ3K637QYY1C5geYHJwYJkDZv7EyOzOX?=
 =?us-ascii?Q?QD5kw4vfsFAAcbqjPHsb8HYrpRRVYZFghE2KaoXuW62/PK7VEKlAOTDnHayl?=
 =?us-ascii?Q?AgU0YzCEW33qSGPK3d+JqGbt5Ajbq1cxzPeGfXw8eHd9P6WDAmupuH9YxRvw?=
 =?us-ascii?Q?1VuQthIk0YSNnAfWDdLLkwKM6LpvRvgQnpIgZzi3pGeiN0BZa5Yks7qgjzRt?=
 =?us-ascii?Q?gd4azpkfj8LbYPeJIS+Z9CTHe4QC5SdVEgKTVrLl/DjxhJkTP5t96xOgt9HJ?=
 =?us-ascii?Q?Mtd9JPug5KTLJ8se40W/8pfgWvBGL2vI8HrtNxmbXPopjmlHpVIQarnIP6Wq?=
 =?us-ascii?Q?DRpETMdjn+Me3y6aeXjVMJrsaNBmt0BWXAvqj1AKqJ+tTtGRa5Uf7uqmqMa3?=
 =?us-ascii?Q?eEbyz6YI/S1D8dOTwU0t1+xi0pBi7SDYC5rT+dZDSc6sCfNJA+pPAdAq1zsK?=
 =?us-ascii?Q?UYKVewsTeyV8hQaKSK3AWdk+anvBSJvTeQyCsVSpE5WNf6PWJS5HcLsLawqS?=
 =?us-ascii?Q?6GZiourPqRetP9oNxNl/cd9xIwcjy1PCnmwrBEG0kurPH/HAncaw/e+FEc/V?=
 =?us-ascii?Q?BjJxz5FMvpu94BK8G+ArO+jOdHrVqrzk4avybqLrKGF8FL/MNI6WXlFGLWVp?=
 =?us-ascii?Q?bDyVNqRPPryy+Uiq+9lUr9e0LF5Z054X0RwMR1inx+mEtPnPAXVsUrAUkZhP?=
 =?us-ascii?Q?HGXCehnfLHnY5HkrtuVjRlJwiQzF9TeBhbNR3GTVT53hLdSmpHAXaXj47tKB?=
 =?us-ascii?Q?Ap9XZHsYJAQ6yl3QwZbSZTq/aTeKpprpetCZGPbrbAKzfhmX4Enf6h+WRMx7?=
 =?us-ascii?Q?fIKNRXHcMQceYEy1hIGAw6kGJPjIgthAMFs8SXAFV/dtobfcEYJpwOuqEI7g?=
 =?us-ascii?Q?1PalaE547SI5nfk9jL67FonFRcX7UYSiR/g49AluBuwGGJabux0bJaZB7L9R?=
 =?us-ascii?Q?arl2x3qiUaQSGqZ9204vGHTTlmyYP3xoymdRqbsjuExrIsoVx828dezI10Z7?=
 =?us-ascii?Q?Ijt0382jnY1B9v3x5Go=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfH5fXAgmRwPvbXL7QneEm6/+V8kKNB2guC/Z+Klc7Ym9QU1BRDbG5tmKRkK?=
 =?us-ascii?Q?CeMEEexPRgRdBc+oZew4uNjcf8GuRWmVwiNtzWDYN5xFVFGUmPVPFVVuu7eV?=
 =?us-ascii?Q?jbRwB4DwlcnTuQquTLdHRyrspI/tC4bMe6DObhwjOzvfoCf8OtkSJFhPfEWE?=
 =?us-ascii?Q?ut+1fEbwpZWQJqiFLKT06mpG5d4N3p/qY3ai70g+JBiwvgkQiRyKbOlSiSU5?=
 =?us-ascii?Q?8alRPtAANI80c+Buiz3WbYYywCcpRwCpb1f2QauQkEUhO55n7R/LQiaKAz3q?=
 =?us-ascii?Q?RIkRAPdLGtAj1CtOQckl5Svaesi4HmNRBBCadGMBUM4hSftyuppGgboFKxvj?=
 =?us-ascii?Q?WyLaC2QjneMUU4cjvgeCxBAlgbmJgKVMxBWAc4g2OaItItJjQwukXPY5jtwy?=
 =?us-ascii?Q?1QJ+0q0DfOZuTuX3cp9w5L1s4QJKDBqzE0MJp/qIKnLUcuxTOwwmaueCkSEN?=
 =?us-ascii?Q?B4925VUkukU2RejIm0/W00kzqL7M44zytzBNJjwqRSV/IheekMQkYGSmvxyb?=
 =?us-ascii?Q?w51cSJ7miybWO9kKmQYxg40SUSG84nHuFOTIA3XpKsJ1/AmbXl8bCwhPuMe1?=
 =?us-ascii?Q?ynSz7zkglxXXL/bggkQEM7flvl9N8OvECIr2ar6b54fxhOQoF3OnSIY/e3Cz?=
 =?us-ascii?Q?qHROpCXW0KJwnEkIB+QQdEvVVpvgK3F19Sghcyk7f+er7Qp4Kb0AfGFbpRrs?=
 =?us-ascii?Q?2j18IAHVKPN6MjecTIGPTfl5iLcb6319pXM9BnBXHG7RHmjSXSoJ96nlxZmb?=
 =?us-ascii?Q?/73z3itNpnOigOCnog2FGwfVezIb3WF64bPjHiU0Ki/2CGgtDzRR/nAy1ez/?=
 =?us-ascii?Q?UskVlajBmswzjvnfqMyo8alfj8i6ziwFBh6ZIv/yM0FNW+0yeVX8ST3Ac/I7?=
 =?us-ascii?Q?ncsSDRoMnWNY4XrASwc+HzknT8dAjmaJTOVTbCoPbSq8OPp6nOYCF7izIoXH?=
 =?us-ascii?Q?9VAxY81wzNVsUfZaslbTKVr/pltLzCz/SzEl4Rf9zshqVi6jAeQsQc+4r/p8?=
 =?us-ascii?Q?csdVFIkZbMboAGSB7deFXaGDAg6nnRmIxM7rcB/tnNola1ED7Xk6iPlGSs8/?=
 =?us-ascii?Q?jMvQJysHTX5bFZVI86beE9afvBevZW+0mwG3i9txZ3Fx5h6lLneRvMQqfa5i?=
 =?us-ascii?Q?LogJqG1wNNjufmCfey5NvZcj74DNcvxLM2r5UV9Gba2N0JTI/o6or8obJcLd?=
 =?us-ascii?Q?NaR8SQE9RSYdUHjlehaO52GaiwGac5ihYuQkTyE1qu81vFLmc+4p88s78+7P?=
 =?us-ascii?Q?I93IPOrs69uFRkDqLX/fdBLtcGQyil3ua+16uUJ18gIvPY7jh3YoLwhbsVCf?=
 =?us-ascii?Q?RkXZTG49Jhaw53hJDGwKQxnkOinpEzbf9VdvZwsxvXAO0LWRRWJCxhzCNVeR?=
 =?us-ascii?Q?sXxpHO061BTZT+b6IyYMjJlq88VIuU20IyVBCHwpYxLMhFc2YRQa3z+JL/E/?=
 =?us-ascii?Q?dsaH3lEOFZoe8SxAckzbKvfWPzJ7nCA1OejxgZBBZwIJCGlO2OoEt8HOQy2j?=
 =?us-ascii?Q?kvf3LvocraZgMLWOTzXsm+qf574gWF0RcnXGK4QR5S1fjeyx5MwbYRCEum7l?=
 =?us-ascii?Q?JYxApXz7anLsWORYP+iCLw5Es54jToiAMItYCsye0ugVvWkoJf3T1Paeg711?=
 =?us-ascii?Q?0QFt6wMt/JsN3VfZzg2Jy5rtwdYajxm7NuS+M0LqI/qx8MpqSjFbyrBvyYlz?=
 =?us-ascii?Q?QAnOj82HpLzllM/HkrRA39vk8H41+o7G2JFCsec7gpnExvxPOt3JsOT4LkNH?=
 =?us-ascii?Q?JGpgZ8QaUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217281e7-f4bf-44fa-a633-08de57b07019
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:14:04.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlVV120V9orS83SOIipfynZ48lxqTiMg11Ui15YC2okaUnhhPNC03OS5UFxL0Sa+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On Mon, Jan 19, 2026 at 09:19:11PM +0000, Lorenzo Stoakes wrote:
> +static inline bool is_shared_maywrite(vma_flags_t flags)
> +{

I'm not sure it is ideal to pass this array by value? Seems like it
might invite some negative optimizations since now the compiler has to
optimze away a copy too.

Jason

