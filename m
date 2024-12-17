Return-Path: <linux-fsdevel+bounces-37579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEA9F4224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536B8188565E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECF1D54E3;
	Tue, 17 Dec 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JKHNlyXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8E1CF2A2;
	Tue, 17 Dec 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412438; cv=fail; b=VqPbTaC3FBC/edyTdUn3Ee0QMj9MLCXTZqybup1ANhN6VypicDJqdNehM3mKb7Cr5LzBcGD3BtFmDJKPxOREDG5+BDWc3HV/ELLMLahOTCiiQfgKqAd/5C8tarcPHZeLZYLuY+zijOGU5aZqCeGylqKBegjWJifQghV4AyBnl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412438; c=relaxed/simple;
	bh=71uMKoJfAPuSpHuJoU6yD3AB/iEFt585WtajzhX2es0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXCx2VE2R8VrPR6M0MMVIGMer2rwL3nE3n87UIDgkr6ItVJyELO5thbMWboSE9ALLjHv4jXwssLnnbPx3ncYr6mBRZxzwM7I5igPbdZetzIZaj10t00+6g3YF1uctNC+n/+EdwOJaSoIlm6yeJzibkrRRhXIJLA7av/iJJhqOe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JKHNlyXK; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZeDZTeS+TQgSebGS+9n5lswdsEgyXAH1KEVxk6X6a0z9vnaOknOLGTJrQtDKONakTTRYkyvb4MFb+SY95cUKK2Pd/n981hVZfvC2JcHP9AiFPnRBtFacaG1lwxb6bh6JueZL1kGhfVkFj6WP/rlNdTBptEdrKHZySCORXzhIf1p0MTbx18520MQFhuCsGqjcd8QeDKpDE2o9xmmido1Ram20i1zTZL5sx3qqZq5z21bGHZGcrnvp5h8BJdwffTWVgc8NscEFKQtj0rYsve6y/Zlmxs1SR1Po1hDaclrEwepJ4/WRBjIh4/V+9x6uoWaS6gTnrXbHRLVRss4gHIIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p0f5STc3jZ7dypfmVkR93SWOiB4Au8VequleXzSvOU=;
 b=Z1JV//oYA56VWqeOAObWm5/01TuUpsLG1sEp6NQdrNR5xuuKW1NGqDqdsotuGpB5EKxMcODSJi0EnrUrlLtmr33gaGwQtABvhbJQ4COaasyJJq0HBbJTGZWbuBzYM1KHYQZ3IpbiJipWMUWS881jaSKCBfsPRV2ANOqWKSJJyy3B3lvXDNQpN7xLZixEKuDfR50fzLQd3mdcIR7LrLpgfjTeFGg9NxgsJ+vacdT4BAR1tEdfbd5q4FMqcg8XiaSBrR7JRmkm+mQUm9G6IDfHhaj66HCsIjh+cdDlTNYU1yI5FktH5p4sU2iNG8wi5PdLIY28xPhPDgjzbT231hugTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p0f5STc3jZ7dypfmVkR93SWOiB4Au8VequleXzSvOU=;
 b=JKHNlyXKgo4YHc/Fs21PhnRUfoZ9iR9i1iXj1XcmWLNKhM0/SicRohXpSEqBN247dlU32ofSmLd3KGCwLd1VVRrZ79ixfGmYqsnvXF2Df2jLXtuCbhRFaqw/aa6MWUwfDF38ZJ/jP62irVouqW12jeoSySYTAVNjt617W4cxItLsAuw6amRFbwIQnRdPPS4oCPnOStZJoAFa1pvH9Kxsavx6z0n3cMXJE1aQ96o4RCBFDJ7ENqe6j3FcACbYLAMt4OlgsjB/EDbYg9yaAIh1ViPtnq4eX0Gagk3twSdHr+SnqBWLTBPjGAkI55Gay6EbDalEsDySjKiCDHlSAtGP5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:53 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	david@fromorbit.com
Subject: [PATCH v4 05/25] fs/dax: Create a common implementation to break DAX layouts
Date: Tue, 17 Dec 2024 16:12:48 +1100
Message-ID: <ea8d2a2dfd70fa56a32a37d595df1d561436eb50.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1609b788-e811-48b8-d423-08dd1e599990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6uAGNTVtzvJ9GKkP1DgOY/DqIfX9RK/oAWPMjmX1xkKWZPxOr2e78NrGV7yt?=
 =?us-ascii?Q?4rig3GfT6ang1ABW4RxAXMk1K9mKpN6J/lgNpR1kEyL2vqn5Lc7n7lvmh7xA?=
 =?us-ascii?Q?nnwZ+9pyh5HkCha9iFCFyh02a/DvwWWQrw3eDxN9B/pXgGG8zQ9lcyJILjtB?=
 =?us-ascii?Q?9uA4UxRxZP8lEo2MgVYi3w9bg97WyOmuEaBOVpanOIWzd/vfXZocDIEjPHKM?=
 =?us-ascii?Q?KCYZ4VHmgu1jLyabJ9mWCfCmAYNVh7+YzEuiqZv+zza8IgJI+S9x3gSBB8Xq?=
 =?us-ascii?Q?fc+TGcfNo1rLs7YbsGeDFMH2D3luJv/uPbeoY7wDfWbeX5zMLQxUTsUDVofs?=
 =?us-ascii?Q?8e65wWEA2TzZcQ7OW0W3Fd6Qm7OefkyHjRxA5y3xaC4SSUnjNLZ8L/OasB6G?=
 =?us-ascii?Q?PvLRB6FA4kDyGhsXVkqFcUqY4a7TrqKfr4a7J+iG9JqCx/LG4sP/y47QhVUc?=
 =?us-ascii?Q?Mnr+1kO2/ZMB79qQ9I2dhP2X7AH6eNxNhxn4YM69xvoe/iXzX2UmmQmCnKvm?=
 =?us-ascii?Q?ayNQ4LCyHv509SsNfO+joBdQ47O6wpRk5acTJNAoqWHK7u2XbDCWxMfAvZ35?=
 =?us-ascii?Q?YfE0S7Jn+R/yHGUAOpjafzv95Suy9ky7ErO1CHAL6ZQjtanTpjB2swATW7Qc?=
 =?us-ascii?Q?ej4eXz7D4IcqJ93pfN2e5g8WuKw8rml07m1RAbS775/3o0+cinHWruP7sO1N?=
 =?us-ascii?Q?hCmfFMMVFN+EwpIWwHomC3WtnFRlGXDisyNCKAY4baml12wfrIsXdaKg/m88?=
 =?us-ascii?Q?whEnsyZaS2iKcqw3W6wNRmCAyyPYRD5OEjKeGsF+h2KJLUA9y8X0Dbke/V1I?=
 =?us-ascii?Q?0Eq/Y/hqW5VAdCCotBIutE8Uck8ZaFybMnBBMxcUKhtR1qARRGdWtLKEccQm?=
 =?us-ascii?Q?/IuN2fk9EZpyqn/jF7NS/CfisSdEHDpOBoEtCmDTMc7yVORw2UCtXbB6WAxZ?=
 =?us-ascii?Q?Tie5PW9R8Mdfm9eALJzdjMe0W4TE/oSK/xb0R+gMiQlICB/gzlUt4DEd7O5b?=
 =?us-ascii?Q?/PNNw+uWTTBNDaK5jXXbkZ9Y7AItiWCiFzKxoQl1SkHWTs9puX9C6015Gs07?=
 =?us-ascii?Q?WZCZ84ynWQ1j2V/bXZjZT/VGV3vXREqHsUxWpwEuaJk8VDOwn2O6+qUjzYvC?=
 =?us-ascii?Q?qbIlRbW9i7S2B7vSj9VpwzhtqDBU7x6HL9oRY8su9iHOGU/m/TZXQhufxk3U?=
 =?us-ascii?Q?9uBEIgRAZVB99jJyFuqThLApbZIyWu8nfNXh2z8hQXwe0akOXKU6Oc4IulBI?=
 =?us-ascii?Q?qi3AYb/27qhw9ZpnyAHhj+a7GBbzFLsAVTuC8RGk8aVAn3L5a0o0OWH6V0Sv?=
 =?us-ascii?Q?Rk1PkFrMTJCdl7w/U1Qjq3jL4M17Zgr6Y94gh4xqZTdaoC983GkPfM811tbA?=
 =?us-ascii?Q?UNUc7kKIeIyMHzZOR0v8dEX9P/dD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGHpvSwsBn20BERcghLsY/9mt3Kqc9mST4PmYU28St7rqzgjn79qSZaOZNQ9?=
 =?us-ascii?Q?HbiRpe7Qp3embFgsANj6R3sZA7jcQPTlhh0J3LVppsC9oluyhERrxiC7Def7?=
 =?us-ascii?Q?f75kMFVEWHA7JAateP3zxdZs951fVwAJ0r7oB0Tbr7V0DMn50C7+Z7OLik3e?=
 =?us-ascii?Q?vuhce/3xl97hQ8o/UTzsXlLuYxPKrZu0DUWCTYizgMdK0sM8L9JtPwco2usG?=
 =?us-ascii?Q?E3c/CAEKtzEMGsZyDKaHWl9tXsFJGiVkBOFN+5YaWfYHTAmo3sJQOp0QBX1k?=
 =?us-ascii?Q?emqlN8pEyr2UTN6/PgbA8+USZ/n7mbGIyLagfM5DHfoY/Rt6aFRHAu2zNAlZ?=
 =?us-ascii?Q?mNpW1MGTMRdDVEcUK8mNrZjFzMhgCvmCPvpyYblybxDDPt/yk4e0XD6iefJp?=
 =?us-ascii?Q?6UTVSS3QEKczWSa1EvaPu8kKwOCmb2Xe9vvddTUpRxasljxYz6h+uUiKkQVi?=
 =?us-ascii?Q?W852B8n9GXFYtcM83pYK1V9eSMnt3D4iARI1LVpL9zjJRDDqdnb4d2mh3+ED?=
 =?us-ascii?Q?M0SFLGJAa2Kxx8auQKN+D4fUyNj+2KyDBeMEorPCMLchWn1B05hXUZgLgwhD?=
 =?us-ascii?Q?frEYmwE5vG2GumFF6V4vuo+4NrwrdPqxZ9xWKp6pTUCIkK/2R7uUbP1SEw/m?=
 =?us-ascii?Q?OcknOaIsnr2NGW0Q/jrEGCdkiWNDDD5s9qZI0AhgPf91FTGKRgju3L8DzPJA?=
 =?us-ascii?Q?KC/jDuAA3DV1YN+E7jdn4ML4LJ3hQkzofnamoZb2E5BFGMA2Ab+zEP3KJDZO?=
 =?us-ascii?Q?F/aYldPM0PfhUxbWo9+qw4vX1iDJixVkl5nhTPL5b3RxFpnCmvHBjzL8RrEC?=
 =?us-ascii?Q?d+Fdu0uaeQ5oOADCeucaaR9bLOseSbKwEkd64nLmB+OUPtM3ZwGEYE9HP/nS?=
 =?us-ascii?Q?wAd5sbF8nXC2R1QM59k7/dgKAygGte3fTj00/yWsNOWM5MkNyS8z+dGpKHwx?=
 =?us-ascii?Q?cvd/rOvpWlWZuJO9k6JkCZbrBqXNh2SvC3eeweSkHJ8EisK8Kp1JGoK2W0gs?=
 =?us-ascii?Q?PbgGb9XMjI5IlaTVXNfLen5bE/ja3AlZPlnoSFht4mNPbYAZN7Do7ja2lsXz?=
 =?us-ascii?Q?9VgN+vSHL26gUMhv0YOVNkbPG8c2oh3hppEYP3l6ka6U2qQToqYnFzYQrk1G?=
 =?us-ascii?Q?2Z/Hzl5UvFsKfvw32eaYrc8Z99bNwDWQHptPwJQxyHqzbitcL18kdM3VxX88?=
 =?us-ascii?Q?uZ/TmBtYIEBNk348lzXfeZoO09KVoWwp+OSyH7xJyx/wxnOpVOO4XYQ3tHiV?=
 =?us-ascii?Q?P9OxGZBp679ne9jKdVKisEWW3Jj19hQztRr8zM1TPamT88ZRO3+TAgIymcwv?=
 =?us-ascii?Q?5KHj1DXi6Bv2FGBX7I2tRKa0176Na5lbxTKZ2A+F+WH2kHVbAcMNB7fPUnkQ?=
 =?us-ascii?Q?yDzuOEgbVfbE9dGyMJ3zNAETEPe0PLhWVF2ERHIEMV1TL58ZywfslVGsweCs?=
 =?us-ascii?Q?vot3KNmOgagTTT3Qvh320/4F3dZ42yNp51AraXq6+CjADOksPx2Vui6W+ySO?=
 =?us-ascii?Q?zcIhuo/URm0sJkzssuLu7MdPY3fBb3lJB4fWySXAY9ajU+xJTD7XG5gzxoYM?=
 =?us-ascii?Q?FG3lQUEav79hhuxlBo1OtojpLd+hLDM2UVTZpI/G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1609b788-e811-48b8-d423-08dd1e599990
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:53.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU0QvJClRJgWGDY/N1ErJEU7VXQWpqrtattWz3zgC3vSAz8Y0o5KM35dV/f+3zRH6MRdypKWGGarZvUH9dwvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

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

---

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 30 ++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 10 +---------
 fs/fuse/dax.c       | 29 +++++------------------------
 fs/xfs/xfs_inode.c  | 23 +++++------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 21 +++++++++++++++++++++
 mm/madvise.c        |  8 ++++----
 7 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d010c10..5462d9d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error;
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
+EXPORT_SYMBOL_GPL(dax_break_mapping);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..ee8e83f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3917,15 +3917,7 @@ int ext4_break_layouts(struct inode *inode)
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
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d156c55..48d0652 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -665,38 +665,19 @@ static void fuse_wait_dax_page(struct inode *inode)
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
-/* dmap_end == 0 leads to unmapping of whole file */
+/* Should be called with mapping->invalidate_lock held exclusively.
+ * dmap_end == 0 leads to unmapping of whole file.
+ */
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
 	if (!dmap_end) {
 		dmap_start = 0;
 		dmap_end = LLONG_MAX;
 	}
 
-	return ret;
+	return dax_break_mapping(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 42ea203..295730a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2715,21 +2715,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
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
 
@@ -2988,19 +2984,11 @@ xfs_wait_dax_page(
 
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
+	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3018,8 +3006,7 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			if (xfs_break_dax_layouts(inode))
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1648dc5..c4f03f6 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -593,7 +593,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..f6583d3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -228,6 +228,20 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_mapping(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+
+static inline void dax_break_mapping_uninterruptible(struct inode *inode,
+						void (cb)(struct inode *))
+{
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +265,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_mapping(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_mapping_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
diff --git a/mm/madvise.c b/mm/madvise.c
index 49f3a75..1f4c99e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1063,7 +1063,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pud_trans_huge(pudval) || pud_devmap(pudval);
+	return pud_trans_huge(pudval);
 }
 
 static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -1072,7 +1072,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+	return pmd_trans_huge(pmdval);
 }
 
 static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
@@ -1183,7 +1183,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_trans_huge(pudval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
@@ -1195,7 +1195,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	if (pmd_trans_huge(pmdval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
-- 
git-series 0.9.1

