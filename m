Return-Path: <linux-fsdevel+bounces-22699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676391B308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4C6B210BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABB1A38E1;
	Thu, 27 Jun 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ez7rmtiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77D1A2549;
	Thu, 27 Jun 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532514; cv=fail; b=guuEyF6sLLERMW0rOF+2afJ9cUR+qwgGFu2ci+dSdpsczyP8FgLSRYsDukd/ry4Qi2JzT3yr/zYIT+fIQbRHi5rZ1LsQAOBlbgE/iHJ93cApU5P0BGUtoRspC7S6aOrqhOh8oWB5m+0fk7bDhRxM3XmVgkqtkz8zR/aHOnmx9Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532514; c=relaxed/simple;
	bh=9KMOc1ULTi8NsqW/adTosZFxZXkuj/w4SN6kz3hgzfE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=gGXf+4X/tXoCrGfT7DWSXLG3lS9ZN+1my3cNHZHCae/VJWfuwXF2iGmJ9mHl6Vy3fV1DXop3wiIvDLmMUtVSKUD0ZmAZPstkSqxepK+Elayz0sXqwe+X29MesTvycv5FMYjXUR068GsQ1Ff6tyWBUYFO//9MN3funM787BhSMWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ez7rmtiH; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXe8jbM9mEdRe1vsaeTAv87NZruohK0XVpfXfr3RlcUvZiCODccTEyaYhtbM4F0sFmGgm1JkRYY4vIzGbyTBjYhyOcyalcyiyZEdDrfthkVC5wQ3jE2RaQHiwqo2u2D1wCQid4GixA+VyvRGIMs+mWzTrR/UK6aosw+OMh5yx3CPL5ID+N8SAsomKMFy+91qn1aB4rkF6uBQ72olZbGGI7E8ModhjwQhThJvYrE/KUK++7hPsZwm+mmn5mty/zZT1e7eDZgv3LhUEpvsr9+LqPEAIXALoY0ybIRoPc10ENsjsD1ag1IEm2rG1NkORPDjKKc4S39jreH2KIoK7waeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5XVoYwQuDg+GQxyx5siP3T4svWGIJrj+ZagRfnWls4=;
 b=QpcqlQe/ZyLb42yFEWFPalk6bsjulH//9xbp9yXdSilKSvcKJwQKdqeyvMvayNNs4Kz58QeckCW2JuHp4w7laVa/3artbEAnY4s3QZD89Q2dtLlIFceYu65iZmXLnF/Ij1ZG9INQey6jvWwVuQ++2Z0/4pIsflzZiP1ZaKP4JJQxyIOBLzXU29LfRDoLpLm+8QLKoER1MgUba73TQVQckTTUX+pAbtM5w5jLmVG1S18t99gstfs7WumMUUJLMvu27Tjwc4DsvfQAnLAurH/6drPGDLucIF/5EWHWEPgNLKFG4gUP4R8+MtHAHmuHETcN2POPQiUazHvEOrwVrLpf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5XVoYwQuDg+GQxyx5siP3T4svWGIJrj+ZagRfnWls4=;
 b=Ez7rmtiH/nOHT5pwpBHDMDRl/SBlQjbvL7+xjJ14w69SECCk1fRM+0r7QZhgnmHsucQGV6jXUeev1XQaH8/04QKKtW1YNIetZzWgyWj4Awzmn+0uN/matD77T+/6Gc/m1HHg7UoQF36xFjaWfe5evG/W1aJEcK7UL+hZlbBiMvqamHVntPpc6lOW+gXXoJoAK6jEXdXDneZNivFoudtI1RmyyjvugnQBKcKk0uHU3zQfO1WC+2Qlahswod9TCkNw6ijg13OsusCzI0GtrCeirlcfiOKdePQfHMlqlu2FB9PpONrDN6/PH5TxcaCW9bBCOOl4lIl4URU4B9WOIrFVuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.35; Thu, 27 Jun 2024 23:55:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:55:06 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <e626eda568267e1f86d5c30c24bc62474b45f6c3.1719386613.git-series.apopple@nvidia.com>
 <20240627053343.GD14837@lst.de>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, david@fromorbit.com
Subject: Re: [PATCH 04/13] fs/dax: Add dax_page_free callback
Date: Fri, 28 Jun 2024 09:48:24 +1000
In-reply-to: <20240627053343.GD14837@lst.de>
Message-ID: <87h6de54by.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b44b16d-8c7a-44b3-f14a-08dc97048f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPGdZo8TfYwVvMzhdP6QmxPRGi7srD29uFwCixlsojXCdRLKEAteUlXWMpKo?=
 =?us-ascii?Q?ERQ0DQBhJMTLlPpym3G8tAjWf04rEY0+Py5hIVqZDjdEtMG33B8YPB1WUTNe?=
 =?us-ascii?Q?kgOIXn3kTUSLHVZp9z2G0lSZglWNmFC0vsrGemyvxdqImWJlkBWXubM1m3+i?=
 =?us-ascii?Q?Hs69oQnh8ejlyC9fuipM9eUSz/JUqz+onempibaXV/SLe7tqHcsW2tjlK3d+?=
 =?us-ascii?Q?5QQtj3VuxtKlfaNEQkSDIxuUeB8XKsTX7jy4Y5lz+oegqXBGOjB6rssaJe0n?=
 =?us-ascii?Q?Mx213JljFLMvx+5230+BmSWvTgyOWZPzISUnkrMiL9auzQj8WOwmIaFR4h9z?=
 =?us-ascii?Q?SDHgYUgNPBJyXwxVA2do7VfkrU8RCJ8wi0g5Ge6Tc2EAlitqQ1EY2mYatng5?=
 =?us-ascii?Q?vfO/DYklslQ8AaLvmGuLl0AOs8UQdbBIvEs6VhotqEpSc9kc/Hzom444NpTT?=
 =?us-ascii?Q?Uk17E4ymMPIWZ78YPlbNKc2eXOH6JNs01nHRZM4yFpFSJ/w435SeGPFzJ33G?=
 =?us-ascii?Q?BMumsWjPspU+CTZMSkvPVJAoBe16jTwqOKwrKFbrBiD6HInE5sIy2ZNpSDi5?=
 =?us-ascii?Q?DAywerDXxjhK8id7PS4wsSv7ozedmgW+tu+21JlzX1u8WAciCghmJ/ujRsy8?=
 =?us-ascii?Q?vJHYk3Iz0ey7YKRuwHOzE9Vppom8x5I3FSCUhXyOs9YPtybmSK5y1djbOLnL?=
 =?us-ascii?Q?ROYOrDDXdzfJx2JZlR90Y/6dUP57AoOAnTKeutVQpKDauhWvtWetHYZhLtJW?=
 =?us-ascii?Q?VV1nKtbKesyD920rieWJ9SOf9LM3zqMbS9wHmEwUYG0/cy9A1L0RT+MCwmcq?=
 =?us-ascii?Q?mWdlAJlF8vOQiHDcbmFEhzHKUp4Lfu1XcWdHxKIf14a3cNnx2v18U9wDPfuD?=
 =?us-ascii?Q?4OcqAKwGpYt8hUTCmLg3uEOS0PmN+J/d+aYeXE4N0YNQTiEUutqGh6+3NZN9?=
 =?us-ascii?Q?joDbnMIKyqzsiVspWKQtCCBED/QjtnS/7n284P9cXbJB1JdqxjKkAJH6u1OH?=
 =?us-ascii?Q?pKThAT3zSv0BTLS8BaFnSFxQhePLhXakoErQO9s2WrQ+PB6UonT93OQk3XG1?=
 =?us-ascii?Q?L7sRWRWyPCEn77tFg/G+tzRLnihsPrrXhP/rD9h0eXfFJI6Mnhs1UkNxTCkc?=
 =?us-ascii?Q?SgzNfyzj5YUpEKZGvLjxY49gQVt18AT2BPkuREpfhtIj3py4RpM5xMGoNmnp?=
 =?us-ascii?Q?n1TcAz3KpI0baNwrPjJqvelMOM88IvVzKQQ+07sCYZqzIkhkafs1iUspWyIo?=
 =?us-ascii?Q?ZHlkjxc5ij1LlpgCz7N62ILFvZW403T6UEwF60RvVbKyAesn3hshw+kJe1h4?=
 =?us-ascii?Q?2x8XMuEaWQO92iv7ESqFlPwc9Dd+8LgyyFLFU8IPL7NO4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkitERBnPU1pVbMOLz75E/q0I+6Jb3wBSk3hRXD93QNit8SPL/tDG2xlCdxZ?=
 =?us-ascii?Q?4rXtSpcUSCimDfUKLPTZsjF3t9vVlQ2PwG+p9KV8beM9YiExjV2E4XVPNhV1?=
 =?us-ascii?Q?gRMUkQMeg83tq7XhzxFl7s49v4qzqYrhfkdnt0vsND+i9RCicYuJwyc4JbMY?=
 =?us-ascii?Q?2LUeFF/nqm8Y9QA9rJwDTA1QKuJGl1pw8uKH4Xcs9hY/Kv1oREgBsiUyEwSF?=
 =?us-ascii?Q?SZyh/VAZJqDVJ+QHw0BwmL8xgcLGr06AaLomEoETtqlSN848KzTtZMzammUt?=
 =?us-ascii?Q?hWuCtKrB2H+lCn9L8K5MvL3QFNw613jnszfmqfkwV11o4wmrX0xHSU1Zz4aV?=
 =?us-ascii?Q?rNWxxGI9ds6H2ojYikPqsTo56EEdnNnp7lYK7jRlrQhF9UatUzWnYyP0Ehh8?=
 =?us-ascii?Q?Nbn8/N3DYhZag/ngv/0vu8uLjkO5zTud8PiBHQe8j3ef2JgWUCg0G+vuztkN?=
 =?us-ascii?Q?boh4uiEuIzbjjCvwDKyThOW+5ADPetF8nKZYDk02yJ552qmV4ksijbA59+Lk?=
 =?us-ascii?Q?gLZO/116BmNDMBBBHOgBjI7P7U7cNkBBKvboiF3vr/Ry6iFBk/Sz5n6IAgDE?=
 =?us-ascii?Q?54rHOZTksM7njfweGQhWrEyWGIuejg+T8qTrzYC+RzAQYZ9ud0iHCn0bvzTC?=
 =?us-ascii?Q?ZqaF/1npXaMk0cFzedKtaMFSAhu4mulqKhqv+Wtl1VCZkVokuxNFIEDeNEEU?=
 =?us-ascii?Q?0iz2HEbwY4k0gtzzbMmxwE4N8IQgm7WAKP99J/HsM24zEQKls6t2616+bAD+?=
 =?us-ascii?Q?ZLvymMJrfpQwWleWjfywi/nWsjSLnehAcOUni6V2C4cMuLOww1m7rI1gE47o?=
 =?us-ascii?Q?P311zMtj0Uq+atMV6AoWexuJPWNUGVPr1t+aG4AZPfzS4GRCkhKXOARB185S?=
 =?us-ascii?Q?Uo3W3saymTu2YBhJaqXfMpbQtGU+Wf3igKTTsSPoNfyrVIOMU6+RzqcFusdz?=
 =?us-ascii?Q?6Nq3dqlhBScPUGvARkg1/C5E5i1lk/c/QMQofuX+RVhBZB147zik1HiVP+B/?=
 =?us-ascii?Q?AKci3YR4eZey7PWYZecXQuFqzy6xBgMKi5T6GQx8BHmqQqTlOQeU8UogfMyK?=
 =?us-ascii?Q?i2LXjzJFqkfvafaxi5Bxago8EcHj7eJ+kH6qqaPIm5HB/KrlivDjnAk3LvaH?=
 =?us-ascii?Q?XvD2kFg9WdxGQRTikcVcTl6Ydu/QTTWFZgyB0TTZzw3uDVa7d/SuRfWHl+mA?=
 =?us-ascii?Q?Fiuane5u7W2o08oElwBRRxP9DwMurUphw8Qu4EH5tCnXa/Laxj2ZKXcWselW?=
 =?us-ascii?Q?armMdxPE1NHP8o16lb3XSc2d2ESXpyCKZ/lTcp/vDzSbYNiprGN1ccnCK75n?=
 =?us-ascii?Q?OA0MgM1Ewx2fVsP1KXpjrUUwpv9x5CNn4oLJuu0Gw1ZGIAApIy3px6/qbZga?=
 =?us-ascii?Q?1zJVOhuF27djBBsNePcQGnP95Clgs3H3sjDRS8J8PRvPG6QuiCtDTstIgzTw?=
 =?us-ascii?Q?z20TLx7mt4kv0YKxXkxo0ZSjD3AVeG/n52h087c0pNYWRBk2T92swmD7gbvA?=
 =?us-ascii?Q?ujjyV1ulXqBW2oS7n3Jq/ja1qmPN78fEQWQqWXNksUuzlOshgYMb6Mv4S8w1?=
 =?us-ascii?Q?+iFcM+vKpGWL/pxh0SncWia4iwZfsmneHU/RsUWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b44b16d-8c7a-44b3-f14a-08dc97048f7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 23:55:02.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRDrO8BAmSekk8UJnkD7mxe7Gnu0KiIBE7zQZqcDA2rCfQ62abWPR/hEU8Ol3oQlJ8QFPFFhxHfF3WjF/0ahPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070


Christoph Hellwig <hch@lst.de> writes:

> On Thu, Jun 27, 2024 at 10:54:19AM +1000, Alistair Popple wrote:
>> When a fs dax page is freed it has to notify filesystems that the page
>> has been unpinned/unmapped and is free. Currently this involves
>> special code in the page free paths to detect a transition of refcount
>> from 2 to 1 and to call some fs dax specific code.
>> 
>> A future change will require this to happen when the page refcount
>> drops to zero. In this case we can use the existing
>> pgmap->ops->page_free() callback so wire that up for all devices that
>> support FS DAX (nvdimm and virtio).
>
> Given that ->page_ffree is only called from free_zone_device_folio
> and right next to a switch on the the type, can't we just do the
> wake_up_var there without the somewhat confusing indirect call that
> just back in common code without any driver logic?

Longer term I'm hoping we can get rid of that switch on type entirely as
I don't think the whole get/put_dev_pagemap() thing is very useful. Less
indirection is good though so will move the wake_up_var there.

