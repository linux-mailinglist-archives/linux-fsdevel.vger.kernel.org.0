Return-Path: <linux-fsdevel+bounces-44134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F7A633DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF0A170D23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31955157E99;
	Sun, 16 Mar 2025 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Krz7tgQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BC1624E6;
	Sun, 16 Mar 2025 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099407; cv=fail; b=pm6eIUCIIMJW4/aSWU854xznrDltMY5MlkTK9cv1jgokYBhIPtjXsTcyBN5JzOYd2yiBaLM+tYvpCa92f3wHmbIvtgLnmNvrEFP/slYBuCjlF8eVyECw5MFfCtDvKJTbiEBqI3H7CogiPq+F3lUiU2XUyAY0HibTZiE/5O8qRcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099407; c=relaxed/simple;
	bh=XfsO5yMLNVQVUHDZJCai5Rd7qTc8PTJYeiSBBAXSfdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrRdTaEvWN23V3CcLaLQF+QoVxd+v7pOGGJUa0qvbX6h4m4QL0xV1abnNSVJKxgrM6l6xtZFsGJ19vIIIZs4liQ/7qqh1NJ+c8PCilz4IPm/kk5Ibn8ISVgbijycKtKhn8BlyohaFCTLIBAteA5JeOW95N8UU2EKcBwTa4Ifurs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Krz7tgQz; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX7eYKCdE2bL7KkhLd9DAPRFrxOdHvwDQkoCO5Xh+Qw0caOKzT+93wTgDtVj9ZBDxPxo9MHquFRvUkiELIcbXNh19CpxYfCZlGbb5eaDjQ/J9y9RH2JILRyflqm50AI5AFwH7D3N9d1DEZk/g/UzjDsLdXt1oUy0wXohGACmsGvmX5PKIRMptr9d2y3GilKrHDDKVYRXlsJV8SVOOrOUj7Xx72ANzweLGRrEy4K5EZLvur+52St4cKF9+f4qO/hrRJKsnLACjC+61GF7QUet6uOj6yGE/VrzJvkpjhQJpzgZYnj1bzNqKFKOvEAoOXdQH+Pdx0z4P0dFU8cSG4CH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgRT6WueUkXEphwCJUp8cua2k9wyzPo9pbza8QRm0DQ=;
 b=bHhqUYe4+y7rDFmLoVeK3E993oZ7tH6LiQ1oYlXuOloC1nmnKC8/Is96dmQY0YibWP4Lyj85BhRsNlZ/shcn0WNKBwLNXOAtCJBXJ2sufcPId+Gw1wy8RYnS0+7hMF1B1xb7z9USW7GR9kzmwx/9rXWmWWP+ulIaUHRo5huTGYSvjquINRuFkVSon1o7iRI0lmuKWmLZxO8wFWedoUc3wLXWmghCPRQGNhUcQM7dhF/JtKJTBg5Qt3lBXIYXhPr3IGaeix+4tR/7tE5oNDusJqTgCBeX7hILPBM6tEQ/zYVaLAAORT+/tVe0i2wrWkdp8YA+7MAuWMsgTuIyDk08FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgRT6WueUkXEphwCJUp8cua2k9wyzPo9pbza8QRm0DQ=;
 b=Krz7tgQzIr827ehFY+3u3Rxfqr6NuflRpAwALqm+yw1rWKD96eFOD6CZgh4xtpF5vtKTiIJfhXIgY3QqYBZnHEe+nHvydd+YXPnP7WipGuOOdiZwg8p51i3STAU7ZzTK2jmXmSwhkXlSLgtCbKZgVe8VUSXzU8f7zlVFh7Flzm1NPxw0RvJpXtxN5mnvi/mxrf6gYzxLGXZTHQTW46BS/fwDnnbhnWBffC20nwCn+u6eDazdfNW9rNOdwb7s+CzINh3vbVKC4p3wixAqnSelwWwYD9372E1wgybdE4RpevQs6zXLAXJNsgEX2Qo543LqtLrItI63gZrZw0sj8DemBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:30:02 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:30:02 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 3/6] mm: Allow device private pages to exist in page cache
Date: Sun, 16 Mar 2025 15:29:26 +1100
Message-ID: <846bb6f8a3077ceac767002a88119adde2e86491.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0058.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: e1851664-a826-4158-bb4a-08dd64433804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gylJrbRE1Fngn2PyPKYO1KWoaV0nk/cAiXw0kdE7Xzako+RcGOURbYMg/goI?=
 =?us-ascii?Q?NAD5tfsXGXJC9Kfe3+DiFP/kPWUXvaE0XNgPEHBtpUg+jmV5pAPEvPeK8td6?=
 =?us-ascii?Q?ZdltW2dtxYvZKhKjUYe7tFC1AmeD5hXzo+1A+/O2NS8itrqLn24qJKs/E78d?=
 =?us-ascii?Q?n7+NsxOIAerYX8Dxv5cepDlxOYCb8LcsMoKfZXliG8m7cQlHcEtBbelVvoqg?=
 =?us-ascii?Q?9b6EMtlxCRzr2Y9Z1dc7tAPmHeihJXi+QDjgAwZvK0OpTfjsi8oCAt42VWX0?=
 =?us-ascii?Q?jyrMiOfKajF0QKYbZoDQHlCNfj8VvVclhEwC17oJN93Qssv7K8JDmIax2dcB?=
 =?us-ascii?Q?+vwqOFf2pHhT9yA8e/I0jgRbbTWK7fdqN2M1MYp2QxBtYrXY3WLWcm8CWua+?=
 =?us-ascii?Q?KryU3ZMLycIEafVo3YeBEfFIs7qmB7Jn1lFng907+LQojZZVydng1G2P5b2h?=
 =?us-ascii?Q?29bkmgaWUh3KNCjAWUNl37TZHoFoigsyHZo0Ujohj2nXjBTAm+e62buBszBG?=
 =?us-ascii?Q?GoHW2ulzG4vCEu4F51rFjJd163HQoHU/vASXlqKWQkEvYhdWnis3umpknQ5L?=
 =?us-ascii?Q?C6rR/KFULs+k5LcJB0ffT/mCReIcnEVFVlztjN+Kiqif0661ykR7Vl5pQaf2?=
 =?us-ascii?Q?OtYC7CqMIbSw4m28XsOUW1HOgqEQkBGu8/c3AiBxGG2s2fVyyzLAf/lsPWas?=
 =?us-ascii?Q?K9eWn3fMLDvVqrJmfV5Z8hVSZPG1/0sIxDiVWDIsx6qADMXc26ra/xU8UBYD?=
 =?us-ascii?Q?YNzW0PUvCGPR9RwKWUR302vv4jMcuKDfPCz+tobzakKf2eYR/JDhHBlC6xYP?=
 =?us-ascii?Q?qpLPuUA9+lGb0gMhIhZR6iL9D6kl27+nK9j5gHqXGK+iRSZoFf0lZ3N3Rbr7?=
 =?us-ascii?Q?Csa1DnM8yD8/uk5VLEbf0d/tUvb/yLPRghh8KQhl7KFYp3L+RXpJZOgj1vdd?=
 =?us-ascii?Q?C9PifRUox2VFmGEPM57QY8oGYFDAVjECAqqKowjI+2cdEOz+rYh8MDiinHWh?=
 =?us-ascii?Q?JQmefR+Hg+a5Lcad+Pqw/pV86mAhdR9YpajdGRFS8LJTwLuIdA+FN8DNm6GX?=
 =?us-ascii?Q?w+47Eqewyr2GQlKm14AUXiCKaK6TaNTunvzwwiutNN1mhP6yK1Scmkm/3CXa?=
 =?us-ascii?Q?WcPvCuKHxCPgHeUdrbs68i593hWF3zm2SP6qs8saiAvu6fJxddMkj/pU81z4?=
 =?us-ascii?Q?Vlgb+vaX7T1SyGOGtLRM7z+yc8xLR81ENvMVePktbrH1VSCYD+hYozCFPVo5?=
 =?us-ascii?Q?1BwISu0olL8p//s3gGhq/7x9PPICPKjckFDy6BIiSjpKKz4ydG7FrkrJcp9n?=
 =?us-ascii?Q?NdKTKFUQJEclCgu6h/17BVt+9AOAXCd5/Vu63Ph6Hjk5UTZRNGbO2MjPiy0M?=
 =?us-ascii?Q?hPKmY8V92dgndplbvThHyU8bWNaH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iOkFIZnBDwfQ9xlvBe8dh65ivII9ovIk99u/Q5MA7nUNPmnVV0zy/dFqiu4m?=
 =?us-ascii?Q?V+lKSFOiGa5JbUa5NzB9qZRGW8YYU8cjceDj8l+JMoVNIp7Gh6muPvoYvQDZ?=
 =?us-ascii?Q?d5hRHrnYK3QEspoUeN3nq3s46b+moQHB+bf7GQ6mKxJ7lSMnxFwrg8rktklO?=
 =?us-ascii?Q?MhHhUzZuL4zSR11inMnPGFPGKrM9v6Kwoak2lREj0BZiwpbelZmLrMm3rB5l?=
 =?us-ascii?Q?9kDgYlPDtNoYO6XnDyzgO8r0M0yKan4zNGJuTJCDho9Q1ig8TIqMui8W7r8Q?=
 =?us-ascii?Q?DNv0qkmsDxFt9O7JKtV1B0NhADQnt7iXUq322zsnP3fOIUzUs68QjJk7/CHZ?=
 =?us-ascii?Q?FLqdQo9zo2WDJDcNnqGw8fn04zkavumMplBXzmLER7+BjRCwGIvCE9mMamBs?=
 =?us-ascii?Q?YLi6GtCaR/hXhnQ9KXR63A4Qdbdr7LFFDHSouJGkVo3eflYmB3zWxIjSXkuK?=
 =?us-ascii?Q?9aPbv2sPPVUAHwab/eIbtTf8mS43LhqOkdxp73dpisyxaVe9k5AcwcxbGwrm?=
 =?us-ascii?Q?YNwUDBWhbU0DK6qH+HQfAU0bHL7s0Ah+RpzseuL97UZKiDLU89u+HtSEdZ6z?=
 =?us-ascii?Q?FaDaWlmaV1eYoGPKnSVfjzIA55gLljrqJgLEZl4WDE6KDXLNDpiX/vTLG6qS?=
 =?us-ascii?Q?M5ZwUrDoEs5k2u75o3G8q3k2/wfr3grmj1tHLkqVEVyIqIQq0Oez1gBzl4In?=
 =?us-ascii?Q?enQYo0w5ORe+rovL4Z1/KTFTzI3ScZS/Yi4BrfFkl+tuq9igv9NSjoNg8GO4?=
 =?us-ascii?Q?b7fo4l/Cno4sjn8hKvpahF3SivHKMlM0JLZFts/k8a+1bYrL0VhpywgPwef3?=
 =?us-ascii?Q?wiP2/57axVmaMasF6iGh0g1A19AYo0QghRBFMVLPf3gqmPg2ya+2vtsXKLoL?=
 =?us-ascii?Q?m+IWlc97ZSQDVOQp5CAEyHTuiWsJQ99+7dNBpi4hfkiTYZB2V0gAsaowHtBz?=
 =?us-ascii?Q?p7lLe93BwdjTV8fhVj23uIjI5PBkSpi4LZWu9MeUOWamBO8RnmuMZFQYjcJ0?=
 =?us-ascii?Q?lNJkMWmaQ0AKchGThogEUn7bNBPr8kXAcqREwpHo4vlcWMbEqQ10EYJzdFmC?=
 =?us-ascii?Q?R078P24Q4XDCNqcaFkvGQuXppXJ6+40LFUOFYAvThtKe0uaCrlT0u48oIYzr?=
 =?us-ascii?Q?deYq564Nyu9R9LmwycLddIlgV8Whn2icH99dZiIQ55vkxBo7jxyAk1WTjORB?=
 =?us-ascii?Q?e4Agc91ElDNapsvUgZL1NkRyeAlyNPywaL82onZ2XuhVjCArVSOizEMidM1W?=
 =?us-ascii?Q?7TXI7vSrM+okS5dfotJnM+0eZ68LacxUFd8SJXqcjNkWIF61sd1UVzwGYOfD?=
 =?us-ascii?Q?iu3X1/YkWnz7+1AFfK4QEoF2Vta6vY82WEwsO0T8SnKQhpP8qkWxIhzAuHq9?=
 =?us-ascii?Q?3wgjmvAcxXP9JXpBo6Ubt0EcNx/XvG3EzUFGQkWCvPaGLGF+dLOgwOZy5HZ+?=
 =?us-ascii?Q?IAiKQnnwEjqicr7azzW4Di/QcANjw8bahNrH5oW5UqTSmVg0FREaq63e0Swh?=
 =?us-ascii?Q?4zVhwwE/iTQ5+wRsMC52Dm75Zc+YKdOAJyq50ARAfnee4IWm9uhw83uNb+DM?=
 =?us-ascii?Q?0KBri2DLDWBVP60nOj97DL/MPJnuwNeDA8LbA4mj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1851664-a826-4158-bb4a-08dd64433804
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:30:02.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJP74SKwaVhmf8RSCNMJ4sHxM1YguYY2wXmp6vEK1uNiN7nyIkgoa1tvDX5x18JELFrIee19UQnd51b9hKhoTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

Device private pages can currently only be used for private anonymous
memory. This is because they are inaccessible from the CPU, making
shared mappings between device and CPU difficult.

For private mappings this problem is resolved by installing non-present
PTEs which allows the pages to be migrated back to the CPU as required.
However shared filebacked mappings are not always accessed via PTEs
(for example read/write syscalls), so such entries are not sufficient to
prevent the CPU trying to access device private pages.

However most other accesses go via the pagecache, so can be intercepted
there. Implement this by allowing device private pages to exist in the
pagecache. Whenever a device private entry is found in the pagecache
migrate the entry back from the device to the CPU and restore the data
from disk.

Drivers can create these entries using the standard migrate_vma calls.
For this migration to succeed any buffer heads or private data must
be stripped from the page. Normally the migrate_folio() address space
operation would be used for this if available for a particular mapping.

However this is not appropriate for device private pages because buffers
cannot be migrated to device memory and ZONE_DEVICE pages have no where
to store the private data. So instead the page is always cleaned and
written back to disk in an attempt to remove any buffers and/or private
data. If that fails the migration will fail.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/migrate.h |  2 +-
 mm/filemap.c            | 41 ++++++++++++++++++++++++++-
 mm/memory.c             |  9 ++----
 mm/memremap.c           |  1 +-
 mm/migrate.c            | 21 +++++++++----
 mm/migrate_device.c     | 66 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 9023d0f..623fea4 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -62,6 +62,7 @@ extern const char *migrate_reason_names[MR_TYPES];
 
 #ifdef CONFIG_MIGRATION
 
+void migrate_device_page(struct page *page);
 void putback_movable_pages(struct list_head *l);
 int migrate_folio(struct address_space *mapping, struct folio *dst,
 		struct folio *src, enum migrate_mode mode);
@@ -82,6 +83,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 
 #else
 
+static inline void migrate_device_page(struct page *page) {}
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_folio_t new,
 		free_folio_t free, unsigned long private,
diff --git a/mm/filemap.c b/mm/filemap.c
index 804d736..ee35277 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -658,6 +658,12 @@ bool filemap_range_has_writeback(struct address_space *mapping,
 	xas_for_each(&xas, folio, max) {
 		if (xas_retry(&xas, folio))
 			continue;
+		/*
+		 * TODO: We would have to query the driver to find out if write
+		 * back is required. Probably easiest just to migrate the page
+		 * back. Need to drop the rcu lock and retry.
+		 */
+		WARN_ON(is_device_private_page(&folio->page));
 		if (xa_is_value(folio))
 			continue;
 		if (folio_test_dirty(folio) || folio_test_locked(folio) ||
@@ -1874,6 +1880,15 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 		folio_put(folio);
 		goto repeat;
 	}
+
+	if (is_device_private_page(&folio->page)) {
+		rcu_read_unlock();
+		migrate_device_page(&folio->page);
+		folio_put(folio);
+		rcu_read_lock();
+		goto repeat;
+	}
+
 out:
 	rcu_read_unlock();
 
@@ -2034,6 +2049,14 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 		goto reset;
 	}
 
+	if (is_device_private_page(&folio->page)) {
+		rcu_read_unlock();
+		migrate_device_page(&folio->page);
+		folio_put(folio);
+		rcu_read_lock();
+		goto reset;
+	}
+
 	return folio;
 reset:
 	xas_reset(xas);
@@ -2229,6 +2252,14 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
 
+		if (is_device_private_page(&folio->page)) {
+			rcu_read_unlock();
+			migrate_device_page(&folio->page);
+			folio_put(folio);
+			rcu_read_lock();
+			goto retry;
+		}
+
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
 			*start = folio->index + nr;
@@ -2361,6 +2392,14 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_folio;
 
+		if (is_device_private_page(&folio->page)) {
+			rcu_read_unlock();
+			migrate_device_page(&folio->page);
+			folio_put(folio);
+			rcu_read_lock();
+			goto retry;
+		}
+
 		if (!folio_batch_add(fbatch, folio))
 			break;
 		if (!folio_test_uptodate(folio))
@@ -3642,6 +3681,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
 			goto skip;
+		if (is_device_private_page(&folio->page))
+			goto skip;
 		if (!folio_test_uptodate(folio) || folio_test_readahead(folio))
 			goto skip;
 		if (!folio_trylock(folio))
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7..c346683 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1616,12 +1616,11 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		if (unlikely(!should_zap_folio(details, folio)))
 			return 1;
 		/*
-		 * Both device private/exclusive mappings should only
-		 * work with anonymous page so far, so we don't need to
-		 * consider uffd-wp bit when zap. For more information,
-		 * see zap_install_uffd_wp_if_needed().
+		 * TODO: Do we need to consider uffd-wp bit when zap? For more
+		 * information, see zap_install_uffd_wp_if_needed().
 		 */
-		WARN_ON_ONCE(!vma_is_anonymous(vma));
+		WARN_ON_ONCE(zap_install_uffd_wp_if_needed(vma, addr, pte, nr,
+							details, ptent));
 		rss[mm_counter(folio)]--;
 		if (is_device_private_entry(entry))
 			folio_remove_rmap_pte(folio, page, vma);
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..e49fdcb 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -143,7 +143,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	    pgmap->type != MEMORY_DEVICE_COHERENT)
 		for (i = 0; i < pgmap->nr_range; i++)
 			percpu_ref_put_many(&pgmap->ref, pfn_len(pgmap, i));
-
 	wait_for_completion(&pgmap->done);
 
 	for (i = 0; i < pgmap->nr_range; i++)
diff --git a/mm/migrate.c b/mm/migrate.c
index 11fca43..21f92eb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -248,12 +248,14 @@ static bool remove_migration_pte(struct folio *folio,
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *new;
+		struct page *old;
 		unsigned long idx = 0;
 
 		/* pgoff is invalid for ksm pages, but they are never large */
 		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
 			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
 		new = folio_page(folio, idx);
+		old = folio_page(rmap_walk_arg->folio, idx);
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		/* PMD-mapped THP migration entry */
@@ -291,7 +293,12 @@ static bool remove_migration_pte(struct folio *folio,
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		if (unlikely(is_device_private_page(new))) {
-			if (pte_write(pte))
+			/*
+			 * Page should have been written out during migration.
+			 */
+			WARN_ON_ONCE(PageDirty(old) &&
+				folio_mapping(page_folio(old)));
+			if (!folio_mapping(page_folio(old)) && pte_write(pte))
 				entry = make_writable_device_private_entry(
 							page_to_pfn(new));
 			else
@@ -758,9 +765,12 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	rc = folio_mc_copy(dst, src);
-	if (unlikely(rc))
-		return rc;
+	/* Drivers will do the copy before calling migrate_device_finalize() */
+	if (!folio_is_device_private(dst) && !folio_is_device_private(src)) {
+		rc = folio_mc_copy(dst, src);
+		if (unlikely(rc))
+			return rc;
+	}
 
 	rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
 	if (rc != MIGRATEPAGE_SUCCESS)
@@ -1044,7 +1054,8 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 			rc = migrate_folio(mapping, dst, src, mode);
 		else if (mapping_inaccessible(mapping))
 			rc = -EOPNOTSUPP;
-		else if (mapping->a_ops->migrate_folio)
+		else if (!is_device_private_page(&dst->page) &&
+			 mapping->a_ops->migrate_folio)
 			/*
 			 * Most folios have a mapping and most filesystems
 			 * provide a migrate_folio callback. Anonymous folios
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 7bcc177..946e9fd 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -745,7 +745,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 				 *
 				 * Try to get rid of swap cache if possible.
 				 */
-				if (!folio_test_anon(folio) ||
+				if (folio_test_anon(folio) &&
 				    !folio_free_swap(folio)) {
 					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 					continue;
@@ -862,6 +862,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
 
 		if (dst != src) {
 			folio_unlock(dst);
+
 			if (folio_is_zone_device(dst))
 				folio_put(dst);
 			else
@@ -888,6 +889,69 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 
+/*
+ * This migrates the device private page back to the page cache. It doesn't
+ * actually copy any data though, it reads it back from the filesystem.
+ */
+void migrate_device_page(struct page *page)
+{
+	int ret;
+	struct page *newpage;
+
+	WARN_ON(!is_device_private_page(page));
+
+	/*
+	 * We don't support writeback of dirty pages from the driver yet.
+	 */
+	WARN_ON(PageDirty(page));
+
+	lock_page(page);
+	try_to_migrate(page_folio(page), 0);
+
+	/*
+	 * We should always be able to unmap device-private pages. Right?
+	 */
+	WARN_ON(page_mapped(page));
+
+	newpage = alloc_pages(GFP_HIGHUSER_MOVABLE, 0);
+	/*
+	 * OOM is fatal, so need to retry harder although 0-order allocations
+	 * should never fail?
+	 */
+	WARN_ON(!newpage);
+	lock_page(newpage);
+
+	/*
+	 * Replace the device-private page with the new page in the page cache.
+	 */
+	ret = fallback_migrate_folio(folio_mapping(page_folio(page)),
+				page_folio(newpage), page_folio(page),
+				MIGRATE_SYNC, 0);
+
+	/* This should never fail... */
+	WARN_ON_ONCE(ret != MIGRATEPAGE_SUCCESS);
+	page->mapping = NULL;
+
+	/*
+	 * We're going to read the newpage back from disk so make it not
+	 * uptodate.
+	 */
+	ClearPageUptodate(newpage);
+
+	/*
+	 * IO will unlock newpage asynchronously.
+	 */
+	folio_mapping(page_folio(newpage))->a_ops->read_folio(NULL,
+						page_folio(newpage));
+	lock_page(newpage);
+
+	remove_migration_ptes(page_folio(page), page_folio(newpage), false);
+
+	unlock_page(page);
+	unlock_page(newpage);
+	folio_putback_lru(page_folio(newpage));
+}
+
 /**
  * migrate_device_range() - migrate device private pfns to normal memory.
  * @src_pfns: array large enough to hold migrating source device private pfns.
-- 
git-series 0.9.1

