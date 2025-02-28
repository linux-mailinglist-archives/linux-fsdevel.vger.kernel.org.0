Return-Path: <linux-fsdevel+bounces-42822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0254A48FB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD65B163D26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4E1DEFF9;
	Fri, 28 Feb 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G638jKfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A51B6547;
	Fri, 28 Feb 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713584; cv=fail; b=b3/3n2GLwGuuWxddcJAaPPMvUgZK4paPO6bw1qE4C0yeWfyDmuqmTldzQjCOmwgo8xgMUvaSXhCzwjshQ/aRS9AHeKliCFctF4NQhmhu+sIhVKlBPK+GtOUr2wjcBGxMKJgkGT8UUhJ3sq4f95mqvzrPOFYaWeaw4nPoQzu0JUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713584; c=relaxed/simple;
	bh=SAC+0joFmvpdVWZ4j3kQvyHFPadGuPMFSoljdwoqLfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3vM7qXH5YHo/xU3lOy8D9Sh/9kLQglRPgSt4g2IdGn3kuZYfzOGZSqNMnCXL1pkUPNPYax1W3tkQhhnm5gA3n4MieuGJa3xZCnYchrICMRFuyMQ+cooure5buPw7xaDCkQaRWgRt8W10AyedkbE6fSdP1G137/GpLdCW+XvFRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G638jKfa; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHVK1DfZZNClBquCoeWBxIMJxZ2Zjhlz/Kj3lhyVd30pwxqKdTlx8jGzuRfHemEPxui8qfOkLDjwu9YPLjVG1RwZ/3BMn345IoIlRse/E/wzYp+eR2nwqLDUXvyGX4yqHwmvSdcRqRRfhAkvx4RiWdiILGfTIztbijIPLgUr7Uh3S7Z1njzyoX0XoW+fV1TL37p5/NrgG1qgAmL0yfqLNxQG2Ue2LKKyOj8Z7gqE7vSxv6QQX5tgsEBkvj/ocHA+VFWS4NOoJXqULc9PP68B2rsVCgjrcsXl2EbjJH2uBqs634rjPXL6YxsbDGLSCOu2f6LJCsitZT6RcW4tfgDvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/1fPSud41Om/5E3Ev1OVsqEH9uR8RyQzS/KEtTOXIM=;
 b=cBZhwUnSj3xnW4HJyyC66Uelb039i3S8HExBMRy/7qYfyibQAPgjA/wnFzcOUAfTlI7C4Qe5TZL+HPpv8jal+qrE4WbhxRVZUZXUKCHrVWVJfUFhMsXENTq7tCBe5v0bpLymMztuItqMZjgvtZ881Jp+Zemddl9AXJKaCioMDLiDgR/3I5NnOA5BplzS3E/ku57f81lfNNJWiMh2OBbNtzPsH55nqN9swXqLVhyD9sXmTUctcOpNnAzRH/cZXFiMwu38Xx4ySo8fFrvGXMQZ/aq1x+i+nlxh2+NHsTAgAsK/dlC2cL3tZy9zwuplnc1Imt26aylC/1GWSMj1TQK9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/1fPSud41Om/5E3Ev1OVsqEH9uR8RyQzS/KEtTOXIM=;
 b=G638jKfaVzspmFsmjZug0QSQ90YrTI1WNrS4UxF/SPztk1VvbOdBqkjGuzz6+X4emJZW9IqRFLO40B0T4RE4FX0GyNckSMlTXpEgFqIEoj40mGeZYB//VPuNx7Xt4Y0b6Um8mZlVjoWsIk8ZSv3Hw2v0QtVTGB9ugNQTAJlAxsJxI/iTF59lgX8sxeFrwA1zYv1iajpU9ij8hg70RqRzZnjxrs6hAqpJTkikE/RylHig5u5MrYBhr/F2fzS3pNoN/9czEtSbpNa/SWq3f7EsItIr5McT8U1AupXRc3LA/kqyXW2lsmlWLBEvyupa7oX//wpkXIqBjMAgEYfl/fMfDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:54 +0000
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
	loongarch@lists.linux.dev
Subject: [PATCH v9 19/20] fs/dax: Properly refcount fs dax pages
Date: Fri, 28 Feb 2025 14:31:14 +1100
Message-ID: <c7d886ad7468a20452ef6e0ddab6cfe220874e7c.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0039.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f1a6ff-62da-4f6f-3b11-08dd57a89613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/TftW+Aq0dQFZ2mMPWLeSgyEEKwTJhXB76BQRm/zlyUcr4c3qYxTPEy1/E1?=
 =?us-ascii?Q?pgGuMQrcbmj3lytGDrA4tjDMlRqYAMzFsLJkqHfyGlFSa5i6fSz5LeqlItLr?=
 =?us-ascii?Q?539j1PZ7rhdFVW8TQeAQAIE8Dmva1lpTyibG6WyFrBcyr2WnQ5gzYYorOB9V?=
 =?us-ascii?Q?L7jw3aptDl2/cJDqhn+2gh2En6lEBM4ZfLvr2+3UON/rBU9NdMjNI+Fq732h?=
 =?us-ascii?Q?BdjW8iie1bCF2gWJxL4w+zX4MLSRzirH8xpeesqDkRAINeukfZhqw3RGLr/s?=
 =?us-ascii?Q?Ka/qBDW1znAV7F1yZTwvKhcQRKSN3P10uXqJSsbY/TIPQ0SwcXO4cvE6s8fb?=
 =?us-ascii?Q?oET5uID6jpDlPgFBJuhjwPLlN9oa5ixfCtGDcschwpGQA+mlb0+6f6c/Zeyv?=
 =?us-ascii?Q?pBgfZ45ODpRSEEG6wzYHqYtx95lXwtoyUTMSUQQ2WxOraoPp0HmxeeHagdfF?=
 =?us-ascii?Q?DvbZMC0/D8K3OUsu5p9uvaHrwNNFhnaAypAq7O0aWI7P7bHEaDgigO61ttAK?=
 =?us-ascii?Q?64UhjLMIeuKz7NUuJnA40+1evr1qEMxIQDhYPjgsEmMhRyDsMr1QxI47TCRB?=
 =?us-ascii?Q?ugFw5nWw4myRCOQk9kz5MCxltWLxh2H7iZYCebEzyRu2Ms2FOQecUUf87Czn?=
 =?us-ascii?Q?rHcyajxC+mV49MAto+bgqr+U+MeS3pgv9/xOye8lH1Yw6vxcczonoabut3DB?=
 =?us-ascii?Q?DDhrvUeIIsEqquqNPGECQY3TO4a/n9+ZzhjpW32voRi/MO/zMm6z8NoTqlQm?=
 =?us-ascii?Q?uti6KqTWnWgVMPJOEPJzEpLEAwcMbRejkN15YqMdQ7yDjOSZlyJMkFQIKFE1?=
 =?us-ascii?Q?5u+aVXZwvMr8FgxiUoiYpqp8nLsLzCErr6cncp1hDwhw5MeIonPjcTxYltIA?=
 =?us-ascii?Q?9QF7KBrIU8wVHzlvlJ2oLvF+ybI75KizhxUPxq5Sr+g14+F4hFRFMZkEutfv?=
 =?us-ascii?Q?Jj0IID3RtrAFnJONPND62Y98daw5UekEdib4vYt4u/SCqR3QOkLYm5m3hL9d?=
 =?us-ascii?Q?cOGrmes1Q0foKafw9ofy+OPOVvM7zKJ3en24LTdGaR6BSgamdt8cepOL1cZW?=
 =?us-ascii?Q?cXLCkiAjcw7fGzg6FScv18PWaCf9o7r1j8LL/iTgCTgiSueDF/PgUpl4H7MI?=
 =?us-ascii?Q?srsg0AJMJSJfEVyyJK+l+KHCGzipvbOaRvDWhUF9MoWn7Yln8K+bPlmxlKEJ?=
 =?us-ascii?Q?baKdbce6bLJCkj8ZosrLfd2tAC8aYYYln+Bni5+4GlWeWbCysM66EEWUxfpx?=
 =?us-ascii?Q?Di2Xdx8IxpFhiQnvvPKvZmFChkPSYRwFcD+u5N1WRODjaez/VU4pPM6eO+rL?=
 =?us-ascii?Q?m26YCSOT3o7Y4aDTLks3oUKfsjem/wpf3X3Ee76eR6D9a/Kq054Jq3gRfBBn?=
 =?us-ascii?Q?xCoUchuy3K6/hFzJpV1QX4upKJ+J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0fUXzzws/mwpJyxaat+gbfOVfg7yg3q6Gw+9v2M9qA9YD4FL2xZWzAJ854X?=
 =?us-ascii?Q?3RFVPXdO2jSNrpBwUYyscbqwWqiIMSiB+CQWd0qwQh964zlO5eM3auPtjwMx?=
 =?us-ascii?Q?ayLuBW2pUhEjmB4CXhZL0XlD12oISBJVjGaHRhZaYgq03w/CJcMj2SbNqlnh?=
 =?us-ascii?Q?npPWOBAIuIwnfLCz2Z8TheVWoEynuQBDuuiO4mF9Ac4uy+v/PchdcC4zi72i?=
 =?us-ascii?Q?c3tBn6Pzo7LcVPd51Sc22pe/5T+S6ETO6XnSpanlqG1pPbwM8AxfapJTn4q9?=
 =?us-ascii?Q?S/hZ1e0VSvwb91T6tzf1pj9i/OyHwP9seUKK/AEoBFuhRgeOgttGCd9s2IBw?=
 =?us-ascii?Q?LwWwtKKX+LwyArvT3b02lCq5L4vV8m73aYRLNmE9OY3P/iXcAc9DCHSeWmXG?=
 =?us-ascii?Q?LurQkZN1VhScOVnRpW9nRxW4kTn9Ra/YusPjvmX2PLKuNuOHVMdMsaJNCrof?=
 =?us-ascii?Q?7t/11f8UfPNQZ9rEvLxVS94LpofJJZ/8fTKQGBlX6ZkvrnLhHKNFpleCO7vp?=
 =?us-ascii?Q?Jyk9lBD8exTmVmLT+Mk0U9Ip7bYLCb7yRFPVelRHUJSQNWPD43jngYKOKTsF?=
 =?us-ascii?Q?Br6XSZkxudSlNbVyCuGjT2g0ImA3RWcHKuJDJG+iunhq/7mqA5KQs8EWXR9x?=
 =?us-ascii?Q?T7fQ2MjsU1mtYdH7r4lrgxvwsJOrxxRCLyZk38zVd+xu6b+L5yv03HeqW3O9?=
 =?us-ascii?Q?mJDKVYfWy24cNQWLCWACGkgnmd8/yeurQFFxF3Ahphj8mV8x3QVK3/pGBsbL?=
 =?us-ascii?Q?HlIttxbyaQqNiexe5K2heO/2jqnYZbNStAYTqConda0by7PoZQHSBEDzE2fy?=
 =?us-ascii?Q?SrY4M9phzZsFUg8EXo9fFVuiZZEjdWQYcfrWHBSvRnWbjech9I28307t3bw7?=
 =?us-ascii?Q?b13G6O7voPP6YtTF/11jLg3asXk9s/sHHgN+I/mPn1ual8fw6P6WiqkafS6A?=
 =?us-ascii?Q?tPchvndf+otcwMKT/hzCMMfO0QVqCMlyBm/WAOdAQGUkg+PodnvQneMBDCAU?=
 =?us-ascii?Q?Qwiz2YyITrZOglLp7Dx9ZZ3HRTOh88FH6mJpBoSiqrdCjvboDi3tGzpwy0jW?=
 =?us-ascii?Q?QqNsUACQtgLDMBKuLSEyHAjgZ4cbTXGJqYe7PTl4PyY/5OxZIWmG1osN/JTr?=
 =?us-ascii?Q?aoC0DwPffgZKjHbzdghYhI60j/E1/SIocqNEY2rDHktmadJdarsOc2w0PGbN?=
 =?us-ascii?Q?wONAdZrIY2kJhkVKBZWeSh9Lwz6CLTjTc1Iz+TnAmpgEimvn7ADRmLPufoZ7?=
 =?us-ascii?Q?DOrlZTcX5uMlizCpW1EcSSuMvg2oNqFx+2UGM+RHYfjvYhkSuJZhJG8gYnPq?=
 =?us-ascii?Q?OsL+miY8p8cD7bZGQqYnosi6zYNhsWnUuxRm5VMgkVE27sgDNtWQaCnOR7WR?=
 =?us-ascii?Q?FPy6tJt849lZnwo/6MU3SjiEBPRGMDSBQI/+a/4hxKOijk3ow5CjNLqkyFVo?=
 =?us-ascii?Q?YGuvJkHjV42BOqJfdzafUNpBmgvEObFjAdCfRteQyI0qtf+8R9O6oIqmafzu?=
 =?us-ascii?Q?kaPCKWkZ+MCSVoyrCv6srdGXLfE7xMfDyh5Ka8wkg7RoJ3KLFZQFkATMC+6A?=
 =?us-ascii?Q?+eiJoZRCtN5bcMGzR93yOok+yQ66u+ZI3jwt3vZQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f1a6ff-62da-4f6f-3b11-08dd57a89613
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:54.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acYHFRdKWefV9CizP1ZcU+7jVG4SDvlpDo3Y2sEj9OA5H/NpkT4PHvuteSYaezl+EPEkvl0glx+IQ27//kwtOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v8:

 - Rebased on mm-unstable - conflicts with Matthew's earlier changes.
 - Made dax_folio_put() easier to read thanks to David's suggestions.
 - Removed a useless WARN_ON_ONCE()

Changes for v7:
 - s/dax_device_folio_init/dax_folio_init/ as suggested by Dan
 - s/dax_folio_share_put/dax_folio_put/

Changes since v2:

Based on some questions from Dan I attempted to have the FS DAX page
cache (ie. address space) hold a reference to the folio whilst it was
mapped. However I came to the strong conclusion that this was not the
right thing to do.

If the page refcount == 0 it means the page is:

1. not mapped into user-space
2. not subject to other access via DMA/GUP/etc.

Ie. From the core MM perspective the page is not in use.

The fact a page may or may not be present in one or more address space
mappings is irrelevant for core MM. It just means the page is still in
use or valid from the file system perspective, and it's a
responsiblity of the file system to remove these mappings if the pfn
mapping becomes invalid (along with first making sure the MM state,
ie. page->refcount, is idle). So we shouldn't be trying to track that
lifetime with MM refcounts.

Doing so just makes DMA-idle tracking more complex because there is
now another thing (one or more address spaces) which can hold
references on a page. And FS DAX can't even keep track of all the
address spaces which might contain a reference to the page in the
XFS/reflink case anyway.

We could do this if we made file systems invalidate all address space
mappings prior to calling dax_break_layouts(), but that isn't
currently neccessary and would lead to increased faults just so we
could do some superfluous refcounting which the file system already
does.

I have however put the page sharing checks and WARN_ON's back which
also turned out to be useful for figuring out when to re-initialising
a folio.
---
 drivers/nvdimm/pmem.c    |   4 +-
 fs/dax.c                 | 186 ++++++++++++++++++++++++----------------
 fs/fuse/virtio_fs.c      |   3 +-
 include/linux/dax.h      |   2 +-
 include/linux/mm.h       |  27 +------
 include/linux/mm_types.h |   7 +-
 mm/gup.c                 |   9 +--
 mm/huge_memory.c         |   6 +-
 mm/internal.h            |   2 +-
 mm/memory-failure.c      |   6 +-
 mm/memory.c              |   6 +-
 mm/memremap.c            |  47 ++++------
 mm/mm_init.c             |   9 +--
 mm/swap.c                |   2 +-
 14 files changed, 165 insertions(+), 151 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d81faa9..785b2d2 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
diff --git a/fs/dax.c b/fs/dax.c
index 6674540..cf96f3d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -338,19 +343,6 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
-static unsigned long dax_end_pfn(void *entry)
-{
-	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
-}
-
-/*
- * Iterate through all mapped pfns represented by an entry, i.e. skip
- * 'empty' and 'zero' entries.
- */
-#define for_each_mapped_pfn(entry, pfn) \
-	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
-
 /*
  * A DAX folio is considered shared if it has no mapping set and ->share (which
  * shares the ->index field) is non-zero. Note this may return false even if the
@@ -359,7 +351,7 @@ static unsigned long dax_end_pfn(void *entry)
  */
 static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return !folio->mapping && folio->page.share;
+	return !folio->mapping && folio->share;
 }
 
 /*
@@ -384,75 +376,117 @@ static void dax_folio_make_shared(struct folio *folio)
 	 * folio has previously been mapped into one address space so set the
 	 * share count.
 	 */
-	folio->page.share = 1;
+	folio->share = 1;
 }
 
-static inline unsigned long dax_folio_share_put(struct folio *folio)
+static inline unsigned long dax_folio_put(struct folio *folio)
 {
-	return --folio->page.share;
+	unsigned long ref;
+	int order, i;
+
+	if (!dax_folio_is_shared(folio))
+		ref = 0;
+	else
+		ref = --folio->share;
+
+	if (ref)
+		return ref;
+
+	folio->mapping = NULL;
+	order = folio_order(folio);
+	if (!order)
+		return 0;
+
+	for (i = 0; i < (1UL << order); i++) {
+		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+		struct page *page = folio_page(folio, i);
+		struct folio *new_folio = (struct folio *)page;
+
+		ClearPageHead(page);
+		clear_compound_head(page);
+
+		new_folio->mapping = NULL;
+		/*
+		 * Reset pgmap which was over-written by
+		 * prep_compound_page().
+		 */
+		new_folio->pgmap = pgmap;
+		new_folio->share = 0;
+		WARN_ON_ONCE(folio_ref_count(new_folio));
+	}
+
+	return ref;
+}
+
+static void dax_folio_init(void *entry)
+{
+	struct folio *folio = dax_to_folio(entry);
+	int order = dax_entry_order(entry);
+
+	/*
+	 * Folio should have been split back to order-0 pages in
+	 * dax_folio_put() when they were removed from their
+	 * final mapping.
+	 */
+	WARN_ON_ONCE(folio_order(folio));
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1)
+			INIT_LIST_HEAD(&folio->_deferred_list);
+		WARN_ON_ONCE(folio_ref_count(folio));
+	}
 }
 
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
+				struct vm_area_struct *vma,
+				unsigned long address, bool shared)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct folio *folio = pfn_folio(pfn);
-
-		if (shared && (folio->mapping || folio->page.share)) {
-			if (folio->mapping)
-				dax_folio_make_shared(folio);
+	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
+		if (folio->mapping)
+			dax_folio_make_shared(folio);
 
-			WARN_ON_ONCE(!folio->page.share);
-			folio->page.share++;
-		} else {
-			WARN_ON_ONCE(folio->mapping);
-			folio->mapping = mapping;
-			folio->index = index + i++;
-		}
+		WARN_ON_ONCE(!folio->share);
+		WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
+		folio->share++;
+	} else {
+		WARN_ON_ONCE(folio->mapping);
+		dax_folio_init(entry);
+		folio = dax_to_folio(entry);
+		folio->mapping = mapping;
+		folio->index = index;
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+				bool trunc)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct folio *folio = pfn_folio(pfn);
-
-		WARN_ON_ONCE(trunc && folio_ref_count(folio) > 1);
-		if (dax_folio_is_shared(folio)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_folio_share_put(folio) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
-		folio->mapping = NULL;
-		folio->index = 0;
-	}
+	dax_folio_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
+		return NULL;
 
-		if (page_ref_count(page) > 1)
-			return page;
-	}
-	return NULL;
+	if (folio_ref_count(folio) - folio_mapcount(folio))
+		return &folio->page;
+	else
+		return NULL;
 }
 
 /**
@@ -785,7 +819,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -953,7 +987,8 @@ void dax_break_layout_final(struct inode *inode)
 		wait_page_idle_uninterruptible(page, inode);
 	} while (true);
 
-	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL_GPL(dax_break_layout_final);
 
@@ -1039,8 +1074,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!(flags & DAX_ZERO_PAGE))
+			dax_associate_entry(new_entry, mapping, vmf->vma,
+					vmf->address, shared);
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1228,9 +1265,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1337,7 +1372,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1808,7 +1843,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	struct folio *folio;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1840,17 +1876,19 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
+	folio = dax_to_folio(*entry);
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	folio_ref_inc(folio);
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
+					write);
+	else
+		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+	folio_put(folio);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -2089,6 +2127,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct folio *folio;
 	void *entry;
 	vm_fault_t ret;
 
@@ -2106,14 +2145,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio_ref_inc(folio);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = vmf_insert_folio_pmd(vmf, folio, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	folio_put(folio);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78..2c7b24c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1017,8 +1017,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2333c30..dcc9fcd 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -209,7 +209,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 
 static inline bool dax_page_is_idle(struct page *page)
 {
-	return page && page_ref_count(page) == 1;
+	return page && page_ref_count(page) == 0;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 066aebd..7b21b48 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1192,6 +1192,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1513,25 +1515,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1646,12 +1629,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
 	folio_put(folio);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6f2d6bb..689b2a7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -296,6 +296,8 @@ typedef struct {
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
  *    this is the index from the beginning of the mmap.
+ * @share: number of DAX mappings that reference this folio. See
+ *    dax_associate_entry.
  * @private: Filesystem per-folio data (see folio_attach_private()).
  * @swap: Used for swp_entry_t if folio_test_swapcache().
  * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
@@ -345,7 +347,10 @@ struct folio {
 				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
-			pgoff_t index;
+			union {
+				pgoff_t index;
+				unsigned long share;
+			};
 			union {
 				void *private;
 				swp_entry_t swap;
diff --git a/mm/gup.c b/mm/gup.c
index e5d6454..e504065 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -96,8 +96,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -116,8 +115,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
@@ -565,8 +563,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d189826..1a0d6a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2225,7 +2225,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2882,13 +2882,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
 			folio = pfn_swap_entry_folio(entry);
+		} else if (is_huge_zero_pmd(old_pmd)) {
+			return;
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30..db5974b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -735,8 +735,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 995a15e..8ba3d1d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index a978b77..1e4424a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3827,13 +3827,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
-		 * VM_PFNMAP VMA.
+		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
 		 *
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if (!vmf->page)
+		if (!vmf->page || is_fsdax_page(vmf->page)) {
+			vmf->page = NULL;
 			return wp_pfn_shared(vmf);
+		}
 		return wp_page_shared(vmf, folio);
 	}
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 68099af..9a8879b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->pgmap->ops ||
-			!folio->pgmap->ops->page_free))
+	struct dev_pagemap *pgmap = folio->pgmap;
+
+	if (WARN_ON_ONCE(!pgmap->ops))
+		return;
+
+	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+			 !pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -484,26 +489,36 @@ void free_zone_device_folio(struct folio *folio)
 	 * For other types of ZONE_DEVICE pages, migration is either
 	 * handled differently or not done at all, so there is no need
 	 * to clear folio->mapping.
+	 *
+	 * FS DAX pages clear the mapping when the folio->share count hits
+	 * zero which indicating the page has been removed from the file
+	 * system mapping.
 	 */
-	folio->mapping = NULL;
-	folio->pgmap->ops->page_free(folio_page(folio, 0));
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+		folio->mapping = NULL;
 
-	switch (folio->pgmap->type) {
+	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->pgmap);
+		pgmap->ops->page_free(folio_page(folio, 0));
+		put_dev_pagemap(pgmap);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
+		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
+	case MEMORY_DEVICE_FS_DAX:
+		wake_up_var(&folio->page);
+		break;
+
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgmap->ops->page_free(folio_page(folio, 0));
 		break;
 	}
 }
@@ -519,21 +534,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d0b5bef..5793368 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,23 +1017,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
-	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
-	 * allocator which will set the page count to 1 when allocating the
-	 * page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
 	 *
 	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
 	 * their refcount reset to one whenever they are freed (ie. after
 	 * their refcount drops to 0).
 	 */
 	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index fc8281e..7523b65 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -956,8 +956,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_folio_refs(folio, nr_refs))
-				continue;
 			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_folio(folio);
 			continue;
-- 
git-series 0.9.1

