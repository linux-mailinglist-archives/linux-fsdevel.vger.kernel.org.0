Return-Path: <linux-fsdevel+bounces-48940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571EAB6638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFDE19E6A90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9E220698;
	Wed, 14 May 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V6Vp7VFd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qRp4j2hy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BD20C031;
	Wed, 14 May 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212065; cv=fail; b=sc76Fpbp95iuCyvc7jmrAAISfRmyOSchQj90TPpyF4uKBXyyFjqwXWVahsDNGnOKdYQU86ic7hU3UZ7Uq1GYZpXXDtHTN3Ouceh2C/N/QE0Q/m2fA1SJYOPR3GCkSpFTruZpF4b0Hb93Gc+bRuqaJ0f4Xg8VcEDyljtrGsw79NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212065; c=relaxed/simple;
	bh=SfqzjuB4wKOk2R92KhIQg0bTwETEf25g+TUFMll2F60=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WhLneGzfoZUh+NeI82K0C+8nQNgy+hsgtFcv5I+O8/TPAnEzfVytXnNKN8z5S0tZ5zEwQOawjy/ceukJZssvfgrYOI3M+Gb3G2G25IsrwU0pdvwu7eVQEag8YJesXddIgXqa/S3UMDRuAg9zJVKFCwevJFwLyEf8oTOwkkGxIkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V6Vp7VFd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qRp4j2hy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fvmf028074;
	Wed, 14 May 2025 08:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=34JgdvlG47zWY9Kc
	4tgRNPLQZGrgVL7IbQEZWfTvvRA=; b=V6Vp7VFdSAH1Yc4t+I1Yn7y4dKZU3bqy
	V+6U4+GxXjTnN2bd4pq+yRCbwv0tH3TwG1phnSToLUOC0pUav/T6yIZSewr994og
	ElUYlSCQ0g5WnaAADPKQU0guQ0pGZYh5cZ6Fo4nZpD8XQhN53HsiVpPHYStX/Hhh
	lyy4x6HYsE78ZgvPpa0NHPKo0Mqc6sSTiHsC6zq/XllfelSpNtsFhQE4+N6VS8qT
	goWw/ZFuaTj5qTfgpH/3IUjy2Wb6jF+jUDPuuh35jvmxbFy8CB+TnSQmYAT0yAYL
	ZSoCan70kiXICf7huhNnCHvXDiSGz0jjNQBLyF8imFW0Zl5Cs+ZzjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmh24u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:40:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7iTIH008953;
	Wed, 14 May 2025 08:40:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc6wcmyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIwE0sgYta72BeZP3UIqabcOUp5wK+lDW8pnHO4c/hgHrDoe+mjpeggulUuJfGZmGh+YxuEGCuq2pcLKPKbNMwfb5gjmg57l8jrFCgzzcuzrbe2+Y34G/PDoOk3nB/ABEt9hZDAkEyPmsY08P+UL/OEuMiiJhCUhWy1DPXAeeNMUqAkGsQ3hNAEtd344KwnFjVuqG8r5NldGTviBV/i/TAe7DXkQi08xWsMs19R6o9svfsJiGua/emgH/XsTPtRNszVldz5O8PMUwK1Lp9ho73J33UujapLhJBQl2ZqYS3cVt8PyEo6bfEX8/zs1+j0+cOeh+6SnCw1/jt3hG+6+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34JgdvlG47zWY9Kc4tgRNPLQZGrgVL7IbQEZWfTvvRA=;
 b=JEEEIjnGmFqfoAOlWuKPWT41RMcCakWAgOHWPUzrpufuOsRf8xeFJdW1yQ+JVwHLQOHBISeFcB9e6bkHV4gYIuGbMJnsZSN+Fj4llpJ2IiEX6TpcloEs7diKugmiS+4tCHdSY5civR53g5u3tdiFspeMjSmc79ReRpN0yRl2D0sH5anaqVz675KlAeBr65W7G3zS9hyGq3MMF/HD/ysEjcW1mW4LF+qHAQ4phhAnyMeICi7E1iL8HLmO+UZLySp339HJFSXR0VY9tjgFWhrsx9JEP5LDCqXD3opXapsk1UTR5qPBtQbL0HzT+6SCJ3uBXkWvkDf+I8FDGtHicBNCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34JgdvlG47zWY9Kc4tgRNPLQZGrgVL7IbQEZWfTvvRA=;
 b=qRp4j2hypXkzU8RLZgSq9SyUaBMF9tkNkWHEYHGkFo1liAr5bbDYOnlzxbdfgg/SEi4rL6RtRWZoHjp8SO3wqpCKpetTmsxp/noLJ/VPuet0BJii9VyCBqVXo/U41wdlezZcRt9g+k30fBEgm0SXR3hJRDad25I1guHgEuTzSqU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 08:40:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 08:40:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Date: Wed, 14 May 2025 09:40:24 +0100
Message-ID: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e2dd2a-2c4b-4dc6-9c4b-08dd92c30198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6mqpAuUyTkvKrJVI2ULl8Y+Sbdoe6Gg4kHBynsbnsVEzksLqqsQAk94ZvkM?=
 =?us-ascii?Q?ypV+yNsDbUxiqfH6uLcTnV2NTj0sZwqF+f3viIzeAzKlnFtkJWQUH8TdBzlB?=
 =?us-ascii?Q?atg3bIbgIWoQD1keCxc7QR6JfprQ8bZ0sKodNbehIg/Rlwd8cpEVM7bvl+qC?=
 =?us-ascii?Q?5YA+P8sy00E4+XZZr0jjVQMagpE99XMyNl/imT9o9wsGJ6b0tqMHC6wb4Al7?=
 =?us-ascii?Q?L2qKT+DwtI9UjQktaA/8DNOOHbEIz/7gEcuL80NzpD8tRJrgpN6elL8jdPeM?=
 =?us-ascii?Q?FxV9ITIQM8eyMdb2HHg/eZFpNWGPFEDsDccAkAqzXctnFQfqaPB4h6lqjcSK?=
 =?us-ascii?Q?q+mwhqZr+X8DrOGJIDQsddnuSkQKE2IyMoIeV/dT8n7hyvW1QjwDZsdsDKcg?=
 =?us-ascii?Q?6Q0TqTcIf7rUnJyPEZ+27Jd0PIYUXMZ6Z7ptTGELjzS5HIRewuQ9NsKYjSa0?=
 =?us-ascii?Q?aFvPh+T7jX3WtGE7DRfTD7VyLtlgMqu41KSJq/mbsFA1Ink4flhVKZ71Hgl9?=
 =?us-ascii?Q?m4T+vh4wu+GgvEWr0w4sKFFzBNvZBnEfKe7eHN0diJFLGdcoT/rBSqc/2PRT?=
 =?us-ascii?Q?Ht7RywIZQwbOPonTfV2hurc8VTd++79OsjXmuD5zO3t5bILfakWQig/MnUCU?=
 =?us-ascii?Q?RV+H+hQWhzs5ghWrJ3KcU/g8e2VV+UFlaqGSk+CE76/tD8omWKT02m2JmIZK?=
 =?us-ascii?Q?dI5r3jKqUAjIjZ9sM8WY/cJZoJJlrvbH+z+PDrCfWeRUOtuBeBvsrvkjALPM?=
 =?us-ascii?Q?KbfRjU213k0rUV/llfpmqsznSPOeBJ8xJLPqeM2wbe00vH+VzHLR9F9FZN3/?=
 =?us-ascii?Q?XbxgEWN3GLtVnL2Wsg9A6gfaORnGwoF0oxRV65/JxGcoiotadJCuCvomrp84?=
 =?us-ascii?Q?ltfeCqwlbg2isU6yCtUfUDLmkSVDAEt4YEsaGdMUrT1X82tvnrcxL8Lmh97K?=
 =?us-ascii?Q?aZUvoDsIAb19eSzvaGVGoqoPdInb/1KW8gCq1Who+cBvZsylN9J2qj+cfFmV?=
 =?us-ascii?Q?FSHE4CkRnl/+1J4yo/MKtCXNThd2FI7FMN8tPXOmKEr/J5U+VPxupxkSlvsU?=
 =?us-ascii?Q?3bx0hH5+gvayKaZ3IzmYgmqU/CUvg7O4bXrp+epi4y6t4zwbCAdha9aNG+Sj?=
 =?us-ascii?Q?BrTC8egdgmSra+xfe3UOaZ4DXS8ut0szSHvVyATuWr9A14ZcHtQUdJUiadxd?=
 =?us-ascii?Q?vSe6qYBu1SLIANHdy0emD9WlcHDCL5VI+8J3g7dIAutB8MOSkQzwRXNMBHj9?=
 =?us-ascii?Q?MR6VUZnN0dweEOsp1eHQllbCmMlq/O1UP47J4kWMdJw6Gu3iSD2GUn5+9WZJ?=
 =?us-ascii?Q?DCZIFZkjwTy2rapuG0fkSjvcCMPWA5P1CI/Exs+7TFEiA0rkWOZ13zje4u4Q?=
 =?us-ascii?Q?dPAzh59SSI8vGKEsKQEN8X9O9JI/86Xd+SPcgV5t81Y8q6gANrsNQIA30U1f?=
 =?us-ascii?Q?X3oL1Dg0AH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/0rRKORNHbzZLba8kBU2tCDL+se99AWXQJeTjjhElIYS/gn+YZXio3CztLR?=
 =?us-ascii?Q?VSB8uzTbkoN2m+EGN9735O8Rwq4b5oVfY6sop+lTbdeM3c3KruQueel5RBiH?=
 =?us-ascii?Q?IzDFgLnAKHxJqB6MGPxiXWxls5naPbB7E/9sSxnHsL7yZ6zJEj4Fcpf7XoEO?=
 =?us-ascii?Q?ZASF21/W1TIIm6n8hY2QFIvkP5QA9ZPc5TqUlxg/yGDsUtiH7jxi12h/gPnc?=
 =?us-ascii?Q?R7JDE/lXxHvEe73SRgb1e4HOji3bYGIlNI+eF93mJUmAPMnxd07jx1cRHsh9?=
 =?us-ascii?Q?TUJXzRgVI3AFGpnooNbre8y06aKzrxaPGFJG6rZojZFmNuol/i+KmTHL13eA?=
 =?us-ascii?Q?IBQSZpjD+3M3uS6TW0F51KKmMIrWtvfCgUpdPbQtXPPhDsEUzdHkSj3g5jAe?=
 =?us-ascii?Q?7ZhvjblwU218B/AgLyXuWBdVTjCmIAc2QWZkpLK+9gvFPPQh7slbYjP11rGS?=
 =?us-ascii?Q?XHhELlw73bA5kwCx5JmHk7ZUpdC4P2dWacUj9bwtJUZgpwAILaGnHIxlDjlN?=
 =?us-ascii?Q?VccQ2qkzz2cf7cdg+1z/KkdVgna3iUVDIsR/WDwCr8c5vjpfVl0wv812dgFu?=
 =?us-ascii?Q?fACqNbPwRwjRJrtgZpgMUwG29zEfUJQWki5URoRf9PIKXqOZ+WrGOTXYty/Y?=
 =?us-ascii?Q?6+kv+ig3Oe4nY2icvUMzuJHwHpRPTgtuBbZELKUhW5MWNKiivphe+hmqam/V?=
 =?us-ascii?Q?1z12pE/8SKWtnUtskoB/dvEqUV3O5DHfEVHrGctohhIeDVLi7xT0yaibEqfH?=
 =?us-ascii?Q?1IxjgHRqiCHXIsctUyVn8Y+zQR6visknYfZfsHw73VCN04kB8Dyhrev5hdC2?=
 =?us-ascii?Q?Ag8fmnb0IdMLAVCzKX/00P+Tjzb4G6kPcX9Z72Iybur54gPTvpSktrGG74S8?=
 =?us-ascii?Q?+WvkA/cnB39pCI888SUxqGpIX/w40VjpJnVs69pjYP+6fe4+73BAFbSgI7Qh?=
 =?us-ascii?Q?jccz25QfdVnxxY0ZJBBLTDiEr74w9WFubgRCeE+HDoZBf8cjKXwzWnREYi6W?=
 =?us-ascii?Q?0Jgsf0kxuxRzJxRbo38RNHU/eh9AASNwiIRaGlJyReZi3WUd4eiZXChZJd2M?=
 =?us-ascii?Q?kfzkNtVNDBwbrUjzIGWnGdDtqHNSV1UF3Hkw23FqYA+woiDeLAqUDk+TMfH5?=
 =?us-ascii?Q?KY4A3wTs6iCjLZmFecrYTcUwBx9Db7YxhfiiLFNEh4O8hDEteSfV9r6WsScS?=
 =?us-ascii?Q?5p9iQjgxohz0P4gxT/gkxU4XZedlJjaa5ZRg7VJKnaLIfnzVv/ABa0UqebqF?=
 =?us-ascii?Q?JFUPc+AMWAvLdHCl2iBywL8/Ig4wibS8cpNkRHdhLVMih9OYCdCp8S9g/C00?=
 =?us-ascii?Q?mc2uWlU6UZxTCaTmusEF5tpYdk7wwuvopMcy9ByXrQyiIpX8FGaz1m+M5QEc?=
 =?us-ascii?Q?ztAcchHMWN7PmRLBYPqT+xsPJvoXtwIDn3e82UGfoTgnGaDzDb/nkgRs6FL1?=
 =?us-ascii?Q?3z3OlX88topXePWADSRFxarUMyWAP8EPyqMpzN2wBsAHyr7mJC/gjX2Biy97?=
 =?us-ascii?Q?WG+IQl8PP1YzI08Z5eY2Yh7FDtbZ99oTes4ozXAF7RPt9HC4gkCfrA+aT35N?=
 =?us-ascii?Q?op3nEGUdm2dkaS3Sbz/Vpbri6DL84EATN07OKixShW6vm9YxWSKfoRN4I29T?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U+vmEUWDyXoSrK9gSpzqfYjZNlW1zNHjvIBWBclwhuu90EgEnBMsB3CFCZRX7CnKzRl9mWypkdRlukekJodPFNKn3+4aC0ZmxTqXlRNZYEyJOCE13xAj4PIfoUbf2cI8tkhCzLtQfNQk0NfkQlIPp8ZFNBl6QFp+Iy7v5ANw/+6KhVSoG+2p/VsI1LSwUGjcEWWqiFdW9bP8OADVxFIAZmYGBHhJidzBfxcgE03Evoik5cla2J3NDAPu9wEUgo0YpLeOe9IUOkVu9h9m9OJIT+/sVfBvAdYCBaJIWsB8mYxrWO4+pwgVTFdN9gEnlhGdLa58oeCuDf8a27TFqnBvdhajMjvrnmPa2W65MlkANV6HrBu7zoY2HPxzoCPoQIPxtdh2jhR0Lw6YGKMARlWYIq8t8LlExEsPaKUH5e2lCwvGF9fKFGV/wOgc+TQ+JnDhIy2DSn9KzxDvSNCB4Boh+BGwUJ0/Lk8F+Mc715Gmm0VBN1H4rvvinPvE086Lsy4kHx868KKhjoYxXy3P19UREjCTIYN8McYVSPIT6UQPXDuT4RqurIHmjZGf0+F9E8VMVfL64pnWzeFBpZRk//IhoU8k+hQtJOx+l6z10NAz6ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e2dd2a-2c4b-4dc6-9c4b-08dd92c30198
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:40:40.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaD8TRgdrHbqNeOHe/QU79OiE0UPgDErcS5QT3iimqc2i5cJBEGs6Unf4q5FfgvuteVgIbHnrUgincqyde162x9XePT3a0ZTotmqnNEhUiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140074
X-Proofpoint-ORIG-GUID: S4dOZE6gyVe3GZXnwI5M8zELq9LTlbpd
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=6824570b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=Umg1wV9Wv9Q-D6IK934A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA3NCBTYWx0ZWRfX1fwYPL39p9WR 2kfe55sI1/ed2auxXH1nEBgJE4DXrlyy/bIF6NSE5CtiC1JMo26Zze9PaD8cX49FlyTSLHrkDZB gw1X7XboQnNv1lX/FGN3N9YBfc2IVdng6Vlvwa+BIQskT8Bt7bqeU5CxQSgek+5jNpbXbpO6gud
 t3CNcirASSLZvc76FlbAWTBW+IrLF/lciCUL6V5xfj/dnm3Qg23ymWinyto+SqHkeGClJ0HrXU+ X/wHgfxZrCZhQAoAAh6e81sbFCpxVhICT/t9O8JXflIfD80IV9d67QDq+uBVzK8SSNrlDWCrPtH ij2mMBZidKJWJjtaU5M32FOi8F3fPDcqocr0iJHxGF5sAQpUPsaSr38L7MFFusQRK1EipVsfxFl
 DhdxrbyB3LSetL/UmFp0mojFwRXZU8D6a0M6dHrfoaDMELpHw4aJ+kvs2gkzR3Hr35Vpqbn6
X-Proofpoint-GUID: S4dOZE6gyVe3GZXnwI5M8zELq9LTlbpd

Having encountered a trinity report in linux-next (Linked in the 'Closes'
tag) it appears that there are legitimate situations where a file-backed
mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
is set, at which point do_mmap() should simply error out with -ENODEV.

Since previously we did not warn in this scenario and it appears we rely
upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
case where both are set, which is absolutely incorrect and must be
addressed and thus always requires a warning.

If further work is required to chase down precisely what is causing this,
then we can later restore this, but it makes no sense to hold up this
series to do so, as this is existing and apparently expected behaviour.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---

Andrew -

Since this series is in mm-stable we should take this fix there asap (and
certainly get it to -next to fix any further error reports). I didn't know
whether it was best for it to be a fix-patch or not, so have sent
separately so you can best determine what to do with it :)

Thanks, Lorenzo

 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2721a1ff13d..09c8495dacdb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2248,7 +2248,7 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
 	/* Hooks are mutually exclusive. */
 	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
 		return false;
-	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
+	if (!has_mmap && !has_mmap_prepare)
 		return false;

 	return true;
--
2.49.0

