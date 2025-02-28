Return-Path: <linux-fsdevel+bounces-42804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF41A48F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2156B3B819C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21061A3141;
	Fri, 28 Feb 2025 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EfZ0OHr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D707195B37;
	Fri, 28 Feb 2025 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713492; cv=fail; b=GEON51RCvVa67r5yXWP3Kh/p+rnEYWCvF9sqjZGdYAo3UcNhd4mSGHBqGPeOKIw2Bpytma+1qsE3YncA3qt9eh7aqmA8S68k7iV5xebV2PHlMJgkiPCxlsGkJKrvNYXfuX83Ca3rLsd+d88h0cEdlJBUaxGEOmR2kCArzpNPytI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713492; c=relaxed/simple;
	bh=5/d30KwRzi0/d8XqveRbEC2GpdHbnWrTnk2QdYNj2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WzDtnKED2WtCL6nfOpSyO+kec2pqZ3fm++okCably+qYrGyaXOfcJiAEZNsjyaqbftQweOl6Ee/pw6cXEhA4P2zoDutPUQ9ssh5fCvYrxFTXog1W7PQZ1y3R8s2JokrqbN6jgRds8sM/od6zyVR38+dvZA/1KnTVbd1iac+/Hpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EfZ0OHr2; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axZRmNhuh0GMFUL2TdBtHhgGOXIc3fy0GjhtemjNp76fi43CvqjRrkWUnK4ih+GTrcYFdqP2xyEi8/5N1njyhJdT3v0oMwjKKfzoOJpuGAclCVTvN4gjaDqpGvU3KkfaJeTFtYPHJc3F1AiMGW7C+YNU2NYD29LJibFbAdbSOyDo0/wx4c6bDlLBiJcCyxtf4BCz/Y+15yPXVg0LflLERVhM9Xdjof7VKI3dTCN+efRsBGClXOGq8IswLe+L6nXTy7DpFf4FYt+hbnAoyGgACxY/+GOGweRzDNMQpegqSkpB9xTf4Kl1MWgLA88ffI9a+RRcf1hJ3sqnTK41uZaiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fpOKX5mt97+LmuzK0U3LyecTQPT8dlAshklE5pRhO4=;
 b=A0Mo+qyFZR5m04ZRiPvVy1C0ASZReL2BsWTkW1/sWn0zyFAIvfjPaaDwMqaZSJjTffsnE5woj6JdpNld4I5nw4ObW+Rjgdqs3dYP5wUrETVWnEN0Cj2KoTIs+O1Uw6gzHx6s7lLRJtns6adTEXFXrAQcxwkWVlGAky7k95eqHYBAaMs4+SQLrFFPADiC8B6H8rMlVOt9pnE8k+qpbVx6I/Mxrc2+Fuxpz2k65aXtqCMGghR0OP8/XSp1NrH6Q2EdKhwk33NW7w8lscHzSlY8a1vjgI7+esQqzBBoyIFywL823xqw781106decJzI4oeTVRSBOgkiuau7rmj281aULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fpOKX5mt97+LmuzK0U3LyecTQPT8dlAshklE5pRhO4=;
 b=EfZ0OHr2XvQ3rSDEGxlkwv93I/lEFrqYSSGLCkEBYi9U8UUvhdnXYNphUqsxSofh0mM1dQSkrn69WpLnT2WZje+7xH6Je2g6k7+1RE8WfEivZF7VJY0X8AQ9utlWZmdHYkZZAe2AZ/z9O25h8IeaLallqgm/UpT6HEcocfXfmmM9xyTqIkpeVLQNIqCEYnzs8DjsNLZkT2GONSS2wXIYiwzmBJ0fTn7VPbfqP2tE/oD4kTdPzaD87f7HzkmyYpByFs+Lj24fJWclQNy0d0RoR+gNaMBLzRZvxauLnw2pHEVI/QsPsT+cS2tl9SRh7ESqX0dkxS2Eu6O+0ToOrZrZeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:27 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
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
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v9 01/20] fuse: Fix dax truncate/punch_hole fault path
Date: Fri, 28 Feb 2025 14:30:56 +1100
Message-ID: <f09a34b6c40032022e4ddee6fadb7cc676f08867.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:2::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 462f3f6b-e815-423d-893c-08dd57a86241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uaxkybciKBx9pL+Z7k2S3EyQ+dnds/q1XVVjKieTZfXEG1w9p5XjxDCSbunZ?=
 =?us-ascii?Q?Zx8q+MdHfVeNzMQoPafrTtf3wm/31FLEAkz1oNhfcR84BUF79nSNOXQ+CE41?=
 =?us-ascii?Q?dhl2RKiGSF58YdKdwUj9vOH9FUUXkCjPOjh/98uW8RMY/j3MH/GxFGnizl+e?=
 =?us-ascii?Q?82+q3vAxVuGNf8u/ItsS7cjwxQudPXR36ATHf58z+ym0tQ2ZgWtbXKgYuil7?=
 =?us-ascii?Q?oV2svjStx4RVa58+jb2Zinl62nKpjI75tb76afgUQ7AFGcTB0EpIvJW7DO59?=
 =?us-ascii?Q?NW5gVkaVQHM2YKHKFCLelOcNfiZq8bSoGIRHW4rKyI54fLqLSrD5kWyjfWGE?=
 =?us-ascii?Q?SI+Zd5ODINQ4Z5OG2/UuF3tci6jxLrJo9rj6ALftU5JZ6HeGFmtI6/8/TX28?=
 =?us-ascii?Q?VMyBQs9Bzh7coh0aVBKptye1fhng33Wvs58mj92omFdxMCiqlX3GMof4hIyK?=
 =?us-ascii?Q?Z9ze4ZL0vvcnQrWsUUemHQ9e7zI1qQGoG89fpEmbHAoRBVcnQCZcprKvDHtI?=
 =?us-ascii?Q?ES3HN9/lhgmRZbpAxViHA5jTjbA/8vKneukJG5pHlnWI2YdaAZpnmaxEs7sl?=
 =?us-ascii?Q?43cqUREHgdEYHFq7BcFh2YS6Uu7OBhM3+kxD2oqFwCFTVxgf2x7cPKPzsiYZ?=
 =?us-ascii?Q?ofOgjFyRpWIV0CKQwzhxhfrmiDLMq0goj/5Z79HZetujtA+LV539JNJLGnOH?=
 =?us-ascii?Q?cyPLldilXsA7T6lGod1MWyD70HOr86at1PihiV+e/GDkKyMgEJY34mnfud8J?=
 =?us-ascii?Q?3GIKfHAvLMm792N9IP81a8AelPrn31/AlPpjqFPXfiD6aF5Nb5uALL71ncwO?=
 =?us-ascii?Q?JtXmkTx/k19XC14VEORqfFo2rVGuLRvmLPw+imYfyBV0EL31l9AOlkW632HQ?=
 =?us-ascii?Q?8boXWXGLSL7REdxmQShY48EgwRMXC3AE9VaqoBQTo6gFIQiIQBkpbPHo/b+G?=
 =?us-ascii?Q?BIJV64p8cW/RtMRJBSNxdR4JLPALnXwPXnW1Glp8yLHqtzAovHVJguk9pC8D?=
 =?us-ascii?Q?+/jLMgLRRvsYdl8OTpGg+4Qbf1vsIcctERmOjUzeryWOVuL9uSj+dqqzWomd?=
 =?us-ascii?Q?8kOrZoEUUZ0Q90JbhUUoF9Yy5W1ps2/5SB2BOpm8Wa03VZY3aZBBroQaBavz?=
 =?us-ascii?Q?4ognVfJRMBrdkm59TrxlZwFjgEtvjfK+tgtwqYTCgcT6y4I9CLxLlcTHB0SI?=
 =?us-ascii?Q?Ei8wYt9z39DgHL1ru4sLqxk4+d67zDh/AtIryAXkTBJ2sIX+c9hQmf3UXK+P?=
 =?us-ascii?Q?rEPXPwklE3FnbCt6jKxgvgUYwOLcrOv35WsxGEPCO/zja18hLHmCiWpHUafU?=
 =?us-ascii?Q?NgjKzhqDhCGWaCJDnZ9tDH4kLKXFUjPi+L9ulbRMWcmkoZ1IVSS1j+qNkOum?=
 =?us-ascii?Q?Xa9DOq3QpXfjH4UrFr9r2kbJaStR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHwKyQwvSsAQpRA1U/ghpgjinyvWXEEeWl1pbHIFWK+iqkapS84O8qIxAp1A?=
 =?us-ascii?Q?zWZpYaos4JSulhbipKBYPtySoyagsj+hF+5w5/sHzwbKGBbvs9WrZNsSjiE8?=
 =?us-ascii?Q?DPmw1TLQk6YAR5DAWfhsUtlkDQqjFdmZ8CJbs+CglCEEqgKPjc3Wr4J4ub2r?=
 =?us-ascii?Q?ztpbMgZNUggu+Wv+o0emgBnJwhowFleSGHW3LblNYft1dohlS7lnLDB6EzVW?=
 =?us-ascii?Q?YXPJzxYyYrgZbtfvEg8hSTRQq7iwovWW4ragb4S17jPA64krokpteQQedoaO?=
 =?us-ascii?Q?NxId7IYzfS95dizoUVskfpH/ea+FF1wya4Ky2lYD0FpP8imvizAfXreKV5OT?=
 =?us-ascii?Q?KhplSx9qbVILiNd2Q6ytb1YVcmRyW0OXedNGVSDGlgEqmcOMKSSQHIOHyseQ?=
 =?us-ascii?Q?S0UyIPjad41sNKrr4eJZiYx3c9sVVwO0GhorfItY/kXgYjDB2QJm7csPK56P?=
 =?us-ascii?Q?+8CaFgDIAj/uXcUmTLVw8v0OIp6Ew1Ok+KeiPrQzaPDAxQQOUQGQBBl3ngED?=
 =?us-ascii?Q?h50y1a0gdPx5YkIO548UGep3lzDlj4rrPOXwgRw70DNpknHS11mXQxpD6hRg?=
 =?us-ascii?Q?aaFmCjyZPyk+i5Nmqq7AaRGSfsmhXXiR2CqFVBOLz4bVOgeDpCyCAJ2NQRhd?=
 =?us-ascii?Q?wGu43l+rMCXisSTM1KEnJfgW+q4R1iRAnkMH53UinNUFpuUvZuWIUluArY8F?=
 =?us-ascii?Q?Fr7g45+XPp2P1G98TimSPuUcJyfFrMB9dpn1aZSTDH6+I4BhZUKPx1PztP1q?=
 =?us-ascii?Q?gqWxVzAqoWujXgotMtkJifyTA1UUAZ6HWIOVD+Z2RwsC6JeoMp/FObqeF26x?=
 =?us-ascii?Q?8hrx7yGw9k1baGW7kXuJE30my49AuEeHDQfw5FJWrDIybdXcXi1KjumB5hXB?=
 =?us-ascii?Q?GRa1tCdwA84titQ3y1Im3sQn0CQvmFmZ+XkuqVH8J01dF3m/8jm98n7ghXpC?=
 =?us-ascii?Q?Q9AoEfIJ2OznGeJq/Ett9fvQd/kJkcyUZgXtzfhKn4ZHOW0+rg1YlchYDDha?=
 =?us-ascii?Q?DxhmTVXiTz+x412HXJX0Vhn+KXZhgVhPiiYKKuEHZFVcyryKa9UifD/4ngWC?=
 =?us-ascii?Q?jq0razkSz0MYHT7YXa5FrSVEWdEObTxI9M1lX8HafiyCQTPLj4QvM0K91kIj?=
 =?us-ascii?Q?pQabmddp3qAiDorlQYj2lc1uZrGrnmlgV9cXN3nTXumfykv75ICG1XvYeshR?=
 =?us-ascii?Q?5BcPNB95ec9P4yW1EPXCLIjKBexOAoMIpEwhHXqIrvRUy4yEZoi/d5xg1o9j?=
 =?us-ascii?Q?TQ+7ZrxlFUEhNQ4ppbg3XUslAaGvaYzgFhYvcIzTE9mIhTjZLE9vt5jncONX?=
 =?us-ascii?Q?a/N2kOJ+QsiQH2YFsqPH2Lk0ebmotu9sRQ3A6hqxjtjC7kiZfcgq4HIqhIYW?=
 =?us-ascii?Q?kk7B4gjU5N3S4BfuILFtxZMMkqiPzZHAPGkbBazMHkKcVgL4hQAqF9V2rIjy?=
 =?us-ascii?Q?eBL5jplh+lccM5QfCBqeEur24dvXg3YJ8IyRoOBN65u+PwtnauA+nbXeL/Pm?=
 =?us-ascii?Q?auTskri4yN0/NMQ4PEoZ8siKKAQrPGI8tiyxupIhbsaBVbhOy4O5h9nDlROc?=
 =?us-ascii?Q?J0rI2r8IzyKdX7eFEeqStA5BOV5otZg7G90z5V45?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f3f6b-e815-423d-893c-08dd57a86241
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:27.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C+gNYtBEVdIk6n1GGM15g9rWRqwqEeQQuuXT6mE8gWGUIyluFJnY1nbdM84n6pTfhs3M7ToGHjIJhhZsAaj0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

FS DAX requires file systems to call into the DAX layout prior to unlinking
inodes to ensure there is no ongoing DMA or other remote access to the
direct mapped page. The fuse file system implements
fuse_dax_break_layouts() to do this which includes a comment indicating
that passing dmap_end == 0 leads to unmapping of the whole file.

However this is not true - passing dmap_end == 0 will not unmap anything
before dmap_start, and further more dax_layout_busy_page_range() will not
scan any of the range to see if there maybe ongoing DMA access to the
range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
which will invalidate the entire file range to
dax_layout_busy_page_range().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: Vivek Goyal <vgoyal@redhat.com>

---

Changes for v6:

 - Original patch had a misplaced hunk due to a bad rebase.
 - Reworked fix based on Dan's comments.
---
 fs/fuse/dax.c  | 1 -
 fs/fuse/dir.c  | 2 +-
 fs/fuse/file.c | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0b6ee6d..b7f805d 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -682,7 +682,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b..6c5d441 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1940,7 +1940,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a54..dc90613 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -3196,7 +3196,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}
-- 
git-series 0.9.1

