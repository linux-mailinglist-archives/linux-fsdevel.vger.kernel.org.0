Return-Path: <linux-fsdevel+bounces-41921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB557A391D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33C0173D99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB711D63DB;
	Tue, 18 Feb 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aQeSYuRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A681B0411;
	Tue, 18 Feb 2025 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851012; cv=fail; b=ar+Pdc0dMbWAjMcqcQjYTT5Opul5gIE7WMImFiZE1Oc7Ub7LSncHh9sZF/jzPZpfgRkcbOeQfunL1et8R91xdxOGPrrBaOc91My9m38Bn1/KcF+BH6zFZlowkTuhtphoPgpe+xE45gaIm5mvZqBJBvjNtw3BWfZw/u/4fSoeI0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851012; c=relaxed/simple;
	bh=/z5YU0hIgXZ5S8l+9taGxdT+DTnMc9LLGBy9gcm+Pz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1/E8Gz3AfpagAkRsw9BQl2w/ObX7bA1kFgiSwRtVzvrCnY7c1E/g73JJfKPOPLgmPpjM7Xtn0skTOp4OJnpg57LNKnUlj/ecJ6vq9pL4qLR1kmoGNmhfFVdwKNlhLxLrYMdZ5OnCN2S4mpr9vjmXB2vd+y0gmPgqsT7iDCYVMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aQeSYuRY; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf8Td9nDpQb9fVICC26YgajAiwbgaQ5BfQChqKeAdGuzEpzRhPHB8UydlPDqpTwlZCR+fUJPoO1M4wdItVFhN1frRKH6W3lTDdpw7kdTDHU8TzBI75nhOOncZjTUHmO+W91ph4zgj/nO/18K4IoUiVdQntZG0pU8Wt8/QR7RdPhpy2Jql++uv1lVZEj2rEDeRZJIHa1yuTiFMJibv4C17iIzTF2rCznLeSB6aHh0oJzneUeLe4yBhRObkegbQi7UU6M77eMVq+kRH7qcTmEyESBYHPbMOQF0eQxOBkLdqJpb/uM/T8e6FUoH5yGZu3bg/68/KUSG/3OfIab0Ayg60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTTiTU5gdLS9jjjn2nw3kxsABNk2exmAz8F45eWH3e0=;
 b=Qfdjgc2wiVpZWt/Qz9oQTklVQ3aIgChjsJsI/gO7WwY5XqQJa0YhNk79Sj/DGvCILUnckIiQzfh/RmLw3F58JTdt+0a1IyLs4l7+qsTgHOWPVkKqPkXYVEG7I6dE7F+cldG+8Tiry9fwqsQUHqH0gvWAgu7bMKBwQW5NmnrFyBqT3vW0riFQrQL2YsLy9g+rG+SK/VaYWVB2gG3rSLE8RnJljAFQMUeGVKBv5L/n23Nqep8NyPz2r9POjI+fd2O8vCKa6C48cegHLBJTRy4s0yPYIN3HmU0Npm9i9mlwnPsORHq/oBq1Fvmt/ljjBAwZeD1kIAzsQRg87f76g/Hr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTTiTU5gdLS9jjjn2nw3kxsABNk2exmAz8F45eWH3e0=;
 b=aQeSYuRYSHMi2w/P4knroaGvmMBmDchTGTgPm9YBA61E8WdXnEDqUq0KmClO4L8/4HQedoEJfbs/adVqAjL+FMNNeYLTALZgdkQfbQtcVlJbDOFPYnSaGdubveVAoCCj8idwj9gAZxQoh7OLvWn2D0vPNieatVe9OUpCSLBA2g21tvsHQSMXqq6mPpxHwEW7lGUjKxplLXW8JVLnTkFHR9JYbbieDQnaPDVLc5duIYhcT37lHUfNYYfEgrco2pxeaGcGaxVMObjwjEpXLSbT5f+mzAbkMxfpRlaBWSt7iRRG2/a1m8qpS7JrrrL8xS23DyhUJWgOWwpmMv4swVaq/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:56:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:47 +0000
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 11/20] mm: Allow compound zone device pages
Date: Tue, 18 Feb 2025 14:55:27 +1100
Message-ID: <5106a9ab1b2eaa8e6f1429fcb3cd1e86ecbb0a29.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0075.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: f12353a1-6f1d-4926-cfe5-08dd4fd04414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sxrow0WJhXcGAlIxHQC7a9JPRcDEjNJW0L7NfHF4UTIWEGWYt/dOapPwhTPN?=
 =?us-ascii?Q?1AVVdOnM5gpCwMxBeap/pVqajqH0Nyjm6LrusRGOx7rAhLWHll7Q1sJUdRbU?=
 =?us-ascii?Q?sjE7b+F9PL/xwv/H82yxz8AWTsF0UtNaYoo3hpyJmhbUmQ3LqRObf9yjlbJU?=
 =?us-ascii?Q?YeYVTMIxx4TvtcPTB8hOyZItUUlsnU/ayvgXkfj85VOcH7fAfZmccnd0QrD6?=
 =?us-ascii?Q?Fa7i1MN75sQ+PUP+N/tYNQAUByqLhBXUFrSvXvQsgplvXyqjdW4fZOB3zDeB?=
 =?us-ascii?Q?3u1WYx4hTzHAeBEx3zI8TyhIgLNw6HRMu327DSuy3Ew/4Nldb8NDpR/Czq1s?=
 =?us-ascii?Q?oObdos5YL0tVFtv01GvdaM8tBuk7t93C7SG8X7I0wfmpR+SOMs9wfvkhiK9l?=
 =?us-ascii?Q?rlewYJkjVPtoIVdfDihOLn61rAtWZW210kGx8YBqYhwpZy7IkqsXgS+zRO23?=
 =?us-ascii?Q?isAUVhqAiiw1dT8a2ifyh6SHvHemdJ4KF3952Uz9xCierlRqvCba70AFU5Ik?=
 =?us-ascii?Q?tk9zJ+L4AB720/o8e3k5j0TOl9IoJNz3Mx7avlyJ0x0Wlxqeay0H97FCBsCZ?=
 =?us-ascii?Q?gLfNuknRJBZD0x11uGEamirAw6+zCdFbG03mROcfOnQXk46bfrWexEOOvZKb?=
 =?us-ascii?Q?Oib+1OuSFrYGF6eRMpcLR8AtYs2isHHt4m5KSfcjxthMWdv/vVBVwe2GTOhm?=
 =?us-ascii?Q?jX207eBoLj1O3CvxXnWD8Xq6wxkvJySGkxmZk4F4rqgiZEKjPuV0Q4VvOAFo?=
 =?us-ascii?Q?RkWZvcJamBF9PWm/RSl+0Ya5BQSGNbVklPTAala2WffLKoYE/Y1Ruw6qqMXk?=
 =?us-ascii?Q?WpLmBYqU6gkM7VmugBhGfCOSJfYNUbcYyLM9diavC8nHeRljRNnqbBt7RC0D?=
 =?us-ascii?Q?8L/MBssDmDsvmNlEj5QmKyxUEgpWzQ3MkaHGo3cz+dQtZ54tVsbRcFr+6JF6?=
 =?us-ascii?Q?xJm3VzXL7+ni1XmAM5lT8Vg1oVu6evUYKU6Fsr7MgetVE+29Gqi1As+mK+F6?=
 =?us-ascii?Q?9K81045N6L3z02iYkrSnLVUO/TLEamuz5Iij1ACDS9lq6Ygm5ex3pjcSbAFF?=
 =?us-ascii?Q?w1Ykq1WF7Ga7b/BbZuNo3amLTLPDeipkfLXTCLDWUrKJWVoFIdbHH1FYgge8?=
 =?us-ascii?Q?bVFPRZEaBLqGjK0VGnloOoVVEjBu+UXSAwEzM6TOG2ESoDeddcVFQuK7iymF?=
 =?us-ascii?Q?Uyn02EhDmuzMqI7PhnOOLqg//wyYANxLCO7H1SDXZ+Cu9rLkDAQfuK+cR3v4?=
 =?us-ascii?Q?d55HYd5gmaLaTTYFqm22ba3Ilgx3mY6/tuxLIltuunhTYXBc6p6med7FHZr8?=
 =?us-ascii?Q?qPzMyQm4uI2EPA51l1Cis17S3ohkxutydJXR8DzZRqPmpJgGxTm0HJjajRWC?=
 =?us-ascii?Q?YOSMYdD1ryKcs091JRLKB6KKG2PK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNtGVwAEztczddiTtaopp2d6Iu2BpVJBQ/I5Rri4C9GwKJ6HtmOo9Jg4KMP3?=
 =?us-ascii?Q?5KdLL7xPN2SVieSFJmMNRG4a8HSAZifeSMcA7Zwn5nFZedNsJKXf0LU+5Nb9?=
 =?us-ascii?Q?iy3My9Xbl6utRBsBccZwar4lbwakM55KKBNie9lkqk+4FphLkKbZKrQzSNo1?=
 =?us-ascii?Q?rVcG/zDJaS37HumItDR1I0oG+ZNRC9n5zHfGJ8zx3fUkR3XjmJWcqCujKKcl?=
 =?us-ascii?Q?du81QTa2XwYH6qBiuSqITY1444ZrDf9P51wZph71pgHo/ad9ud6v0KLR5dNT?=
 =?us-ascii?Q?emtGgKsLho55CCMFnibwtF8GHqK6d6oOvahEoQYEP8ekr9UEqhJ4xjh7FY+q?=
 =?us-ascii?Q?M2lE22j1+kvK6Pr9tR4O80UGwQA+B0m+jq+E6lYxL7PCVQlptgz5e6fqeaBw?=
 =?us-ascii?Q?+epzFi3oag2HlmhhzpyocjdSFvhTssneq3lL7nkCmtddsS8OWWEmH9+TF4oJ?=
 =?us-ascii?Q?G8yVN7ECii7WI26ZB0B8t8uYgT3bp41M3QL8a0JgQXeRf9scN6f5L6Sz119v?=
 =?us-ascii?Q?UKwRWfEIhCCCveEmmq6jCRs3n1YpGGdcPaxQtgyKlvm1rN5KwZacB8I6MlS9?=
 =?us-ascii?Q?DcEAVioqiHpOkrcs45wCalmbwnMK0y4hUOBSkIqQiJ/UZe/gtH7Iw/qBg4D5?=
 =?us-ascii?Q?cHDllSVSUeevhgRrbu3VmZhuU+EiILDRNQ19nootrPUwO/LqN+ibGftPSnyN?=
 =?us-ascii?Q?MBZ6x1vE54yk2pP/TPfhnp7J/oz6MTo3omTGmEiaN13y9DyM/bYKGp2DnTrK?=
 =?us-ascii?Q?UWqbRt0NSoroyuhgPk3Qd3x1c7bdKj/4FhANN3FR4ADTjgK4wvxaVUJV4YDl?=
 =?us-ascii?Q?3CR6c7fHLmjrRBRfVdRpg4VWp1j584ljUw6QrqpfIJsmpCP5JH44a2FPaMbq?=
 =?us-ascii?Q?si3R/TvpghR+FCDFdh0/ZYWDD3bLKyh9Y0vrq8kSIy3zXr5oVgQobt+Sf8Yq?=
 =?us-ascii?Q?tS4OimGu72nj9Cs5JOrAdKpVpPSg+ezt0JLkyNy6c/w8vCQRL4jhcJzEUJyz?=
 =?us-ascii?Q?Ve7zAVvoUw93cC3XDY9A+OJkhnhFPHjRQlug1/cko4W4ZjEL6pXikhRaZtqe?=
 =?us-ascii?Q?GXf3F83YNEI7zAJHHN2+qjVIZczeISmSpud3q/bW+nYOKobr7C6hH1deu4tI?=
 =?us-ascii?Q?hdJI4oOB8YsgQanGo59ziM4lAz2bKFH6/ltHARZxPEfJm6PNgsUemNQtqeJW?=
 =?us-ascii?Q?tCyAb5sZPDJ9nNIO/SVRCOuszjwQuXWQtq2SmtJLZPx/AK9QdsmihWHiZcS6?=
 =?us-ascii?Q?MX1n9CkCx79YVGopLRsuFAP5IX4Woasf6emvL79tNZCvatoickYE1+dJIkuR?=
 =?us-ascii?Q?V3fkqMqT6HsagOH/IftDH1WnEiA/Nod8SU5sazQFCCUsrVE7McCPRivS5z76?=
 =?us-ascii?Q?4AVsoKgjn3y9QZUbMN/Yr8QcNQaFMwFlStNq+xs0cSh9Q3i6aavfAbLaGn/T?=
 =?us-ascii?Q?K5AN7NFupllr0KjbXqpy5FyfKmsOoW6dIJKeuSUrCFShOxjnRhmPDmhthjK5?=
 =?us-ascii?Q?6bFxdrB+dUJVFKBHiLrxvqTzM+3F027HKecEbuogQYJQ7ubAybQc5hoqeHKh?=
 =?us-ascii?Q?mBP2V9FD9AqEANNywDpYW2AagRjoqCQ+OBcv3bML?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12353a1-6f1d-4926-cfe5-08dd4fd04414
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:47.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf+2RK03/lUFDfj1c6y4wDBRDFTnqpjE2yjEas7qBQ+ZhNT6GmmNHf8MJRHyUbxq6RB/Rxa1SQ8QiJ999d5phQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field must be common to all pages within a folio, even
if the folio spans memory sections.  Therefore pgmap is the same for
both head and tail pages and can be moved into the folio and we can
use the standard scheme to find compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v7:
 - Skip ZONE_DEVICE PMDs during mlock which was previously a separate
   patch.

Changes for v4:
 - Fix build breakages reported by kernel test robot

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 | 12 +++++++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mlock.c                             |  2 ++
 mm/mm_init.c                           |  2 +-
 13 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 04773a8..19214ec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..61899ec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -205,8 +205,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 369f76a..6f2d6bb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -130,8 +130,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -300,6 +303,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -338,6 +342,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41..8aecbbb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1158,6 +1158,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1173,7 +1179,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1188,6 +1194,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 {
 	return true;
 }
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index e4afca8..155b18c 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index d337eab..905ed2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4316,6 +4316,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4340,7 +4341,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 5bd8882..6771893 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076f..3cb72b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6be9796..d0b5bef 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -998,7 +998,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1

