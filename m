Return-Path: <linux-fsdevel+bounces-74560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB16D3BBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D5B2303C209
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA12FD68A;
	Mon, 19 Jan 2026 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TtjvlLGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB227B35B;
	Mon, 19 Jan 2026 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864488; cv=fail; b=qXaiHE/wRXa1+87vLgNQrrOfSwN7ajDPRQtBAClGSFDh/N7bFX41MuAQnIS80bvQT3gX9k1LZzGWQaYRwUHppayzQnywdxdEeJbNB8WDkjYcXO7R8lwVaNVzMP+Xz8uYsZ8/ZN8A7lywBEFKDaxw2JEo3FgWolGx2HgTvNS+nAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864488; c=relaxed/simple;
	bh=MhhBrV8sKb3rN21IWqiOsn226fQpdDw6AuVBTgHxxWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PPEm58AYY/J9C/4oJSX8yp64KdM1A1MGNTcDiJTNRvoCYSkPBOP3f4rGvCLaRoLw6zrMUKJgTMunf6aqLlCin+D2UpJOWhUzq9TUENdhBbqYpUTRqRe8pkTvvMC2RkCONQ3Xajf6dVi/ejqy/ypWbHFd1CJXPDONWqeFVpncD9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TtjvlLGm; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0eZfFMM1jrMWSW9YoVhpzCjLDQ/o95Kui+dfY+7ZNHKKZlZQF9wdTSAfJ6jVrZkf1FXswKG8hTS4XrJygDBJgM4vQtWX4gaNIfPnKs2khu+LGYc4xFzIbKXrQqPK3cJdd1A5V8jkUQEzu/0WVp2q6RMKSIU+8dRR/2lQc3UecOKL+yW5VHJclJbhTVZbes0mjsDr+/ESkDteZGGz0vHYMt3Obciig1nI7RPXu00fA7rO1zKCIiX7ryIqxocIe56d71FGyT3Kc+L57OH09xbZ+N6EhyvGPscM5WNGUud5GEPOT2tefKyRHfk+1hUjJvoglpvZs0mtSq35lBBlKml6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S8O1hiHlQ4m25SuE6tEjrKZ/RCiI+pmncwMyOxQetM=;
 b=SeO5ZCLGvdbCPNb/A7JVPvAoKBQR+MEje5VM5WGnZlBcLOy8EZRGooDI//0P4mBljz4QR3ECCKPvN3deC8k1FGVEXwQLu6V5CjAKOfm5fFWkwonzYzL8vnfYz20awDIlhE6BJ58wvnWF2VN1rK/qi1gcuH81BMg3qGmVddBfnBB0HPpQ8XpZvH5+T4gAt/mL7+0kpvVdVTPeFHbMewpjrzL3HyOr1H4fSATGnqdkoXOduyDVb6pIopHNswr6yCTORdS1UTgEsjjbU6UYtnT0V3qQCcMsXZMqBLVjDg6SiuTnMfBroLFyFR/wzfl092s8UW8bVPRt22uJSMTSwc8bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S8O1hiHlQ4m25SuE6tEjrKZ/RCiI+pmncwMyOxQetM=;
 b=TtjvlLGmpy3u+yC2gCrf1KMi2b4Bh6HfgOso6ZcaGaJ9ymKuhIfG8OZE2dWBkpFbgED68rejYWbigauF+fO3BT5jh8oEzbfnWIi4k/NJogvbTysgV2F36HOzHDliNIZGEQuG+lJrjrFXY6S9M8RnJXkbMn92URU/si6cxGfRXzgEcl35AXDl2GyLv9Ci2E/lSKnq7dcsJPM69ajPdJstLdDmeggLkdaNgxGjye54d2vNRn/TkgVyHbs9BL1Hk5hfNLCZOehCjcZ9sIV4ySLz4E2AVw+WLCB/Fn6oqM9RwVfVTg0LEzJ3pL00uNNZsjw9T/jlj9/orOZwu77LIpJJ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:14:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 23:14:44 +0000
Date: Mon, 19 Jan 2026 19:14:43 -0400
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
Subject: Re: [PATCH RESEND 00/12] mm: add bitmap VMA flag helpers and convert
 all mmap_prepare to use them
Message-ID: <20260119231443.GT1134360@nvidia.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6456cf91-f409-460b-1fec-08de57b08802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tSplX4pOJ8CmO18rSXCqTCkufV0sadsiAhorP8Vb+UsIHmWt8lzctSzYV0CG?=
 =?us-ascii?Q?5UYsfYrg8BvFUCKC3tfnAwdtsS3hveUfnhmAZQ3rqwzAaEXV1Hd/bGBjKxQ0?=
 =?us-ascii?Q?3UPmDHFyQ8gj3/QtCK/5UNz5SBHZhcowyNGnx5cWbyS5A2NvfM/2ILanzMu8?=
 =?us-ascii?Q?6Ey5Zv7GtNYM1z9k7Racn9Njt8bJ8RXAvaP9R6mZmEbNeTEffLZ+da7zAHTr?=
 =?us-ascii?Q?4u0Z+nO67rG4ec8wZh/DvfUPZU7tWuimLC0N3f0/noJdIfoUHUV9QvIr3xW9?=
 =?us-ascii?Q?oiwuENwtN3DPXBtX4O1Ta9/me/5sFubn8L8KTOZv+HoTtVd/KcYH+fPtLc/F?=
 =?us-ascii?Q?4yTU2UncOhSE7AGon97RQMQctIAOaehtRP7k//9zsRJFZOXHqGionhP4TMmE?=
 =?us-ascii?Q?pXZ5f+f78xSu2YOo3tTaLDiPjy2C+ik36c+c9Fd91hcWES9GubrIAVMJnzos?=
 =?us-ascii?Q?kbBVtF6WJQm2raa19BaVS9W2faObyQUyXmy9RLyoMd4DeRgiArBpN/7aOubS?=
 =?us-ascii?Q?cO3AJR6QsyaPLbE1xPR/tiF5lLPP8jvJ8WP6Q2wOeMtdUEktwtg9yCNm+eIO?=
 =?us-ascii?Q?ljCZCdpXBxryqz1gENxKo1K+mGEBgUwaSt+2p/C2c21wJuNE1B+76hFS2Lrv?=
 =?us-ascii?Q?SAdYvoTVARzUCDYgwuMoWIq6FyxdGHZza88w7LLpY7P4uJurgSMFa4LvFiLr?=
 =?us-ascii?Q?3vHkABBbnhELGPg591UF5o3NsXa6cW+OeDpVVQ4QmkrO2oq40UCwQfHY7ihZ?=
 =?us-ascii?Q?yhBliPB2raNgUlTtbp45N8Fp3cf8lJOlYWreyUFfp/GDIfm9ywFhvUCgd6Vd?=
 =?us-ascii?Q?kuL/lgQFwoZj7YSFiXQ4PL+muSmdZWVnhv5Yz3gmxfqNiCvn8pEEn+L6Mt19?=
 =?us-ascii?Q?3mGaDTsgLexaL/79LgiJkiG/lEu31mpdvjQuWwMI6VObMzPNlS2RqHdHh37y?=
 =?us-ascii?Q?YHDYYWOodqFWN5ttfkWsp94RnPivtB9zeXzuVy3w2ctDlG+ihb8R18Cdd14p?=
 =?us-ascii?Q?f+8o+t/wkVmpuiBmOT/m+kNmemNwakvDV2qYwTAfq39f2LGwxVqAvR6OKGtg?=
 =?us-ascii?Q?zxTsT5huRTBsziV6NMBz587f1m4RMqSdKjSF4CiFr3geCtAhZ2zpGTsq4Xe3?=
 =?us-ascii?Q?suEcCXU/l2oFoNg+ROti2gmgcHiYa5obqhDCx6dFbhy6WCZqaS+WKDoXKK6T?=
 =?us-ascii?Q?2qeiU6UHDz857E33ibG0jkktJwTU74F5iKOEPbDqkjy3rDmgwpunr8IL8gkM?=
 =?us-ascii?Q?z67Cic0qHCvJgbju2/JBM2tiC/OP2SKJUnkz1gIPOkZSCMjIdShCfmus8x+j?=
 =?us-ascii?Q?QoPNm4nmBv3HTdfXcx535QFvgXfGvnlKiMO6O9QyZP51rRmnKN8Vpwidneb+?=
 =?us-ascii?Q?fIRWJsHS4ed3wjCmgIMcVpBdNpNyWbiC2AiBF1PWzUOTYMcOB3iZpsyQpoWH?=
 =?us-ascii?Q?pMJpxXWXwI+cV4rtuB7G32ueEK3GPG0zrdq/N9lf9XMAWAVpSMTY5/DeYHrf?=
 =?us-ascii?Q?oTgok96huMQ8CEQOCyJFduDUFGimhw0dA89xQhIQCUjBOmvqbCzCJ69PCNsY?=
 =?us-ascii?Q?8366SGuvwSO6A5j5v0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOHMVlVDrrTvXiIYN2+I5cimEGsEGbRgC3X1N2FgfdirFY2nZ1xkoy7pZdky?=
 =?us-ascii?Q?dgooqNqG9nGppKOMCMZ9jP66PTVGXzJQHbIeouRni72LjDAvPpLy2qDzL3wo?=
 =?us-ascii?Q?uMYXcqKzGntioMUdEmJnfb7KtYk/FLrep6rlV5yZlYdsfXrLZcZsrYJhN0SV?=
 =?us-ascii?Q?EoRluN08AQvBZxbknVPI/o8TK69yFl62QDx0xuHqEK+xr2jkFaoAx4vJXhg0?=
 =?us-ascii?Q?IvCUeTFMYK4PWSr841C5MJh+KLRgBNl5s8qyKrnP3OveODG+RfyKUZVsfqLV?=
 =?us-ascii?Q?s3cneyyctZGObC56r0iUdXCdoJu+oAybeBjjQ1Xn9TVGX+ZilJF8MIV4ZIEF?=
 =?us-ascii?Q?z6MsOAUdMUdEKnA8tki4nqJAw4BOUPuDhTUy8rDr8LeyKCUYJGTpg2XLSn85?=
 =?us-ascii?Q?deX3bBN1z5kjpU4ullUZWHNoN+T3TxPJ2wumVCG/s6JbGvZDfGBTRtJfsMda?=
 =?us-ascii?Q?Scxj0qpyrAjPx0X/iZoUM9XeQLEZCAHvH6CXwAXNtBzVNalhUQMUWtCPhH+1?=
 =?us-ascii?Q?DNl5xaPZSTHE0zNS2/cXwO2T7nDtT3WnG1zzXACP5jcZX8ktMh+lK7zGwAjn?=
 =?us-ascii?Q?MHB2k5H8p6UMTaD3F0jj5DAmlzPqUARKoI4DZhvWRHJWmgGiGRNy+Ehr6JSB?=
 =?us-ascii?Q?T1489eEMKK5kDN/vPjPT3zBGXPSinXJMH18m7Fq5HL18RGLtY43atzuPvAyO?=
 =?us-ascii?Q?/b0MSgloMQY8UtigHEguklCjmbb4Elx81uRQVQcy5/r8XSB8yOWRs8dbm9KL?=
 =?us-ascii?Q?znm+T2lqmWd/Nfv49uGTIo+ieeDCPb+JGXtdtYCGZZsBf5X4hBsxElH/LW5G?=
 =?us-ascii?Q?RI9+uLVYl3d+jKYGRNiZlMthDXkkn5QTmR/6g5MWfAODcQ9dPJ0MLnn5P7J1?=
 =?us-ascii?Q?PUPNXmt9z5GyERkpwSWo4Nc9Kq/znamNgz7epXh4irtZC2JoPZIn+YoCE30N?=
 =?us-ascii?Q?zt/Z8gEdKd1sslOPI/MJOCzLlut9H/b+R7MQrhUZWCwGR5lThNsWCfTKhXz8?=
 =?us-ascii?Q?28YGzY9m9qy3oS/D9NMQ+g9n3PSvxaDXy8lnULlNwqAsv+P96ta3QTb9yPcO?=
 =?us-ascii?Q?EdjCUqd8l5fnhtdmA0wNtch2CGls0pbQBFVjp6NWRfxxXFeZXEtK+3AtACbn?=
 =?us-ascii?Q?25HtRXz7M6f3IP1NvCF5riQV8oCPyBodRMC+zQpfQA7MEiL+Pg1OmcSPUJNk?=
 =?us-ascii?Q?L74SUweakrZf3f33iDeuJUtDGlmWmirlMn6x0baexD2H5FpiUW9w2BhlbyDP?=
 =?us-ascii?Q?PdEJnh8imD/embnx57mCSRQMPdsJjxTJ7eCiwEen086N5XVIKvT/W5wctDxY?=
 =?us-ascii?Q?OlPtWP9yvkH8WGjxiShvzCZa76sByLU6cbh9PQj81Z+ShE4TLFdIigbG/hIH?=
 =?us-ascii?Q?T/GBVAUXm8pXlSfMLS77eJgVzvago8ouxS7n0XMazZhHNiBmJ1kazydjQNPi?=
 =?us-ascii?Q?4BXHNl3T5CatY/zvw+MW66Ice6flpYgysgrTQGT2kHUfmdAUYbALEFI/9YsV?=
 =?us-ascii?Q?Ba+ZL/+VWPBopQNFOcRMlNlAc7tdBa2M+bauVYwuEifm4z0+zp+bhKYU5lNn?=
 =?us-ascii?Q?yHpY2cIdt1jv6E7umHvNBT+Y4zbMu7T3aGifRjMuCq1yPLYNiktnrEtcOKm4?=
 =?us-ascii?Q?sIQCfxi+VPUYv+IYdSbJ12iuQJU5YKI5CfkAh40nB/CAoG5ezJ4qp7VFg03S?=
 =?us-ascii?Q?NcEWjqrEnjlo4gkcecT/YSGgYnLHocknvsDCvcGBs+MeXfYKONwcCbve7Irm?=
 =?us-ascii?Q?lfoEg+cBsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6456cf91-f409-460b-1fec-08de57b08802
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:14:44.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwk2joAm/V7SnpJ0UEnUaOsAV6uczrKchITot2iVGb92xsSkJWrPBZ2oVYFKsVZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On Mon, Jan 19, 2026 at 09:19:02PM +0000, Lorenzo Stoakes wrote:
> We introduced the bitmap VMA type vma_flags_t in the aptly named commit
> 9ea35a25d51b ("mm: introduce VMA flags bitmap type") in order to permit
> future growth in VMA flags and to prevent the asinine requirement that VMA
> flags be available to 64-bit kernels only if they happened to use a bit
> number about 32-bits.
> 
> This is a long-term project as there are very many users of VMA flags
> within the kernel that need to be updated in order to utilise this new
> type.
> 
> In order to further this aim, this series adds a number of helper functions
> to enable ordinary interactions with VMA flags - that is testing, setting
> and clearing them.
> 
> In order to make working with VMA bit numbers less cumbersome this series
> introduces the mk_vma_flags() helper macro which generates a vma_flags_t
> from a variadic parameter list, e.g.:
> 
> 	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> 					 VMA_EXEC_BIT);

I didn't try to check every conversion, but the whole approach looks
nice to me and I think this design is ergonomic!

Jason

