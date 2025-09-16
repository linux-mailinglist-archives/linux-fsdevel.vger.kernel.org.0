Return-Path: <linux-fsdevel+bounces-61775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC56B59C50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94428582673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AE362983;
	Tue, 16 Sep 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQqmStqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC8237172;
	Tue, 16 Sep 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037258; cv=fail; b=Ah9ubaO450h07nDUCifN9DK+Ttsa3hkQBd8z8ivzi8dh7RCgqI1Xaf/aXGEqGgfSbyGuBNJSj1yfuOUghNMC1cKYEhVBQmMXUZOu5u13WE3lW//Eol0gb8SwC82gfT2lmGhVc8JCKB/CUROUNBjQchkx+28U3n2H5ivR3ul4yGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037258; c=relaxed/simple;
	bh=F540ONDWnAde6iMaihwLRDGyUz0HYGnBtUZwP8Kv4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+Z3zks0BKzN+3hqof4JMkkJXVOtPSB4x7ScdaU9yVHWgmopwxyBKr1pcuQKQgYUEjYScxswvISP3LalS1kewN2lEQkTAaNPMuVqDq9wbdl8OcH5QQOH/OuAes+WA0A+TCbIsLauyRJYuZYy8+rvn/p63XZTEyxdmFWCtA/2Z9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQqmStqF; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLTwAynldedBX4sZgt1byCkrI4NnigL/A7j1qBqTSpBywBw/BOZCfuIl7ASkL9aRAUrVVx4/yVW6KCTbHeUeJrcnxn5gZfKTQBM4kkQB51bYWHIl41s4OjoX0O2lL59TmbltVUW2wS9cBVz09PWMmx1qv/VV66sI0dJhDqz8whJbw1p9CIc+kfUmuPwut60mU5HK+DLgdzb2ChXO1VygXANDErqh1B2U6/abM9nCBRZz9AzRF194X4LiJ/q9P03mlXGDFm7In03BQOdUC8LaTdqYZ+8WEHj/x1U7AsMH0brtT+qg3o8ZJXeU/NcRK9FryxfitCEeQpP5cpoVmVRBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VltkXuJ0ImjrM7c7KPvn1ZthaTNj+cKDQbDPexFsIHc=;
 b=ugBAz+TpMPWChM+jQZdxSTyTQtDgX5BPaHxB927KXFsbW+IPmssmVRDmYpdHkYM0a6RikFe9dUvHxXkp2BMcg+x2xKnm1gwDDe19Uktbb1RPckG9hpH2m49xJ2cIMeVzY9RFHyI2MVU90ub+GJJR51Rdmntk93oztnrPdaFjPV/VBp4la9uaK6y/QWY0Emg//xvBYmi37gVaV3i69dgDDHu4Eue09wT84I+/z+RUTEy/jfzQOBaml4s5hpDQe/CqmcaeSJnljLfw0sOqgRNrC3gBkjridGZo+q/SeFFSntWTA2OtxBc6EChmGz9xPx53kJsx1nBKcjYGrshYcEXWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VltkXuJ0ImjrM7c7KPvn1ZthaTNj+cKDQbDPexFsIHc=;
 b=PQqmStqFR1riMJhY2Gs3m/Ox5iTgRu51ZhZePJNBr52GUbyqMrdvPsfibmllQd09vLv4V7WAHNQpbcC9J8YAUkt/xZimp5AeKISI1YnyW+S1YSLHVsTmdaneP6Mjgu/pmFKe5gCd1B3WttfPbAdxNqGC39KyJj/1hRM1spng5AV7cYDmMPUhkQ9u8hSoZ+Nk5fVOIQNBnBl+JUvjWHH7ONvNMc93rTGwOnlihiXvkE1xriNLU1zsOx5cT1wEaZjWMcFTRBeUS4nT9+Je4nDpQC4vGzM9ds8OFPACwQIEGScuzO6s6ymrlBES1nWPPspwtWH0W91Sj6ljesL0eqPSiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 15:40:50 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 15:40:50 +0000
Date: Tue, 16 Sep 2025 12:40:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 13/13] iommufd: update to use mmap_prepare
Message-ID: <20250916154048.GG1086830@nvidia.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <59b8cf515e810e1f0e2a91d51fc3e82b01958644.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b8cf515e810e1f0e2a91d51fc3e82b01958644.1758031792.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: ee55a480-3326-4e41-f0be-08ddf53769b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ce2Mz8DSMAopEgZmeIDmN4byvpznM16vBRcdr1M2kl3tp4iZ3yWiXbDc5cin?=
 =?us-ascii?Q?SblfAJFTzErsaTtl0IJJRrZ61QuQ7FgSKy7UE5OZOLhcUwBaPC53t8QVs9hH?=
 =?us-ascii?Q?hUVYJ+DkE6C6OdmNrD8BNowE0+uUVOnH56MQBd57PtJ4/z/VMho/GsqcuTX0?=
 =?us-ascii?Q?WNbysaDBV50/gGBDvspW6JYIC6mEXX/OsHP7IyDuWltQElc2nAZ+PEDBAC8q?=
 =?us-ascii?Q?xQYX4Tbuj/tcKjspANRGBxwNEn0U3LzoQt1MKXKEbXmxLYSWR1dZRpXDeoay?=
 =?us-ascii?Q?29+np9q6c3bn6K8zDsmBAkNNR8m2L13+St4V1WheFwaTBgLbxZgnTnhypvav?=
 =?us-ascii?Q?t9gnRyy9Ssr+vYn/SfsKl855y/hgigVlWp0wBA9tQRVelBJegE0pMoA8ifql?=
 =?us-ascii?Q?CJP04TD7TGLatoUYpORNEONZq/17ahR42gcXVp1kTuffd/5ORgN3iax98FGY?=
 =?us-ascii?Q?0q7//+GQOoTZfhJ+y37r+7LRbdN3RTJFCfshMZ85p2tVGf6RySWB89SRSXOR?=
 =?us-ascii?Q?Werz8s4nlCEnv97Y3zszyylskny4yy8QbvlogLY8S5I+kJ3wfF6BcfuRdvos?=
 =?us-ascii?Q?os2mS/qIjBAmthpUsDxu9X0/4SpYMLNENMlF/sjNeHMazSZm97bmGl5Nlz2Z?=
 =?us-ascii?Q?gChnUyU6jYIqDLRacOJFWOPij1OJu2w3YAyzOkb7MOppmiDfgxA/ZpEaWY4t?=
 =?us-ascii?Q?p8js/vd+q40BdR/qBxqKev9x6duAAeQ/HX/GdGibHVfHzqAhFDzip0vw7urz?=
 =?us-ascii?Q?+TSSG0tkMgE4GTDmlPPLBFKd5NBwuh3y46BLUUa0ZQZb7lZxUYsepB4nWgLk?=
 =?us-ascii?Q?nkqM8EYRlG5kDm4+/ZTmGfXCAi5/LGLdUuOUm8Hz7z3VWVXnQuX9JmbRM1V6?=
 =?us-ascii?Q?d4TWWgH5ANoTRAyu6iTsqscylg1n4O8NCmBsdAPfTLSFIIh0l79pOm0XOrZd?=
 =?us-ascii?Q?Cpc6ZB7PCce+lxEcn1uQemTGV7i/ZOXylNbec3huSiz8mazuHvBd9LdiS/tP?=
 =?us-ascii?Q?H6rQz86PkinNQWx/PkELOE+i7iCkZImrhstqMJMcQfoFumQskVBSsUDlFE9q?=
 =?us-ascii?Q?PKS9QxV713ki7dsilxDz5jb1tvg49dbKNimSL19CLYVf0L9xwDz7z+4vInQs?=
 =?us-ascii?Q?fTU4l9xlg8ZDSTh7xJ+gy9aYP/GDHAsTix/ihaXQHmudeWmAlohcbqnkHrdw?=
 =?us-ascii?Q?XTkFCecB+tw4xgnqf1GUOiDZjFNfv9aSah/54LQSFDItN/LCe3F/er/yZKbN?=
 =?us-ascii?Q?zcYQyLdZe0oguLFS6PL3ZjK1pf1lja07nxrmEjVbuse31STM1+Dc8fi5jRQ9?=
 =?us-ascii?Q?CT56QP3kHpnQ3vpKVGLDjt/BKSEyElZMI4eh6rIjWVYowuBiop91PI8MyZ+V?=
 =?us-ascii?Q?LZbUQFaWxgNO8+/pbAJB9QT5FE/PFbE7SEGCFVksha1xn4Ct5Xi4csoPTRjx?=
 =?us-ascii?Q?T+tR4jnOJuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tp0myZQNRFAOhXwaW47uk2WNGg0VUX3LAp82/xqo4uaMpEEzGMLFqXRtGiSR?=
 =?us-ascii?Q?q1Jg+KONxrN04RRHtMY3BYaalRQsiG7hApre/FzQ9wG6eF8q4Ufo7FbMPzfX?=
 =?us-ascii?Q?FzXuth7YOq5Fz/AoxH4zgXdwKvIfMVZoIl/wPjJuhjYtaCa3Xtz4drDBe85/?=
 =?us-ascii?Q?fwAtttqYA5SdxYSR6WkVp4Ow/Ho3+gjKuq5JyM8h2sLhYtocWF4gWlAd5AOz?=
 =?us-ascii?Q?vNwcuGqR6/a9C3NKp3wptjcT4EcvCwJR900gaaAwm6qn3fzNgRK6Dkbx3qp6?=
 =?us-ascii?Q?GoIdUhpSug2eeh04R4em9NYcgot7QzlTAFGt2nI1B6wHjUS51z5C++0f/1/x?=
 =?us-ascii?Q?ytzS3/Duw9ftOkfriclKgL1k+9j4NSs3wQYCMlg/oSxFukaLUGNCTSg9EjUD?=
 =?us-ascii?Q?BR1Bh1jOQatCJ21sqt01f7TSoBtXM9EnpeZHQJntfMg9wblz4MCmhAvsOMvc?=
 =?us-ascii?Q?WAjxNroqqc7OYxwLL5Whq5qwGF9/M4iyicQskWWjmsUacBDy0kYkSzK6rQUc?=
 =?us-ascii?Q?Iskr5PRP72IcAjq6VUnsNrDciejKwQO7drOwSyGBlqVBp0cwifwrQHoD5SEZ?=
 =?us-ascii?Q?yL4grKZTDuTkonTGJ8n9XxYkQhmIWM7ipCooPanH4j38GpymE8Sx09ZkcrzP?=
 =?us-ascii?Q?KoW+r7QuPPsotonAl0tISayRdEPCDVQPdch7AAMiXIcIiazgzXhTcjtkM0eR?=
 =?us-ascii?Q?R2vzkEwPaBoaioR52H2aoAcWdtgdQrEpUJb0UgCEEnl+Xrc+F7pU8UpeN9eV?=
 =?us-ascii?Q?/VQD3hPNVnKMnljB8AFjEYG+PP733CCNYtpt3iyNn1pJXna5FRzUemH0MN8Y?=
 =?us-ascii?Q?UWDCA3OoRdpoZCe2uJ320lROnZ+Ur92xC1IOYGmB1sL01i66YSh0M0PfbN5/?=
 =?us-ascii?Q?vmlKBLker0171p8tKQFe5hZfKTT6wN5CDF5Koou24Fj8ePWy67BWUYpzviG3?=
 =?us-ascii?Q?DSvRgmpix0LMoQ94aY1y82KkfCIrezsOZmliPoydIhjTeIOvPE1mzIUZVKYU?=
 =?us-ascii?Q?8vJJUkgxZ2pNoC15H6ak2cBWkp2CYm/NXrXw2FuYV/09E6bFq3wAvj+Nvumg?=
 =?us-ascii?Q?vRorUnsaQb3V9o23FSnuEjBTuVS0m90bosNwiFTZKF00C1V2/LIWyxu3tK3e?=
 =?us-ascii?Q?XFhGU2MgUPCq2kLf2dYRf3y/Ncv+ZjJyWzLvaZ8sdZvPAot4XWRtCq73ELI1?=
 =?us-ascii?Q?oBq1CcLrsqpBRPcgPIyVr0DZwIAKopjdRp9SZzjqB7MD4YaoHjjrEoyQUp78?=
 =?us-ascii?Q?sk0r0cQwvvokvzCRHP1E1nG4EnKTxCcJ6a4vrohFJQwREtPkD7Gs7hCtGLBQ?=
 =?us-ascii?Q?4Oqs9YbCe0TCPdtvLc/dAAn7IBMje5gkm/yx2X6UBEkQhRMtgBbbZLInGIwm?=
 =?us-ascii?Q?r2SCRo601ytkfK8FxrTuaOkWSDN15WpevyzoLM86sHf9OpMU/ws4b3Mj7Psq?=
 =?us-ascii?Q?vxGU/qgFnNNayzGTFveGvqGNLlnf/HH06cx+Vfv1bIGRgDqoJZLnDWB33ftT?=
 =?us-ascii?Q?He3g+db924waeyc0lJM/YlOTWF2t+wI4dG40Lw8I9Iy3d97rG3SI+edw4vBJ?=
 =?us-ascii?Q?3chGd/hixYsZCf9Bfw8lU8Sn76pxBtbOiyccrUfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee55a480-3326-4e41-f0be-08ddf53769b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:40:50.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0T6KufBqHiV0EbtumXr/qd8XAxcjvD2Ozn4M7Wg66C3o2g9lfgFNYf0WMI2c4rm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

On Tue, Sep 16, 2025 at 03:11:59PM +0100, Lorenzo Stoakes wrote:

> -static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int iommufd_fops_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *filp = desc->file;
>  	struct iommufd_ctx *ictx = filp->private_data;
> -	size_t length = vma->vm_end - vma->vm_start;
> +	const size_t length = vma_desc_size(desc);
>  	struct iommufd_mmap *immap;
> -	int rc;
>  
>  	if (!PAGE_ALIGNED(length))
>  		return -EINVAL;

This is for sure redundant? Ie vma_desc_size() is always page
multiples? Lets drop it

> -	if (!(vma->vm_flags & VM_SHARED))
> +	if (!(desc->vm_flags & VM_SHARED))
>  		return -EINVAL;

This should be that no COW helper David found

> -	/* vma->vm_pgoff carries a page-shifted start position to an immap */
> -	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
> +	/* desc->pgoff carries a page-shifted start position to an immap */
> +	immap = mtree_load(&ictx->mt_mmap, desc->pgoff << PAGE_SHIFT);
>  	if (!immap)
>  		return -ENXIO;
>  	/*
>  	 * mtree_load() returns the immap for any contained mmio_addr, so only
>  	 * allow the exact immap thing to be mapped
>  	 */
> -	if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length)
> +	if (desc->pgoff != immap->vm_pgoff || length != immap->length)
>  		return -ENXIO;
>  
> -	vma->vm_pgoff = 0;

I think this is an existing bug, I must have missed it when I reviewed
this. If we drop it then the vma will naturally get pgoff right?

> -	vma->vm_private_data = immap;
> -	vma->vm_ops = &iommufd_vma_ops;
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	desc->pgoff = 0;
> +	desc->private_data = immap;
> +	desc->vm_ops = &iommufd_vma_ops;
> +	desc->page_prot = pgprot_noncached(desc->page_prot);
>  
> -	rc = io_remap_pfn_range(vma, vma->vm_start,
> -				immap->mmio_addr >> PAGE_SHIFT, length,
> -				vma->vm_page_prot);
> -	if (rc)
> -		return rc;
> +	mmap_action_ioremap_full(desc, immap->mmio_addr >> PAGE_SHIFT);
> +	desc->action.success_hook = iommufd_fops_mmap_success;
>  
> -	/* vm_ops.open won't be called for mmap itself. */
> -	refcount_inc(&immap->owner->users);

Ooh this is racey existing bug, I'm going to send a patch for it
right now.. So success_hook won't work here.

@@ -551,15 +551,24 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
                return -EPERM;
 
        /* vma->vm_pgoff carries a page-shifted start position to an immap */
+       mtree_lock(&ictx->mt_mmap);
        immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
-       if (!immap)
+       if (!immap) {
+               mtree_unlock(&ictx->mt_mmap);
                return -ENXIO;
+       }
+       /* vm_ops.open won't be called for mmap itself. */
+       refcount_inc(&immap->owner->users);
+       mtree_unlock(&ictx->mt_mmap);
+
        /*
         * mtree_load() returns the immap for any contained mmio_addr, so only
         * allow the exact immap thing to be mapped
         */
-       if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length)
-               return -ENXIO;
+       if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length) {
+               rc = -ENXIO;
+               goto err_refcount;
+       }
 
        vma->vm_pgoff = 0;
        vma->vm_private_data = immap;
@@ -570,10 +579,11 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
                                immap->mmio_addr >> PAGE_SHIFT, length,
                                vma->vm_page_prot);
        if (rc)
-               return rc;
+               goto err_refcount;
+       return 0;
 
-       /* vm_ops.open won't be called for mmap itself. */
-       refcount_inc(&immap->owner->users);
+err_refcount:
+       refcount_dec(&immap->owner->users);
        return rc;
 }

