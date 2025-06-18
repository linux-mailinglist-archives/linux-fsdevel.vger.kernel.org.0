Return-Path: <linux-fsdevel+bounces-52097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B12ADF63E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571C23B60C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA192F547D;
	Wed, 18 Jun 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rtJ2qiM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0B1F4192;
	Wed, 18 Jun 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272667; cv=fail; b=EI0cAM2xpJuv/pHHvg2lrbjXe101hggfCmDjSDxLFstVh0u6nsiJ84LrSqsrD54V3UCtkVHDDvwt0t3xTBPmEOoZ53qWrcLqwRHwECZ2DfDSWTiwQkg8sAFLuXcBx+ZMeeZMc2apZ9w1Ek94VskXqzBpkoqlGC8edA/5CpvB1Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272667; c=relaxed/simple;
	bh=LtgqMycyugA7sSHd5141qbiP5niY4NdHtrfQK1Szwcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZahFZCFcRIZdzHV1IIyI/oXPg3QYPBfF5TfaR7JbgdkspgwCfnuKgFo63oHldyQw2MbKQr8kPYS9iATMI2PFOQ1FoRFe4uOPCpuDe9TGE4u+o85WSUA3QfnTkUhRlZMocbgd0JHW8NQkv18yMswHLp6fxnGDYaIK+dFUTX7P6Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rtJ2qiM6; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=centWeMLBF44Dmnmm6t/P92WJWfAWn0ZgGxcjqKwdCY9AAAxYrNV/tgg5ozrr/Xo0ahJNS5ZDqKz+JRXEZdbEt4HpwlsZdA/E81ZnRMeNYFgBkqZwyeE06GSJiZYSA4eFBUNY607HoLXZtxa3A7KV3PE23y/RV/8RX+kchlwTs0df2fM4p5XgZItNeNCVq4uTVXNlaQwxWNx9jA/a2YET8AGAGlDN2fCDyhAp8U0g/830oy6P5Fww0wbcb4yNzpGpDZ8QGWcZcn+/hrQL4g9trDZvAAykTEynPArCkNlzev8qvYn7r0avQFTHJ0kO/hp30pChnKIBX0XiahUataU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vGUW2uBgxyfZmq1sFb299abiCcBRHPUxpVaRLf1o5k=;
 b=pLQVu5FcrnoxR7mNgy5oSHPvRqhbd0SpsXoq0i4XeEMJTLEOvesun5RWyiJTtZPRwa+qiWqMCw8Qt+3ERkFFmS4D3Yk+3j6pfgNUynQWfnyNJInstZQosTb5NoExcuddJ2X7I0+tDnxe+2pAY8GgqyIKq2sh0+waiykIt4ID6lMcIL1E6InuhsER4jb5RZZXZQvwOCQTdxMxHmGxoHucHffWmgtQvOHLcisQWUk10YCEAV3dh8zCOeREMGK845/NGMb9YfRBwqj/5P8zVGTHzgD4A57dDnpbgkVf84TJHbd1spT41ZcRyV8/QCTpb8d8aHDOjCghFUo58RwD1nAgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vGUW2uBgxyfZmq1sFb299abiCcBRHPUxpVaRLf1o5k=;
 b=rtJ2qiM6yFI884WoYKhV5Z3508HOep0eyLNBC+GMtLZxsyaA6AcDBQHsN75a7+R4zMGXkCkwpDC3UmzR7iEXHFh5SGrhXr/q9RzfD/Tc6VC5WC25xqUnLFWj/xaiWJu2KbIfPDBWmIyqXwdKrUeIfUHIhoHuTYuypiGFylPsINfNJQMDx2NGP7KUlUnjHUx2SlItmKRfazOkiKtkRU5u4Iqc9Vet5HNbZxSFFCUiFxJT8PQ+YEFMR049YnsX/wodbHm0ss4I9ee+EWhgG87qEtetzJljX1YxQAKcfNEf0Ni4fRSgYAjhH+1U9VRKOGwpykncW4pfCb8FPKb4OOWa0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 18:51:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:51:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 05/29] mm/balloon_compaction: make PageOffline sticky
Date: Wed, 18 Jun 2025 14:50:57 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <D114CF56-016B-4140-97A0-42163727EB6C@nvidia.com>
In-Reply-To: <20250618174014.1168640-6-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-6-david@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:52f::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6ddea3-1d28-4177-f087-08ddae99125b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+99lzdZP6NFgkEPcQxwOQy5K0egjh//V90RG9dgiFPM47QBR5Wx2vEWTLY2?=
 =?us-ascii?Q?v+4dmDo5pad7X1bVOwleAZUbPbpF9SeIop0aiwknevSVaXgyWM9PMYVh9hl7?=
 =?us-ascii?Q?tCPzuOD/xo88lKl+cYIbX/dSQPXQDJ2G4jKNXzRc0MIDX6Jq1FuhAmMLwsXx?=
 =?us-ascii?Q?xvf9Gi6PjSsU7A8jQzb3dPrI+hL4rkJkZjXi4m8rH74iXHk/0xQWADsrl1rZ?=
 =?us-ascii?Q?dE4kHc9evvTt0taDLDeWzLBNEerveRkdMY+IQX2Riti2vA3K47ukkIqa/ms7?=
 =?us-ascii?Q?WQX58TyOIBDM7Wm865lUIxUmBghNQY6JamHTPRnn+N9XsMqimUcFPdouRRZs?=
 =?us-ascii?Q?sLvCxG+A7RPdLBVVnAOE1qn+rToQLiutgb4xHgjnGxkjG7NNwMlrOMO4XQ4t?=
 =?us-ascii?Q?dazjmMEe9yslLjFk6zC7WIe6/wOleqGrc+u+pf9SVzUiCGndk6G5H6Ho5bPW?=
 =?us-ascii?Q?qb2i0qurl+Gw4hr2dR54NKd+OuS8JHCS8rCUS1gL1ASdbwe4YRl3RAItqzB/?=
 =?us-ascii?Q?PB9jqaNoGu2AccqiCPhTBApqMqJFX0Y9c0Js+Kc8GJjERLYC3Usupx2z4DoS?=
 =?us-ascii?Q?492Z32GIFY+ZJCp21h2fIcup+m+7z/D+oVUCZeW3IzHQFZ5Fl0ZnKfbq9qIZ?=
 =?us-ascii?Q?U5FIUvkxNGK3Db0NFVReiV/707wW/PlTT/tk0uf7HkBvUZyOpkBYw7WdtV1J?=
 =?us-ascii?Q?RbRqvYZimGb7O4Z+OgYx8nxakSe+XQ/ABXowgqHnLwf2pjOo+ZPWN//N4oDy?=
 =?us-ascii?Q?QPFMLYfJC8Q5VbGb/j8Y4XDbCMhHsmetULa/MZ/vHTD/JkxXrjCn6y03IZSh?=
 =?us-ascii?Q?njbG1fng85tyChxzC9fGGMKf74y11qWODZR/QlR3Va270/DjUMe7oXfeg6hQ?=
 =?us-ascii?Q?6dpjBByXblV/I7nLqMIE0HuYq5OvdjUs36g994febPd8XVL3HG5BpNRMtPU6?=
 =?us-ascii?Q?93ndvn7G5/9hzKQtGOlOXWZs84CdDRerdA49qLOaB+of37b1CnhF7AfMe+EH?=
 =?us-ascii?Q?Wd5w61FjThbKWatZ4GyARZWBH/QHysdrR5OIznDlZYyvY2XFqU5wKN626J7q?=
 =?us-ascii?Q?2g4XuBbddfz+BAd710/OJGwUzchKfYXbawkfBg8jfrGphWtSzkcBJPceUnp4?=
 =?us-ascii?Q?3J/+3gNBFrrfwInveZwq2+wHUYHEKFjFVwpvhdLARw955bfVUgLGAZhmOal3?=
 =?us-ascii?Q?FU5rQIbk7QZQjaIifYwXgRJOLKqAADUcZBgry+uM9DGhR5fspnRbWIvHpw27?=
 =?us-ascii?Q?3EP27yfNHu+ncg/LNk5IlbTUzqHeOCJf33ZsPeB1tEjVWruBZof6hl8V64Ov?=
 =?us-ascii?Q?N0hqlpv92ND/5ZeVnWmSJxXAUIJsPPHwPlbOIohesEJOJWF1yTfegs90xRJN?=
 =?us-ascii?Q?B2Vf2Mo12ElcLUeyZ5GRG+XielCOqi7Yd02OZIsrR2vSgpdbnh13XdJ3bKVj?=
 =?us-ascii?Q?Oqs1en4dDhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0K5y14K4aYvJsEA5gtPNR2AMaB2fb9O7KdHTztwGjsPPnuMl6KOwK6kWzeu8?=
 =?us-ascii?Q?nbI+uKBCyHEfS3HWBBI2WrJNA7d68M6S1DCstBtQ0O2OPcpHIja6EJaAGrLl?=
 =?us-ascii?Q?FsuSviYWa0JL1X5CiYN1Tj1+2szfZbDx6Bkk7z8MA3yOosivS6Askvq0WpNu?=
 =?us-ascii?Q?syfeWWWwoFANHWSaRdy/M/r/luBe0NTfb8ag4d/adVo8C4Vwc0A7Ko85Wj+z?=
 =?us-ascii?Q?0wxxfGBmArL5IjsMUXoMpzCYRodDoAQgs1+ifgIP0VzFiND4fhs7/BMoMyYv?=
 =?us-ascii?Q?AAyS1f+tlPv0zFnBVtEYlYnBgoi0iUtIxiU/M7/+PkrIuYAgf4g0kM8z7fu/?=
 =?us-ascii?Q?D6y+CweX5dBWCy7v/xXUSuzDkgXqJfHv8vuOQjiWSWjhhrAj31ECFllq1cYI?=
 =?us-ascii?Q?oXOWXh+Q0MQ4v7LtILYt30qqyULFNoGjTkaMJsuBAFWjrj7UjaXyYfeMQH/5?=
 =?us-ascii?Q?iTw6SxMOTYrg0W7a6krbGvFQvDklhCGNj3vWgsOTv092cZh1JntvBPz97j48?=
 =?us-ascii?Q?4dZzqyIgbKwDwEMMhBSv/ceptyk8BioPrVqGAD9kXu/Rvbk1oj5nWzL4FZw4?=
 =?us-ascii?Q?pqv0mGoPoCiuL6Z9OfQAkPhgdIxiX/VZXt0nUe+PdfkpvzZeeqixjayqhhZe?=
 =?us-ascii?Q?WRP9Ma6zicBN6OZH37qgJiKQxlAeSSNFusm4bly8oA6QNSMCAweAz7YNwMDW?=
 =?us-ascii?Q?zE68G/nBqFpWNSEOLsYYMy06qlYDFSiwzuxlODyV3jwX7eyV006bML7kdD20?=
 =?us-ascii?Q?ArYuJhEDkxAYaBGMo0YAj8HDQzdZ6zFjmDQM12ircwjS/K6W+kjjgU0UHkQc?=
 =?us-ascii?Q?aF2iKU0Bi7oQwBrMUxe3IMMu1x4pcHDfkecvxKMQldXRIP9F1QVBgYvSyreP?=
 =?us-ascii?Q?13uLTWaJoQxGKp4IMljtRAmLnL8R7ViEFM+vjhXe/hjfl6fbubVJ9bNND390?=
 =?us-ascii?Q?nGCyXqKX7ps9OVMGd257DM3am6ijp2w5aL5GePEgBWQ4Ul1lIW5YV/Rh8r3+?=
 =?us-ascii?Q?A5LZ8WjfX77wUrfcuiR5c+VUALn/yKVagANHX4Z1SRaWzJIjV7IaqoR9GpW5?=
 =?us-ascii?Q?ZUqS/pr0WjOAQevrAG/cdHFcSv9PNWRMjrp3xPB/+NIQWycLpgftYJTMtbEx?=
 =?us-ascii?Q?+yCT5pIPfOKtRTOeaEbBmUCYq0uzB1oCsRJDTOhD5hcGp5Z4flJR7g4aoTmr?=
 =?us-ascii?Q?jBIoiL1sULlu8SjbWY10tLup0gJK3A0kstnagFE4rENj3eayXmGHSEs1OQSJ?=
 =?us-ascii?Q?Y+t0p+T9eyHYB5V2DSmWvx37qHOSo5Ck+zqDl8Lb9ecL/cUuZVwpAxQzD65Z?=
 =?us-ascii?Q?9l4F/j+qjwzAhIJHjxyS93RnpbEHYQr33N01t4FgQ/RQFNx7Yz3FvHRcVM5K?=
 =?us-ascii?Q?qInLSyKJDhsOYSf6BEkc+f+21ixgNYCqNvEmjc04Ju5K9Y4rspkf+L9mk1lb?=
 =?us-ascii?Q?qrOM38mAxNaUV1fnlPaw3ycBR/2Ez0Ay+XAhSsxEl9+HTYEhxcvcUUHBZQgB?=
 =?us-ascii?Q?E0NNv0xxuN2fczTwOzbmxpQDzDPeOl6RCg8JlyQOsrfUOkUtNo/Sh81kNQ3+?=
 =?us-ascii?Q?nAQbzja2iExqzI5eIMiB6JD2uqCLJSsD4ojzlEKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ddea3-1d28-4177-f087-08ddae99125b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:51:02.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIojKEGgXDyNWnQO8tLWWFW2X5aWNuN9LQOyzcJNRstLe3QvBlruGMQf4xHSXTDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let the buddy handle clearing the type.

The below might be more precise? Since page type is cleared
before the page reaches buddy code.

Let the free page routine handle clearing the type.

>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/balloon_compaction.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon=
_compaction.h
> index b9f19da37b089..bfc6e50bd004b 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct pag=
e *page)
>  		__ClearPageMovable(page);
>  		set_page_private(page, 0);
>  	}
> -	__ClearPageOffline(page);
> +	/* PageOffline is sticky until the page is freed to the buddy. */
>  }
>
>  /*
> -- =

> 2.49.0

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

