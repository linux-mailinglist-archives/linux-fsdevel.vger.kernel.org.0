Return-Path: <linux-fsdevel+bounces-42808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B4A48F4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8001892843
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C461B87E8;
	Fri, 28 Feb 2025 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiWqxJcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF91B6D15;
	Fri, 28 Feb 2025 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713510; cv=fail; b=jqHo0qVGjVEwP9p5h6xiH3haGT0us0on73hVinKV3BUzjn0OAio5eUy5xlLraKAs8ODrWr34QNg8vGWU9TdZFs328XaF2/MuzeECud7MXJdhPyL5GBvw93sCO2mH+r9na+3EMwBDuUo6VJc/+eMs96+EavWifM83qrjYng7YgNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713510; c=relaxed/simple;
	bh=PLnB2Jfrxt5Lh68I+ZZ00/WtZe6QYvPx4nB6vNbyasY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oh4mkXu4pUZp0hIvjyAY893PDumQjPSUvSTa1ETIP7yqFBqCXualdPTBou2yEznscfC/gtpm8Ty/e0yxtunZO5PORxT2edizP5ie9HCjUYDrwcqCeLFhnDzbvsPbpS/EwjmguEAV6WZxjzW9l7fN7lBc/+xr8vfL930H+0Y0BnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiWqxJcF; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmQMfIjh+N55liiz82JaGx86lsdd8zIZQcsD1fJA9lys5tGE+6wcRag2lV+eQWbg95zpKNELfsDF54L1pgMTbu16hVgo2bDYlEnKU/n5QGaMvNLuAzqmpzO7OPDWn6yvNwJ47bBuXur8h2E3sjJ31DkZfmHB293gc2kCKjiPbserX9uYXmiRmDv5BUZYBY7hJMMF3eATxMQH5eJY2mZ1pBuSBhswAd7cEkCJNM5hIQ1tM+J/lw3P/vGlH+PvYJtBkuN+vqP4toAgTTkSRlzHiESMn8ZXgWjibBSNiWxilQ4j5UuhbbOCxcxjKjDG7g/PyZI7tngNA1dMiAXCbQ3J5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZjp39mH9a7emt54vkN8geCoCp5VBgqHEdOopdg44hE=;
 b=CNKwazJBYtgGJLxeoArSp/RjJfJtizd8/VBJShLj5NIQ0kCRi9fJRZjC/nveF/SgBCa1wjKrKWrtMaEBdt1WO9AplNNTq2E179djDFISnGKx1vnErXY6QVrfiHmWOlp3P7tts30ETiBwMsFdvYOYnXLIHPtv2n3Lu3Vrl4E0womL6RHrfMlqa5WJA/x49D7F8JwU0wPpeSpTatEUU4JUxlyteVXKBQxg3kuIKGJCXtmBAdb3ABrAlTKQV70Y+FpfQ7ar1p0ZVl+TmECMNIKx2Y8/Qi3w088/Ln4Lq0lFgXcta4dIP+ZKEgQdbkF8oPGXSca2FI4f1vXBjvG34gSsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZjp39mH9a7emt54vkN8geCoCp5VBgqHEdOopdg44hE=;
 b=SiWqxJcFGzeRo/kDL+TR1QSIDjroMF7qkVQZDOhBJgwNiCJXmIW1iZ5/X9mpHcnYpeOSuuce/wU7fYQHO+QOxtu8t30G0okHiXiX6gNwJBm6siTqBJDNurx7LQOs6S/IBJUE6ueSoTAkjFd15bmRZU0E4zceCgvLa2BU6KD7wVxne5aIIFRipwQ/jqhRQi9qLqFBC74/IJ+Ra1PWgWtRAWE/7rMivUPmBuirOqslN56XnXowyPm7ttesXKKz7OlYPrnZTTkLZkKJBJQSM//XJnMTatPbV3CBgyrkpbKWJ5c0DUSFB6L9EWrW0ryNUdy2Sturdvp//6fI7gK54shW0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:46 +0000
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
Subject: [PATCH v9 05/20] fs/dax: Create a common implementation to break DAX layouts
Date: Fri, 28 Feb 2025 14:31:00 +1100
Message-ID: <c4d381e41fc618296cee2820403c166d80599d5c.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0059.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd4a13c-2b2a-4015-8a32-08dd57a86d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAs061k8MhsthjQfMI+nKOKBVyVZACYxHLXDvCqhblEewSyIEzwSIVVx0BhC?=
 =?us-ascii?Q?pprGnt9QqQiTRe37cO9Y7fQFOIZlvXcXUGB0FinxrxokGiHdRe+nkplLgA5p?=
 =?us-ascii?Q?8ZGOMEQRyyk49uzC9ul5Nfckb6O2sm/QZNSSLO6plFIiXDKmvLIczpWHSOnP?=
 =?us-ascii?Q?cyeSvRrq0xo55KsID/AaskWfJMmA5lUg+QFEc4ir0WScd15hoVBTE5UIW/Zj?=
 =?us-ascii?Q?Xn95YjLH9t4SOrNhflgg4thRw411eiUShQHgLh2Irop0BJuNm/SuoOihyClp?=
 =?us-ascii?Q?QmyvzBfBFgBtcC8S84gz/3BWXoOUqdmnab0yucJOcUPh50drtYuFkzBNyDtu?=
 =?us-ascii?Q?fsR4QvXHaCmmCTm1PlhtpWhQ55yVE1ryRnPnwukJd6F4xsYZPAkfJSWQI0ID?=
 =?us-ascii?Q?N1Qt2vxnNsQ0HlOuCD0azDiLGRIkMf9NaBaBFp4FKvH7gm15jJXhdKDE8bc7?=
 =?us-ascii?Q?EVEa0P9G/M0/4cna75HHCL/M5r2V3DQ5TxrqZPSwkTu/QeafQHUEJmrmVHha?=
 =?us-ascii?Q?dw4KjOZvRdV6oeMYAKKGzzFfq7hTCqKC4PDcAqSbUuxCwOM4tKNk5APWiks7?=
 =?us-ascii?Q?6mdiMauJPKqiHM12tlb4ExSf60UQoiszYn7OF+1ys1FyFARKM1aGqfK4jv5F?=
 =?us-ascii?Q?byqlY2V5soAgwyO4oKwz9fRf6b9PBkyXV/Qr6boRVSPZRP/v850yPhOPs5uH?=
 =?us-ascii?Q?g7oMoXrzryGLgQfpwAoVh20lrdBtSmbH4jEt0dwekSmKe/WZqDSKw8uUmA0E?=
 =?us-ascii?Q?hrsO/laJuQ0VBeYhKJ9JOopS0DQu9z+6ovDVe99DsC/I4uDbix/Zunxp1Sfk?=
 =?us-ascii?Q?t+YOe1cDgh6c3a37TfZxM8ig2n92qTxhvECKW4rFacbG9rTei8wMk1e/gvEc?=
 =?us-ascii?Q?LMtjxkuwKW+WnayGWCCWrK6xfMEGjo/h2Gw216dB+jSjZGPCvIhUjUWPwezj?=
 =?us-ascii?Q?WgciPa23PjE2yz6LPDkLaqvF5aX2YpzbpBWTM+SQCwV68amcrQJGkWA8lSPs?=
 =?us-ascii?Q?S4tRYH/U/GKBF3Ox0pTT6l/NN5Aj+VKJ9veL0NDB9DteF55mfK/e44Uransw?=
 =?us-ascii?Q?M7s1yx+HAi3tykeJVKdc8kBk6/hsFZO/TFdxKD/aP9SFDmZHJUM630es3K1c?=
 =?us-ascii?Q?RFxcN/TseQHjtWmJjWIQioj0LjKfYvHFUycjjtA817WgroIP+eHm9XQoNviu?=
 =?us-ascii?Q?YBGWaLsHY7YY7Ke8P7MVKzFC8LbEQxvqX6d/1CbSkrVERUMUVC/4IMwJp8XO?=
 =?us-ascii?Q?A5KZ3e4WukrUxI//j5PpBj+fLP3tOgS92nQ4iI1bkNCLuon8r3RPqf2TZLTr?=
 =?us-ascii?Q?gIsX3WrZ6XGn82lObzlmEehbFZ4kAP54IcjzKWdgqMzbs/KEpdfeJyeSNjd9?=
 =?us-ascii?Q?ZeOMOAaryPFQQA62M6kHbRErjVuA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kLcM0zHZSj1N2SP5r1cFCyqRl2FBjF4vMmRhbXYYr359HyCTqdY5u9px1Oy?=
 =?us-ascii?Q?Kk2HLvhwCtC2ds1dLJKKap8u7LtRc2cbzHpTUyG7051pN/d8a9PexCU+lgrf?=
 =?us-ascii?Q?BiWf2Is/z7oLItLLcGzCRaadXXDpQq5TQ37TndttkgqARqxYiZ/uLc3o702K?=
 =?us-ascii?Q?ykIJ3eV/TxQ0TEOBLtLy3U4g26KWeHrIN3NgVirJvAHarhAzBcWd5vQNKltf?=
 =?us-ascii?Q?6Rm+WrJWUGyKr5GxkMemqJtrgaREZLYGkQ0aN/8DN1D4ycDXxxhSLdgRiC8M?=
 =?us-ascii?Q?A0a71R5Xnk8dBLUtOhgJSnxoWm+xqPZql+1YXBvi8LYU4eT+lrcCOrEYbul0?=
 =?us-ascii?Q?uNlsLxcadZOSlptrUpxU4TY+bGf1mOtKgHunmhH9xjDim6+ZTVRDFvKaLxBZ?=
 =?us-ascii?Q?BYEgZ3fIZ609DJ74b28CdpD04OALcbSzAcjIxrTluxjYNifJMPh6gbHdfixt?=
 =?us-ascii?Q?GafNNYQtkoS19KkWAoZ/UZS9HceljnJZi4s3IqjzwwCQW/jDKeLyoadbqYlb?=
 =?us-ascii?Q?v3a3osxyBStNvilvGe9lzWKbdlTQCkodAgWeDpZj1l/U99Gq6a/OmJ3Ca+Sj?=
 =?us-ascii?Q?qbLXvKoM/nrN6cJs5fk7vUKc2M0XdGQ5waVRBMImVSIWcutAkU2rpWswBww9?=
 =?us-ascii?Q?9U+wecMeBI36fhEbjJ+VtttB01m0SuYexTfKxyXpXU6Jhg8kchacgtouUoii?=
 =?us-ascii?Q?KsBVyqLPpT5KKwLiL0fgNXJEPOsk/bUt5Q31/7xsnhn8hOvONAD1esR1M+7j?=
 =?us-ascii?Q?50UdS3YwE2hD8oZ0ESEBVqH4VGmo2VafYTDb7uZVFmpVqJQUDKgC+kKQ23Yz?=
 =?us-ascii?Q?Le+jjjdT1YIT8NXbphSbtczKbxQnl3YCbWymfH+gqkzKHHCX+DCbCGajLmHq?=
 =?us-ascii?Q?SVaLYpnSodDpkZCDfmZWza4ImV1POVG2a6PKWpc9dXbQ5iarX3Q44M0QAtwy?=
 =?us-ascii?Q?XukIhms6siZLaemNVYM5o3WYFKsuk62hO/YxBaByqVzigDm4mml8RnbHtyqy?=
 =?us-ascii?Q?hl5o+KM/NA7mKHoUh9hbhX5tN6VmYdSeHj93V4WZU7W6oL1Dc5xoHW4b1XlS?=
 =?us-ascii?Q?42K3NNlCSPFQgUVPEn/XGU+fE+Z2AfDa0NmF/AoS/n6kN5xjuyi/gRljvcqq?=
 =?us-ascii?Q?DTFCkAk6Ew54rkEtuYQGcP1lcvQm7nzw0PT/v5ZPoW+0I4RzyhZkcWIAukmq?=
 =?us-ascii?Q?rW/6OIvjZ7uCuTSsO6cBwo7vxsWEZVkLhN/8FfgD4+pXfc0e6uCmJOy0F4uE?=
 =?us-ascii?Q?mdewCDvPyN9AbeG8DOl7uMNZ0BNIP3lO/jnCvLQyxVrjvdQ8FScBza8eklBJ?=
 =?us-ascii?Q?ubFhpxVeOW4B5vDeGxBWzFlA+nh4P9kJC/Y28d3xG/Eo7pV205pJABshgzuR?=
 =?us-ascii?Q?pK7dTPXkKf44+x3De/IBcI8DojlcgFgOyme48w9lMLDQcT6HDyXN5EXbc2iU?=
 =?us-ascii?Q?QGg2ziJQn7Rdsfx8jntF0SbcBpPVrPRmtW+o9W3MoDf7QYkdoX6GpMGsB499?=
 =?us-ascii?Q?RIl9FeWl2H20ShzO5mRdT+KCXksb5Qq1pNJ36WUyeGD+zy5abr6gXn6s1vE/?=
 =?us-ascii?Q?Uwx/9MsJPt61s+59B94kqbXHN7M/cfLMqh29hUTX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4a13c-2b2a-4015-8a32-08dd57a86d7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:46.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4vmBq/SgMpwoa00+mL7irn/zE/7UAXagxbart1ho+HHmktpZgIkCV6X5IKSNOvZ/nuly9/wXvE77LXZRE2kgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - Fix smatch warning, also reported by Dan and Darrick
 - Make sure xfs_break_layouts() can return -ERESTARTSYS, reported by
   Darrick
 - Use common definition of dax_page_is_idle()
 - Removed misplaced hunk changing madvise
 - Renamed dax_break_mapping() to dax_break_layout() suggested by Dan
 - Fix now unused variables in ext4

Changes for v5:

 - Don't wait for idle pages on non-DAX mappings

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 13 +------------
 fs/fuse/dax.c       | 27 +++------------------------
 fs/xfs/xfs_inode.c  | 26 +++++++-------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 23 ++++++++++++++++++-----
 6 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f5fdb43..f1945aa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -846,6 +846,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, dax_page_is_idle(page),
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error = 0;
+
+	if (!dax_mapping(inode->i_mapping))
+		return 0;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dax_break_layout);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..2342bac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3911,21 +3911,10 @@ static void ext4_wait_dax_page(struct inode *inode)
 
 int ext4_break_layouts(struct inode *inode)
 {
-	struct page *page;
-	int error;
-
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_layout_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index bf6faa3..0502bf3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -666,33 +666,12 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
+/* Should be called with mapping->invalidate_lock held exclusively. */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
-
-	return ret;
+	return dax_break_layout(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1b5613d..d4f07e0 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2735,21 +2735,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2764,7 +2760,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * for this nested lock case.
 	 */
 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	if (!dax_page_is_idle(page)) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
@@ -3008,19 +3004,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_layout_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3038,8 +3026,8 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			error = xfs_break_dax_layouts(inode);
+			if (error)
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c08093a..123dfa9 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -603,7 +603,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..a6b277f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -207,12 +207,9 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
-static inline int dax_wait_page_idle(struct page *page,
-				void (cb)(struct inode *),
-				struct inode *inode)
+static inline bool dax_page_is_idle(struct page *page)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
-				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+	return page && page_ref_count(page) == 1;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -228,6 +225,15 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_layout(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_layout(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_layout_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_layout(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1

