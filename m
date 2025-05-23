Return-Path: <linux-fsdevel+bounces-49707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090AAC1AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 06:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78EA1BA65DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 04:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD2223DC1;
	Fri, 23 May 2025 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBF0VUAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5C1547F2;
	Fri, 23 May 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975083; cv=fail; b=SaV1fPG0a/CQqR/pHgEzvaGrYT0uz0JYhSpBYF1v9nY3CJOiRVRXWhiA8Omf0WhOk7xg/uGQLLLBlPbfYYnpf4IuVtFeEupjQP23XiPj/X9I2vjDA7Ti0ZjSSG1ZI2tAfBEPe7dw8oyR8o5o/SNoY/t0OV9v8jklba/wDil4LGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975083; c=relaxed/simple;
	bh=A48WyAFyvzcfHO8cSMUslTDN6t5unfNGnHjzHTOfSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G3i/eUrmpZDVpcVKOJt1f4P601KsG/tVh70+qIdOwWfzCg9BYEnQ0S7Sn5TjLguODMqKmabvB6h8Clf6zHc83hvCXeO1gisNwgm0yfNcPkkn1e+5R6/73n7okw8F85Kn7RZxpXuSmT4xX2oJME/qd2QrbKX28Fa4LT2bvAQ9408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBF0VUAW; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB01KowsHBdqZkvVhvjpNsFL4JlPEaPWyIsY9dHNKnkzfAqdh9ZLE6CvNjMGYHiUaFifMNng33ltuLm1Ld1Ux6fl/iJTslzv3TSBwHYt5CHk+NpctGWk4qByndpLhbrTOWme2LfXVD1LHi8eMHBjL8JkievKffGpXBMN40Kf4mAxxi4NXl1WjS4JVR/XGQeBFWmvxdmNtRMnzppJIL+GvL0FGSDoSunfBxsyYMWpixBNK7Tiw/SGjChW0qsqxw9Qc9XFOr+qyA5lsQRn3N6mtlFbYocmwZH3LlCsJrH9GclLwPwG2bKJMzIEtuV/LesBK57DfsBalDXZMlqxozgJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykzWj1HtPID7sAS+Q06t5etL2eFn66b8jPbJ0SlzW4Q=;
 b=BqRvGu8/Qi7WPKuxD1TjzBlirgCWPo7oOirKoU/a6QgLAnSWaW15Ls8Kp+I5qItesHFPZ3S9DkXJ7w7JBOCf9K8iwdT40Mqqg99yrF4IIqriyRHnSB5o+F0dQCL4tpgD2W46o2HjIeGHUxhICOL/GBuW70jpMT+tniih4Gg8WcARjbGNc+ert4pVkJFG+0hPpcUgh+jG5qRLjCPW5Fz02Sebns3xVbwsLNiYTfq8CazBrJmawchWaRDJJgVy7cNDzkDgTnQsSCAUuq8VMEqvbq+Iomzx+RZEOlL19VXtzcxPWZhty2jbU8y8qjzgnt3VFZ88spdJJqKuBzBqwZ0hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykzWj1HtPID7sAS+Q06t5etL2eFn66b8jPbJ0SlzW4Q=;
 b=jBF0VUAW3RToDousDEvrFUp5ppjVC18ZZOHj9Dg3JlAivvV9cd/ZyCIOvUV4zyxW8QZrG9OfLeCJMCiKnnTexgeyAb/amgOBZhTp5xfYUa/SsRE3AD2pWtsoi6a5slnM98ocG7ODf4XBVqlwCbsS2a0YYioz1mNaKG6HW4mv9fNaak3UabD0IMTkxXp1YBSK9b9DPepO+cT2ozUpV92wfZV2kyhVwK99z9bcepeAaBzV788MxoEyG8iFrD+yK2rSYIR3a92YNUM5dqO2lqcZQnI5qEwLk5O4cPwsb/jM5+2nK0rv1JDxXfR13lCmY0tOVh34J9tnxYS8rx7AT1k1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 04:37:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 04:37:57 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	dan.j.williams@intel.com,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Ted Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fs/dax: Fix "don't skip locked entries when scanning entries"
Date: Fri, 23 May 2025 14:37:49 +1000
Message-ID: <20250523043749.1460780-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6599840d-d4c3-45ec-26ab-08dd99b39747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a2pZfMp+f6uMEgX1R21teJ3Ompl8CpB2end/7Gyp4ggM6oTkivH1VGD7tyjr?=
 =?us-ascii?Q?20tvUL+uargperZ09doJ3UyOBDrzNVpL3XBR8ySJfobRC3d+gXpRO3/noJfG?=
 =?us-ascii?Q?tTjMl+SfjXa7aZsG6E6ZWbrvWBppNpcnWWdtBbrU9lp3qrg0A4fK6zT7dJeK?=
 =?us-ascii?Q?fF5Yq22E60RC1Rk5UKWuyuTzcKJiXj7DRmt+0iJIf+3HKjSEUklLgQgN10lv?=
 =?us-ascii?Q?qEkZDGUonTvpcscpYjJb5HB4R1H7ZxbFsgQ5ul2SqVPZbVI6iq084ZKBak3a?=
 =?us-ascii?Q?6JAb+zjVztlucqSDNUYbcD96amuPas1MAbq7QVgNn+jTOaLkDL45ItSAFqf6?=
 =?us-ascii?Q?OFvNN9RHe71rLOraayo48RwBUfeu0241wezBgqS5aOITHhSZkBP+9MGI8QRq?=
 =?us-ascii?Q?1jQqMVLvKUnBmgB1ASsiOGtBGnFMlV7wPcassgAQUTeNw47+AWM/nmDpI+BW?=
 =?us-ascii?Q?YrBtdVAvefTu0wuDnjgMA439wSkxD0i+j/eumYM3K4k6iO7AOm/hrFBy97ca?=
 =?us-ascii?Q?/CsTuHXYg+ocvZizQYU1v2CeKUbdk99rVokAkr0Akc6PpQVZXeQMZGitgLWe?=
 =?us-ascii?Q?iKpqfpmBfdtjbtklbYhdTQgy/19jaQ0iWde6IUnHI4TdMLrpN37FIbzgJgYB?=
 =?us-ascii?Q?PR+t+OSQFkjpmBXNin7i4d0ZQF2FZMw3VZd4zzwTOqlTPXDNkP+HKXo6745b?=
 =?us-ascii?Q?sm12LJmoSF9XpZ6FqBzu7IagTYf9qlEqqOQbt5XEgRkCUdzBwqTwpWKLK3P9?=
 =?us-ascii?Q?213JsTz2oVTEN1NWU6ObBloR+48Yb+OEfZheVfU4E0oaKDOuN3Ug+1447IZF?=
 =?us-ascii?Q?Rl2XFblrbfviQXzU9+H6CcmnuctkYw30iM4ul3/EOe5h/yGxF++Fo7UnLGvS?=
 =?us-ascii?Q?t2VjkCxR5jgal6H681ZjuDt8XeGtnkIJ1SKCx2qlohky62tir10drt7NQAsS?=
 =?us-ascii?Q?i1Du5phwNfEBcGgPAwPBuMyWkqHsrHWCsZcrbddJF1eSs3i+VQDdNxM99v7M?=
 =?us-ascii?Q?nImCct9FpgrxuJukb+H06E0aJzgYzLyFIjWGOdhmJrd6FGkfyf26m1H/uJq2?=
 =?us-ascii?Q?0hQwXIrwZZ4cV4R308sj3A3Okqru4Okl+A+P9Ly1tOjtzKw+u68sMOaipZoq?=
 =?us-ascii?Q?sVVvlrqseOk6Smf34DvJAEwa0u3akZcdt1V76+UeGGbhgsyWnVoRe1VIXy64?=
 =?us-ascii?Q?2znNxfySfHP9TB0726hZYtwq+A1MLT6em44WdqWf/W4wa/LZNMgRwQ8Wm5aR?=
 =?us-ascii?Q?XSKUPjmFhNmD3vLHfHvk12LuiRWQqkGrj9kzBR4hi9N8SrIN0Pz7Eh7wmPU/?=
 =?us-ascii?Q?A8f36M+7YX8bY/MkHeVTa11IBA4/4NsL+cdclSRaAO0U87C8oo+Nht3vzyH9?=
 =?us-ascii?Q?DayGAbIO3hhwCM/YQ7ePqwFHBTkTVRKtmnBErj4sTOKkaNgQTt2cEwoLU0ep?=
 =?us-ascii?Q?2jGAi6w6cfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6AmqcFoVRtoA3bqXR05oZh0MtGJkv5cXOYoQkhadSVl0gHXkoIuHKx89Vos?=
 =?us-ascii?Q?uB44QQy3bxkQ2jj/BP1NvzpM8kYY8crALDjqCqGrF77tZcP9jFGd4x/dSG2m?=
 =?us-ascii?Q?SZzr6s+nEpaj5JBM+8oC0cLq+vlevs2r0lr/CAelJ4e+1FdKvGWtL5KcTS5j?=
 =?us-ascii?Q?M9I9gXtFUn/DcTlphHXFsmqytg+C03+HtifKKGGXUfjFWJ8YiOKGEIrHL8c6?=
 =?us-ascii?Q?hI5JCD2/W0ZtFB98F5CDFuvMNHSlBShICbbESGoDJJ3e2hnUrTNVWEbettsO?=
 =?us-ascii?Q?q1LBqG+KtYCSnpqj5ifFD6ftBlq1/97ZXbmG4li5Y1+OFS/adUySu09R62eO?=
 =?us-ascii?Q?ObNPYR8SMXqW6ps9YD6meXrrehKkJPbc59sizYikT9+ap0IkGuO+C3v+QdOq?=
 =?us-ascii?Q?e0EysG/wXCkLUGnp/QToK7rd5Jeoh7aLGFQXwPf4aINyItMoXT2NQj2pVccy?=
 =?us-ascii?Q?frvm651q+XHCDhLF5UchcC7QUtlaHE3+MCBAqJSA4AsWuHcQv/IhacCYRlLv?=
 =?us-ascii?Q?iXgN/wTOFOWybYDut0Gn1nVf6rsnujGyTIcSLwIoWrXV6e2ERgdgHYuMCoJ/?=
 =?us-ascii?Q?MNT6FTH2ljgYSeSRvZnFH6elL+pks0BaOdIvZ70YnoJcuTWoAe7z33ZRl+9q?=
 =?us-ascii?Q?PtpcwO4/QnUCh6bLPaIIRzR0B06i9NefkBzDDqEku0PIwVVGyC3I9kFpnses?=
 =?us-ascii?Q?V1UIefY8YQfSEipy1N31bBJLwDxIiUA2XznbfI7MfglUoyWiBhF5fQsX8Y0/?=
 =?us-ascii?Q?/sE9UiDpvv9C3IQJZMvMUZNMjtGaPkIq/cj3K+n4vSY3FWcFHfOCsH7Z3mJl?=
 =?us-ascii?Q?5wYHTjLv9C2fFiAepIFaE6aAhVtCdS1vOoLvOVp7YB4enXDgAH+r8+bY5jbS?=
 =?us-ascii?Q?wGJwbwBp2snHxw/tkGi7afeGvDRt2dPXQGhkFdhGTflX6NeweNXpBfL7Ct0b?=
 =?us-ascii?Q?7lEv6fNxpF3qRF22YQ837/ZrwtPMPCMSSoxR7+g9r0IRZqvQcF3gcQcrYN/a?=
 =?us-ascii?Q?HxtugyMdNiWtLTpxYHUYzKuEfWQIPaq4trclqusmduxth7lRTlnOVDfaatqo?=
 =?us-ascii?Q?04l6BiUEuXcfABNPeRLV7R4889t9NqZCQn3Q8Sv9zBbEd47DYxYELe+114Cx?=
 =?us-ascii?Q?GmgqtrcNYSNrlJqgy4Lah1Bmr8d9N7CQq/8hYpsR/CGPCElABaUDz4y3bGBh?=
 =?us-ascii?Q?ABIfgyV3tlv2215RjgELSiPzL3uCMOHoTj4y8nU2MC1DSVGPObxmGWyzVbdd?=
 =?us-ascii?Q?rmTt5hS47Y8ii7RPeAtaxBw8lFByW79DlJEvsoAc6WzoNziFTqhSz6e4V+WP?=
 =?us-ascii?Q?sTbSwVqpN9B7fskx/QwEhU86SYEoeLJ53PAgTQvrWysCNzGmO61MMQuKzEDJ?=
 =?us-ascii?Q?FvQa58YAts9ExooXWUrTvl9SF70kSbG1VDJBJFW0qxXIwNL/0/TA2yHn7cSA?=
 =?us-ascii?Q?1tVNLgWaqLFfzSQKv4AVxMvcvpiKnDfNGHfqgOlzHjdDLLf7unnmWnP7LYyv?=
 =?us-ascii?Q?uLfQHG03pn7DZhnz6JbdV6MCoC3ySDHAuOR9s1o3KZbVe9A8aY5HdM+84Iye?=
 =?us-ascii?Q?zTQeCkjPDk0vjQ46BN2qfakVCioPoO3J0GIa4nuZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6599840d-d4c3-45ec-26ab-08dd99b39747
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 04:37:57.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGdW4RJhFYe4wRwlnY2zPcidt48q1xHog1GsMS296yxn81rx5mQmeCOUakvz04TjRmZqS2Doj1GUw8CdGRiQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

Commit 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning
entries") introduced a new function, wait_entry_unlocked_exclusive(),
which waits for the current entry to become unlocked without advancing
the XArray iterator state.

Waiting for the entry to become unlocked requires dropping the XArray
lock. This requires calling xas_pause() prior to dropping the lock
which leaves the xas in a suitable state for the next iteration. However
this has the side-effect of advancing the xas state to the next index.
Normally this isn't an issue because xas_for_each() contains code to
detect this state and thus avoid advancing the index a second time on
the next loop iteration.

However both callers of and wait_entry_unlocked_exclusive() itself
subsequently use the xas state to reload the entry. As xas_pause()
updated the state to the next index this will cause the current entry
which is being waited on to be skipped. This caused the following
warning to fire intermittently when running xftest generic/068 on an XFS
filesystem with FS DAX enabled:

[   35.067397] ------------[ cut here ]------------
[   35.068229] WARNING: CPU: 21 PID: 1640 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0xd8/0x1e0
[   35.069717] Modules linked in: nd_pmem dax_pmem nd_btt nd_e820 libnvdimm
[   35.071006] CPU: 21 UID: 0 PID: 1640 Comm: fstest Not tainted 6.15.0-rc7+ #77 PREEMPT(voluntary)
[   35.072613] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/204
[   35.074845] RIP: 0010:truncate_folio_batch_exceptionals+0xd8/0x1e0
[   35.075962] Code: a1 00 00 00 f6 47 0d 20 0f 84 97 00 00 00 4c 63 e8 41 39 c4 7f 0b eb 61 49 83 c5 01 45 39 ec 7e 58 42 f68
[   35.079522] RSP: 0018:ffffb04e426c7850 EFLAGS: 00010202
[   35.080359] RAX: 0000000000000000 RBX: ffff9d21e3481908 RCX: ffffb04e426c77f4
[   35.081477] RDX: ffffb04e426c79e8 RSI: ffffb04e426c79e0 RDI: ffff9d21e34816e8
[   35.082590] RBP: ffffb04e426c79e0 R08: 0000000000000001 R09: 0000000000000003
[   35.083733] R10: 0000000000000000 R11: 822b53c0f7a49868 R12: 000000000000001f
[   35.084850] R13: 0000000000000000 R14: ffffb04e426c78e8 R15: fffffffffffffffe
[   35.085953] FS:  00007f9134c87740(0000) GS:ffff9d22abba0000(0000) knlGS:0000000000000000
[   35.087346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.088244] CR2: 00007f9134c86000 CR3: 000000040afff000 CR4: 00000000000006f0
[   35.089354] Call Trace:
[   35.089749]  <TASK>
[   35.090168]  truncate_inode_pages_range+0xfc/0x4d0
[   35.091078]  truncate_pagecache+0x47/0x60
[   35.091735]  xfs_setattr_size+0xc7/0x3e0
[   35.092648]  xfs_vn_setattr+0x1ea/0x270
[   35.093437]  notify_change+0x1f4/0x510
[   35.094219]  ? do_truncate+0x97/0xe0
[   35.094879]  do_truncate+0x97/0xe0
[   35.095640]  path_openat+0xabd/0xca0
[   35.096278]  do_filp_open+0xd7/0x190
[   35.096860]  do_sys_openat2+0x8a/0xe0
[   35.097459]  __x64_sys_openat+0x6d/0xa0
[   35.098076]  do_syscall_64+0xbb/0x1d0
[   35.098647]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   35.099444] RIP: 0033:0x7f9134d81fc1
[   35.100033] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 2a 26 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff5
[   35.102993] RSP: 002b:00007ffcd41e0d10 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
[   35.104263] RAX: ffffffffffffffda RBX: 0000000000000242 RCX: 00007f9134d81fc1
[   35.105452] RDX: 0000000000000242 RSI: 00007ffcd41e1200 RDI: 00000000ffffff9c
[   35.106663] RBP: 00007ffcd41e1200 R08: 0000000000000000 R09: 0000000000000064
[   35.107923] R10: 00000000000001a4 R11: 0000000000000202 R12: 0000000000000066
[   35.109112] R13: 0000000000100000 R14: 0000000000100000 R15: 0000000000000400
[   35.110357]  </TASK>
[   35.110769] irq event stamp: 8415587
[   35.111486] hardirqs last  enabled at (8415599): [<ffffffff8d74b562>] __up_console_sem+0x52/0x60
[   35.113067] hardirqs last disabled at (8415610): [<ffffffff8d74b547>] __up_console_sem+0x37/0x60
[   35.114575] softirqs last  enabled at (8415300): [<ffffffff8d6ac625>] handle_softirqs+0x315/0x3f0
[   35.115933] softirqs last disabled at (8415291): [<ffffffff8d6ac811>] __irq_exit_rcu+0xa1/0xc0
[   35.117316] ---[ end trace 0000000000000000 ]---

Fix this by using xas_reset() instead, which is equivalent in
implementation to xas_pause() but does not advance the XArray state.

Fixes: 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning entries")
Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ted Ts'o <tytso@mit.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>

---

Hi Andrew,

Apologies for finding this so late in the cycle. This is a very
intermittent issue for me, and it seems it was only exposed by a recent
upgrade to my test machine/setup. The user visible impact is the same
as for the original commit this fixes. That is possible file data
corruption if a device has a FS DAX page pinned for DMA.

So in other words it means my original fix was not 100% effective.
The issue that commit fixed has existed for a long time without being
reported, so not sure if this is worth trying to get into v6.15 or not.

Either way I figured it would be best to send this ASAP, which means I
am still waiting for a complete xfstest run to complete (although the
failing test does now pass cleanly).
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 676303419e9e..f8d8b1afd232 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -257,7 +257,7 @@ static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
 		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 		prepare_to_wait_exclusive(wq, &ewait.wait,
 					TASK_UNINTERRUPTIBLE);
-		xas_pause(xas);
+		xas_reset(xas);
 		xas_unlock_irq(xas);
 		schedule();
 		finish_wait(wq, &ewait.wait);
-- 
2.47.2


