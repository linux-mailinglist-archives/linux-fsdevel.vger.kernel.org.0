Return-Path: <linux-fsdevel+bounces-42040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF6A3B0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8AE3AA2D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872211C3C1E;
	Wed, 19 Feb 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYTXz3AJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2071C3BF1;
	Wed, 19 Feb 2025 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941557; cv=fail; b=p2SK5JIEz/UgFAF9AVSg7r/+06KmBg/VmnbuMPlOgtkXCJ6w8gVEV78NFjFoLB61UFAhVMYDyNSGHSBvtTDMnCHv7mX8XzIVhuedqybhrAEHB6UY6mCttf8zEj4oEAAwHZjIsdOz5rKQPAgiOpDjZ2qWrXmr6cNNdLDLXAwyCfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941557; c=relaxed/simple;
	bh=yWHLNgtQNlaS61f3/KJ7ivaM/AaJgdKI+ZRPfwp1Vdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6WJu7ktNQLMj3Lm3X2uNQb2W1mNdRKWJ6sxzaOZsQYNAyVrh65aZbgYlbcLni8tiJw0frrOaxEOTveMEwEqoVTvwP+ywujLswaPlXnEzJiiTJH1ZO3sHLBFm94Lkg/dnYhH25DWu6WyaHMqd3WoW2qhlVNUcLuFRog2zpBZeHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYTXz3AJ; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoUVrqn8vVRG+phV/b/Ju7ts2ZGkFEZANTnn9io204sOwNq2I0IMm4e04v7RFKpF1jX20zG5fzhZRMGtwO3QklpAem212E8vUAfHX+tOrvQ2aK1bYLsZGk9wlWeLiMlY8M2rnfdbKox3ajXRRyNIBQQJ+VT2zAUw0mMwSjc4apLoVN4YSqTC0mVUgMmMPHJ2+VPpV5NL25Tv7fzKBm6qWarmaB6QNsmqtB8a0X0kVI9qMARIT5KBFNsYo4R5T/BHGe9qu1e/yVF1abROj4gJdPG/RZ8BBsKlrXZ4pRE8ifzJgfFRbUzJ/Ye/CIECuVTi3A8fxCmycisHFEfWUiiAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kORq89LHormmx8FvzXCjMRaP2CQO/gpnN8I6Y1bsFTg=;
 b=kz73IgxwVzqu5/xyR9Qa1Bk3MMp4kITUo50FB6AyeYFzpOW2/N1zPH/YZDfA0y5lXgsYpZwHXRz5HoExUvmUacFw4PaiMBLYgYOiRfTIvZrpj2f7RbyFC9oYZS0658lbglkQb/uifv5pqHkIFifCzQ0svT4gbzNPWr3IHQm7oKb+QQzAn8dwYrAO0HTkkmhjm4mVQJ8AUzPGKRxhIlu/KTmWVcNg033cGWMDX3jZ+AIDpxgeezc5ndnAffIi1kNsKBECOABOPVmRKyaU7IsMVPR/+5Z1nStKulVO0Hm4XwQEFMP4zOC+GcfZ/Cb0wngbKmDKtYDUeSyzIF4vohyJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kORq89LHormmx8FvzXCjMRaP2CQO/gpnN8I6Y1bsFTg=;
 b=EYTXz3AJSyHLd5Ft26BcmgyAiE4qHbFCs6SKQ3YznJOwCP1k5D1l7YyQdSIGOlhXtVpMUERoJE1uJ3L5+GcaNZrDLd6+zdiNH1UZr2rPgu87qahTROBT8a5+rmqpDpgIJyrBkMwY49gpfs4m1RbAV33QweTKQ6PNtV04sh59MGzZcYIYtbHRrgfGwnJtQQDmFfsyyaiEqilv/3PoPudxUt6AR1qbNeVTrcgB30Xop7B0Sl5wX4LpUmeZQu2KJtr+PQXRvf14EOyPuWvWl3MmohHOSsC5+DobdH+/BsLVn+U9hxxL+RI/vI1AYg0/vYuFAS/BNNUhZ5GkyMfyvwjS2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:54 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 08/12] mm/khugepaged: Remove redundant pmd_devmap() check
Date: Wed, 19 Feb 2025 16:04:52 +1100
Message-ID: <02c0a4d9ea3f0470e2af485296b6ff4f1f4a87e3.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0037.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0e8149-d2a4-464c-7316-08dd50a31653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QiVIWiaVa+B02Az6jjCbmyKxPwE7d6SVEHQf5Fp4AGfqZMxXeEstWm2QllMP?=
 =?us-ascii?Q?Wg/OTMIgcdqFBReVi2vldKzI26ahqBIBHOxquTp1fROvaXmBvE3XYuN1zufW?=
 =?us-ascii?Q?3z+FLOhulNUIxpK60n/5Bm4Qaw6g1dDkf6Dvvdod+31gK1kDjiCUQYkfPGH6?=
 =?us-ascii?Q?6f/EXNcLQY84FfjgQVzZ3nFRNLCjhXD5wxQ3XVLpN0QiNIcCUjOEx/ZJj9gY?=
 =?us-ascii?Q?qY6UXPWhMRiVzHZhC6Qe5BMt1qZJPVto6UzAoYPEaMOu3QURK3Ue1KiSmddy?=
 =?us-ascii?Q?ZKyuxoHsXpjKPWnQaMz74swK5uzqfA3b+mcNj0oFmglGzHYtUqD5VFSPKA+Y?=
 =?us-ascii?Q?bDEiiR/Jd+SQHNYfhMUZz6I0nOvIRfUiCzFV4DTuBcU2gJHY3lRmYwDMDtlo?=
 =?us-ascii?Q?dVzDgsBJR3jfK0+YW58hfMiv1jqxRNhAe7rvR1CI7GeI6U5v1WsqBWn3+tl8?=
 =?us-ascii?Q?8uhGfwhd+W+ldDkQhB7fIfTfs+anSOrWfImY4CkjBctfN8dHT1il1EEL0QDu?=
 =?us-ascii?Q?wqdHLa4e2oqdJt+W1XYs0k5OFkgJmkcTYtpofqjnECHSVqcXE7cQByGLZwe2?=
 =?us-ascii?Q?1bNqltDfQutAG1rzsuXJXpgk2mq+w7n0DPoMwd9UwI2atfKS6dmRcCtJqi+/?=
 =?us-ascii?Q?JGMTBHUrvkD9GScR7/GonmsWpSv4GKQKEWKw7VW8ouS+7tQd7RQhsuz0WtaB?=
 =?us-ascii?Q?BYVAYV+UQCbIIqWIyk43ubVFptLErbi1REC2malmUy8I00HoLrhbdg9e96tu?=
 =?us-ascii?Q?7NPIHbbtwqfvVadXHO52OIAp2NiaQfG0dUDVqOhMuk2mtspuOM8JwzwCk3GJ?=
 =?us-ascii?Q?DpPzFmjREROmqAjCkxwM9zpxpRk9fXeRbEmWQS19Y0aBUKmWuA6IWqKKoxhp?=
 =?us-ascii?Q?4ov8LF0sXe7SJeqvJLriO8S82OfuUTK2zI9P7yGAqx4vvU8JdilXFUR6HiMA?=
 =?us-ascii?Q?kVW8rudMOeof4sKKEkIpNI8H47P5Yinap+51PWDqRS5TQyNO7SZfC/HxhH/c?=
 =?us-ascii?Q?rM0RhwRtstjKG4WG3ZJQ7DHWa2Ur0lfI5dVTA/GnmkwT9whNhwKFBYUlVesc?=
 =?us-ascii?Q?J7wX9F5PjDPnBXlJ+60Sw66qEbnj+FhBOnY1Pz7mVdjeHfY5CBJBaokc0YYh?=
 =?us-ascii?Q?Xge0POPQlepAMCSnStTamqoaIcQOpvnojlhNefMN4oPJjjgNeGvv3S0CDUui?=
 =?us-ascii?Q?bKud5L1qdD2yiUIPt6gmLrtOv9SH9wOkCJy5jQPAQfp9buC7UopR8hd2Z1nv?=
 =?us-ascii?Q?kP0lg6w4yOOpcxjMKRsI3vUhMRB9zq8CA5ub0Oq9JpR5LMDU9k7EBnhGOhTl?=
 =?us-ascii?Q?UpF7JM+dJbhiOs0rHMAc0vUm/J2wil5IntmZEzHnOB65bVfn20Ki1kFp/ZVr?=
 =?us-ascii?Q?FGi7vTRQv2Dv+zJAn/xB4tkaeiSY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wDpHPto+L2/1l7Ryo/5BWpQ+fAbK0AhsxIlpU/kUJKI9Q0nyu4lM4eV7jmc?=
 =?us-ascii?Q?2ioG+DTAX7u+5iFFVa8wdH8GTtBjHr6x0eU5TfGtkfssyW9/ANJUA/JjWBlb?=
 =?us-ascii?Q?3xDB7wWuzmKPnl3yuY9v+8rrBXWqiYa8N5pCbjWFzeA5rnx3HR04WAtCWX/8?=
 =?us-ascii?Q?+lkAL5dfPK00ztuyBuomT9QeLKMKMpIi79r+JOCKnaEh3LOgyPCT/saYxkMB?=
 =?us-ascii?Q?tCf/y/OTzmSVhZXUEqoLYzjVjAgHTn67t+OKmbtUsbu2V0jGRhalaCmd1yZU?=
 =?us-ascii?Q?nBAA6IYRbEgLxwX6jfgv2U2XXuQmIT7Plrx94AeOcG+vUgU7EmeGQaoA5d8l?=
 =?us-ascii?Q?wo1gXuOMalrsIOpdJDMimeVdzFr2blgoJ504Z9lmfX5iuTZ5eAWIN7qJONM+?=
 =?us-ascii?Q?EjD2bkpmFa90rtq6Y+EsJC5tmfdd72sAQ3G1TQF8mEg0gWIgiZ4SmJStXqHB?=
 =?us-ascii?Q?A8lfvi0WW/o3nuGW0O1riv53nJP+zoE3rNZN0JR91WYEll0qkoDo4+CMemQ4?=
 =?us-ascii?Q?WsZWRfdAQtR6NejLsZNFdseGTsgtMB9zXNuLhS8tsIEWRO7acg5asbNlitmr?=
 =?us-ascii?Q?AYZsqldbpBrebp0uIRx2K0v3i/aX2mCZddPjU0lux885Xl1mg0EQi03OQ+D9?=
 =?us-ascii?Q?JhFrDx4gJk/Qzb0u+35UiuMDeDvErjEjWZ9p/5YOYtEXytJ4hWNXKToH8GxJ?=
 =?us-ascii?Q?LoLHRe2OfEje72JiQ70u5O0fap3SEwzJw7k0vnX9MxKNUX13RASnZvssnQjv?=
 =?us-ascii?Q?eP2DGl6a+diDpXi19eBubDx72W8w7isKZeCFwiSHpU5cNAPDncwO492eyMo3?=
 =?us-ascii?Q?FW5b5F6dqjLANJuyb0EZP5FrOa7XRJny3OeOW0HXXsthOyH2N2AADKAF6FSi?=
 =?us-ascii?Q?uB+UajXLoc63KepnSGgMgSZGChs2LlBeeKreZOVqDa+YTwevyT3kU/lksXEX?=
 =?us-ascii?Q?RvXfuHT3t3XGc9NNAMPYJxAZFF4r+YL2DAXxaDLlpMcRyG7E6zwoHv1fi7Hl?=
 =?us-ascii?Q?QYuM3jzNOnFQbIuuC8rXPctue3zQ7zd4PfNsmrIWC4fuK8UcgOQUpQk/maUS?=
 =?us-ascii?Q?HGlhgo3QAfj0xsw7D74GMP2/Fhci+frnxeTfvGpla4wCMfDkb0Bu62ffzdKD?=
 =?us-ascii?Q?5qRRXcfUvYuL6O4okkg+lWUSF9RAiOJNk24GY0cN/fInurS4Ik575SH5+SEM?=
 =?us-ascii?Q?Luc+o7khKpW8FbJoIxppuKFgOEe++TFYzGX4/zNUBRBKwalIllYexPMGhpvy?=
 =?us-ascii?Q?AtoP0qMnh9Wq1oGDNJwOf3ZmuIfS0KLwL8mA+E6Nngimay1+Ip++2S6jK9k4?=
 =?us-ascii?Q?p1rWXxxeIpaTxD7UZTm5/2bKE135qz+HiG7DY6VB1COqc7QpMSabWItdOqUt?=
 =?us-ascii?Q?hqep1Mm/JOHk3K2OPx3Z4LZ/2Z/W1aTvoSERab2Cr2rQ1HutLleDY5kec+0s?=
 =?us-ascii?Q?7m/Uw/NsMO/6HjNjLnWtzDpnDN7ClD/aT0h4XrxMULNfVn2zIp0+YrHOwB/y?=
 =?us-ascii?Q?00622JsyCjPPPgrX0qt7/MuqQmoND2B9W6xh/kzt/hjK8QQn3E331GNp3pxI?=
 =?us-ascii?Q?AoVpdl19Adr2FJtrhj/byO005T3sSZfZNmsBFTc4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e8149-d2a4-464c-7316-08dd50a31653
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:54.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VESlC8xCN8tBAyW8gsi1XokpCSLezodMJv8AfQqpdRQTDHuM3ow2v2JC41GGB5lznKY1uTdNQM3BSJHh4TF+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

The only users of pmd_devmap were device dax and fs dax. The check for
pmd_devmap() in check_pmd_state() is therefore redundant as callers
explicitly check for is_zone_device_page(), so this check can be dropped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/khugepaged.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5f0be13..7eeae33 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -958,8 +958,6 @@ static inline int check_pmd_state(pmd_t *pmd)
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
-- 
git-series 0.9.1

