Return-Path: <linux-fsdevel+bounces-22565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C4919C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5B2284AA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F981AAC4;
	Thu, 27 Jun 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VS8XlZaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C6FC6;
	Thu, 27 Jun 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449698; cv=fail; b=r7/SPcfYz5vq0XfN6oee2l8SDVBY+eXWmHEhdGYpG5FrkxLiU5m2pBaVrlCnbdGj92+azUF3P2iyFHAks2hIVgb1tvPwUQdLVXFDQ58QeT2KFH1IzsHN0R4NI9cwX+pJEtDXdJ3gui0W7otVkT2X8j36Zs47DOSqaamRop9bWKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449698; c=relaxed/simple;
	bh=yRxDZ6fr1cX2nMt3Ynph/cAhrXXy2Mxm2ZTUB5nLWIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cUsTK/NXyu4j8zMCLKL5j/4SW/4RArR6vMNkA9Acwi8MbzgLy9QvsHoQVuPVsiJXdRh4heG7iXT15RRn3OT8I5z02hrHVi29ltZt66jwLn7/HX74rHdh3shdF5M8cnoLYICmQuO1XoSZsLdaaGYoikQ3rrbXBowCBjUO23279oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VS8XlZaS; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPDfYzPAFZO4u5U0fZDyPG9SM0ws2UCCHvf5790JCbuCEBgWBvlAaVYcdXPiPxgH/fuZkUMtZLU7wIScmXIKMCgC/1H4wblnLmXMjLIzfG9cQqpVjulK91m85bFvwfsccw9iHNkxVf5vdqFkFIyPNq5Hg6ycV/42FSr30cMhQWzVkKp+x7TbDgSLJMWfZ71pok61y3w2rQJ1ek8bazZ4JuiRxrx+x9sxGpgZzPHk7O6zevkJBFV12RAUCiCeFJLL30CyCp5l/9EoDfyrI4wPW8HM8kvGy7XbpMPPRNiILlOZk8hcu/Y9/EqyU1p3eyILvEW2fsScphhWGlUyEsbnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkUV5xCCQA5m1br9rTXYMXBe6uTUnQXYw2g5A0ZnCWs=;
 b=UHZtML0E7xPH8r4oApQzPKP8F9JSWROAeCUk+Uze6UjBS510khjCgNL/+PDJdFekjFEZtWqpyj05+7NvTuEMD58FEEh4bTeNsV+OmJEKdd+kd41A4RXDT1hrC41pugEDoXEEM8CZCs4eNr2dBiOy0A+vkS5EjBWGov7UOM0WAvDLI+7aAqA6pn5/AJWMB/LdXeyi29QKIueg0jJzCu8+fh81XTJN05nKNF01oisptrJwk4Ej5Bavf27aFpGAJSZ6NfgR4lvdn94UCIEi9AkzzwpUkfcZCrZ0srao/iKf4IYL0jt7/ZR8lc7lFGW62egssA+UBsVW0uXXTv+BMlRYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkUV5xCCQA5m1br9rTXYMXBe6uTUnQXYw2g5A0ZnCWs=;
 b=VS8XlZaSL4vliXrE93EJBTfkYq47yLhn4gs5eXtHKXZFH1jTJTKBDlkAE4sKSRP0s1UyWD60ysH9GCHx/ieA5kRuEvObXIlS+a0+cwb0KvHe+weZptUlLRReOZ2bo0gncJGecK8mbQ56hLiy5+bS/u6STrDt26Q0ovbVsR5uCMVa/8av13DMgI/oAn7ciKpgzNGGmgq202TzW1N/sKgAs3zYRS7RC8pEIHgl+WyRfbvkEBAo0LJNu4xMfELZoiUAMciuPtGDbU4fCs9B+BkXN1ndxbNvjDfGhbLSZvNE7NUNLCvErTVXt/s1Xakvw+zgYUJNvQzuhJM7V69kPXf8rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:54:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:54:50 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 03/13] fs/dax: Refactor wait for dax idle page
Date: Thu, 27 Jun 2024 10:54:18 +1000
Message-ID: <cdbf5489af735e0ad95beab6b4b13d3a2f75745f.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0185.ausprd01.prod.outlook.com
 (2603:10c6:10:52::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: e5359390-95cb-49cf-39eb-08dc9643bfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7cprG3ZHO/n8TBIFj+nmCoFPsYgpW525x6KFdp7aXP1Baxi5Pws2RO++/9nK?=
 =?us-ascii?Q?jb2um6s3JuWGJ6yjhoUp8o3uKjXpT2XOoCMGjiacO1kJ+am7OqjNTNtZxRWc?=
 =?us-ascii?Q?RAz4IMjQYioXDGuPIpUy7hzBUU5VJLb3FMoFWYEpbQWNtDGwLWdXel62gvv7?=
 =?us-ascii?Q?AU7JbEYVIZJlw9uhJCyh4CPriRcUB6Ylgf8g782n2gsdvM13CM03EPmF4C6D?=
 =?us-ascii?Q?TpLS5Wd5o+ooYVVOyh2idaIajD196+sP3VmQZZ8TGfAhQtyWkDqHF39ZWisg?=
 =?us-ascii?Q?uw0wiu16ejTGXicOdTQK1jzU1tSgKK/Axlagj5FbCzFY71tW+U4W58l8l3TR?=
 =?us-ascii?Q?FpsMYe6LYzc7/+rDfC9cUgqX7tpk2lWhEThfPAN/oBTiz3AS+I+F0k5DYODN?=
 =?us-ascii?Q?zCmXhY58+5nTbA5n288CONrKfisNewBNf/7S79i5yqTduOFs9940972pQm5y?=
 =?us-ascii?Q?GlpcvhdfaCJxYQJ1iErQEKh1pwhg4WTmTT8DQenSPzpTiyV8+m/bKNb+wmxP?=
 =?us-ascii?Q?rIDTKrWKjmmDyMeGfiHKhf2fB6OURnmNSpfsrIARbxQLJpf78jVEQFa4hPTr?=
 =?us-ascii?Q?AvJaWhsZxG+yZdN/Wt3BEMSkNlQWpftwFxgD2w+UToiycWLRmJBR9vsVPgkS?=
 =?us-ascii?Q?GglKVPtiYhunGOGEOEUn13aAiFQVt9sxpp4pYypEGYPV9MyU9cZ7RDWeUc7M?=
 =?us-ascii?Q?WjGU7x4E3wxe9pTLZ2OOetL/Ezrdb6H+N3M2DZZhIZ61VtuhMhnKDRx89Whl?=
 =?us-ascii?Q?Cfje16SiyzEbi/hJLEiQZRa2F1r9jC5SqKyL81I7y+QC1EQlCTOVwgNQLnE9?=
 =?us-ascii?Q?0smN45Zo927Amy9PuQM//xbAH8k9zyTYqcJ3CCxbsVdATu6Sbr9ElKcN1zE3?=
 =?us-ascii?Q?Cg82aZD0f+wjAqvQ3cWmo/o/fqHUO62yOUIFnAsrQcFXgqjGpAA8Ac/JdHtq?=
 =?us-ascii?Q?7brg7T3EoGa5cSKfW0+uJnjUGWoTF5kCFBelLCOZ9Tm00pbOZswlk94pB+G1?=
 =?us-ascii?Q?Ic55+nQbU+vgikwkAPoBXD8i5u/yLuN1JFGFTWXC5wFgBQIDAKq4h+7IFkvH?=
 =?us-ascii?Q?6AkcQXCt96XkHsAbAi/cZrfPlTwqD4C38Ktvt1ZGIVUl0iqS7k2vCKC4GFAf?=
 =?us-ascii?Q?1YA+7OBWszfQjisGvbuBcuZeYfzCBxKpm85AIVMKenkJLtZm6Z5hsQ1NxY0C?=
 =?us-ascii?Q?7li+sJZ+TXc7WYDQ9xZzJ2qjE0Z75CfbCcFkHSdSqw8osvpb1E0ZSy9LnR7/?=
 =?us-ascii?Q?NaxVnCizswLyVMmgv9CD8DkeRx+Y5qqu0YSW7dr29187dy/LO9eq/Y1kMBQi?=
 =?us-ascii?Q?g/wfCNlN4HbuPV3ACBnFy0Tz6w6KTo3FVL/Fl07IJBsXKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F659aibZ3vZcoGSv009Kqz79YlJ4kJnGrHfjaZZ6IkUBtSE7tfdpEQ4FcecO?=
 =?us-ascii?Q?BuNVY8r5OsLqlsEMqThN/gkUhqccxVwIUPuJQMIKkDdHAka99M+JmH0Q22mX?=
 =?us-ascii?Q?ykwPmXZyUWHOCZuvESAtvqTdqj6eJq5BN2PFtMRGsxlr0JblqRFgF3NaWUBF?=
 =?us-ascii?Q?RGihKClroHNu74gL0hsg6d9s7+DgSRc9qlLZb3cJ/39gXg2rYWQ2hFryGHOw?=
 =?us-ascii?Q?VlyXaE6z9FY1EREZOPDfTOnnFm+vGO/AZnhayUl/Teoy10yBTD3Bhwt2VGA3?=
 =?us-ascii?Q?o4FTLCoO1JPT6uhhYejNocVoNjxWKVKeIsaVxVHwAD1gQOs1tdVcU0yiOFNi?=
 =?us-ascii?Q?o1inaLYjxeKIKn3H+wkx4TJT8yfXG2zKRNeTc3pU5pAGr7gJ7RgBDHKT5U9V?=
 =?us-ascii?Q?HvBMIAgIFKwdK8moEw+X+CgeW47uyUjCzssrB+BH6qnHoCC5rNv8x+oqZFGj?=
 =?us-ascii?Q?WEiG0U6vPP1laWsmQxvkKko7HX2pwZ8ZyodljTg5AL6GGN1ZYfEum6PhxP9w?=
 =?us-ascii?Q?Cd6YuhfFWRsWo19hKfTb8XLAw7+fob0W8kTeUlLQxyW3Bc+1DH+xv8YtZLsB?=
 =?us-ascii?Q?FgHZnf+samNDEoorPUPuMVdcTOQaBlDzA0lObtpnP3gkz+3jPMmeJJYZQjwz?=
 =?us-ascii?Q?bHByyG/h/HTPtg52OpjW2fCDxPGFs/KLjfGLPrRSW9SSLsacQOaxFAVTNvHe?=
 =?us-ascii?Q?QMef/564GXt2FoN1MEVTSbYFeRVmmCoMqr7eiXX1atFHncCA2NEglX5cUQD1?=
 =?us-ascii?Q?Bgg6UYsG12UGaygBy+n8LoAJ1V/gmiPuoWOy3LGK1bJP15WAIJki/uk3KyYc?=
 =?us-ascii?Q?jbiCEkS/f/RW2sbzJOaidANR2exiyBGBT4mt1Qi/tPI9rLPdSyGzkR+9DzPe?=
 =?us-ascii?Q?Hm+Ziw2up6lILdfBo060iU9n+HGm8lezw0nlfOZf46NWgp5hhUO9k28fHD+n?=
 =?us-ascii?Q?Tk5SsYw7sahZ66BWiPEPJqH3kkIwn0J1RvoOfQF4TMnUisz6dIebngXoYEKu?=
 =?us-ascii?Q?egQMJxGeTF8grTFAJuZeY+zg8bxqdy4/gLj+96YckT/0gSStuDwRBXCm9+iO?=
 =?us-ascii?Q?SzxHmMWF/GcToviVD8DvgY2Y/NzoHgtzEhbe+XMg/HyXKYUj5uFde9TCy6aM?=
 =?us-ascii?Q?zgh4RtEuY2kaXE5Jc7d7PtRNCIPCSoAzzRuqf/LqvykZbSfX3VN5WVmWSMJC?=
 =?us-ascii?Q?IAiaY7yXtxxefRJ46FW53lsuaZmTSWt973MsT1mCTN8IMJWmhBrcwXe9ksIp?=
 =?us-ascii?Q?EbXjRFxCltpqe1zzyMFJ/5yk3SBsDHLlFtBerSXhG/85GhbmNzhfeYJT57Co?=
 =?us-ascii?Q?9Mks3IKtliTD31WOd+5z5GHk8yQZ03Bv8ihtmwZRrwEF2kGewZ6SeaE/xob9?=
 =?us-ascii?Q?8qKTFVuhiaDrxJWJ9e1Uk+4WvUfOMAvzSJo58B58Ao/lGc2qfB+xjvI47Lnc?=
 =?us-ascii?Q?MlJfKQiLeYm4z9OZAP4/hv47uZpl6UqnN7eRCHrUJcYjFoOtbtF+V1ZRYc32?=
 =?us-ascii?Q?eIzuIyjYiHGOw/6N/og0oK8v/TZo3DdKXeHdZAu7fg3j52Qe72NLALIAXo25?=
 =?us-ascii?Q?U43k74dKsOmPoE12DI68bkwkoQIrBy5fnXFlH2bN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5359390-95cb-49cf-39eb-08dc9643bfa7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:54:50.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F52wrDVx8N1dKAJsJ1pHfPmD9Tg2c1chNjqp+yzOoQI82P4JSm5DaMh/9rVfkMe2875tmXJ1obHbVT06Og9bog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c     | 5 +----
 fs/fuse/dax.c       | 4 +---
 fs/xfs/xfs_inode.c  | 4 +---
 include/linux/dax.h | 8 ++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9cc..4737450 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3844,10 +3844,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d..da50595 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f36091e..b5742aa 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4243,9 +4243,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e332..773dfc4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -213,6 +213,14 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1

