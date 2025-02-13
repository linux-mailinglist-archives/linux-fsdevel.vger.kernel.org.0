Return-Path: <linux-fsdevel+bounces-41623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA632A33655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E866167E14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BF205E3F;
	Thu, 13 Feb 2025 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X63yJOHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C733204F91;
	Thu, 13 Feb 2025 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418252; cv=fail; b=TTmhbOFfxdOS2NBCQWn08G4AY0Q7n8pcJOj5VPmkWNlTwDuicPX+8AhZn58b2s2UE0j47lov4X8Ag6+QjSBukxPjgWe39rFnm8wXYpFmKeXALDGqFwHroexyldx5OfWTuwueHPs64iDFun3UuJnqF5JpEvTpv8mmEH47s/6BLUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418252; c=relaxed/simple;
	bh=7hq7HXRvRTRUjEhMPGre7EXJiiSdpbqfqVHgLWE13ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXDgZF9NX6yyvXAcUk+sw7gcTMlGeZks7I2scEi229e0xgxhKdn8Lxt0pbc9fc/I8uHukU8r1DlRIRDt9CDh0NjHN8erC4ZVRcFRjxG1WLkyXD/OfrmBihhAsUN0xDyPk0fdr8v3drWLTtMborEanPCu9KIC9EG7R+UHJcOC+Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X63yJOHz; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnDzcwYZFgHZdgkCu8OUbAu7ZMCfOPKmgpESS/wkws81zragX3PHd4EMzCv4ngvnYtubOh0ZP6ZHNhJTijGebWDsGoYHj2+WwJhqru7cg5NLGqNVHQc5CNKYq6ocWNeaDHd11Lx5lQGnXbc67M5PlRJSJiOuhkQ2Z5IienhV22q+BRzWfGalsWptO/97+EuvM6om+t3lg0NVQXfSUAfWZZ4rjNYZWdTtVHPOGHSjSDF/pEuIGwnOQFlCo+swDGZguU3AflvDeNTlcTNylVdnI9SY3gp5N5PcHpy4VRUTAR/QO1JNg+T9+OzSZV4gPM0N4os+wZksG5/VRhtL2IjaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arKOQe462duZLGgRb8IwStyimqTscy81tSdsFMgbflI=;
 b=dWjNbMxbquwjLsKnqNh2y5kkjUTHYPW90E22tlO0z4hZJlE9dRHmhLlP1D9XXZVnoaNTa/jXPC+7ezULhtvNzzFpYfRLvv+hWpfZ2bTjjd9aSojKGdSvnyo/mwGAcTk6wKo9r0sz29PLIoGbOfbHU/HYy9m+zbPmBksEJHEEQWdC+vt/oIixW0OHRiQ9TuWaempKjJChemz11NNlEAIuTsGjd06a5vZ/7QYlwUacoRnpJ2zW2SDdEYZuF4T9T0Oc/jPzGgoCF3xXIhgTgTTJyCKfnwNN1CTob7HxPbTqUyqXyRBsgx5Og5a6Xt0oMgpCTYzAvPQyDxhMceAJPDyp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arKOQe462duZLGgRb8IwStyimqTscy81tSdsFMgbflI=;
 b=X63yJOHzrEafK8k5+NfGb2tcgfeikEiL1augvQ5Y4jpEwhzRsZP50xrv8bOE5U12f1Ls/l8yvlaK1HeqBz5DF809gaJvJr70l76FefJv8xEw0klJVpG/z9PhPXgjGFmEm6lQsrN6O/fQrfbQ9YHh4hRKxKak2GsAhSvI4rD/qyaStqa+Okn/AX8esr2p8PIYIsjCyzF2yUeTjI4qyGRPNFtiLJ3HMgNHu0g1kSw/uP1gkqJNSXZYoYmsDmE9XTN2jWPdKbnkMA2CcNsOe2m8dxE4+DUgE0UCHoklVYsNhiu0Xr5eKjqtpu7R+unm9b3P2CWO8eFM4eM/h4D34nEg/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 13 Feb 2025 03:44:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 03:44:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 1/2] mm/filemap: use xas_try_split() in __filemap_add_folio().
Date: Wed, 12 Feb 2025 22:43:54 -0500
Message-ID: <20250213034355.516610-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213034355.516610-1-ziy@nvidia.com>
References: <20250213034355.516610-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:408:141::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f726e5c-e83c-4600-6b4c-08dd4be0aaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JaNN4P14DDN9Ts/m3M7ieaSND9q+KihDDWGPx2xLfsQfqfxe3FM2lV/Llkms?=
 =?us-ascii?Q?Ra35U4W/hT2jwYpbBWg9hwfCGTfnaCPM7jvUVFpeOL4YKvWKWmQfT3ZrD1YC?=
 =?us-ascii?Q?1OWrZ9GrcqCItTl526TkNCqN5LHkgrK1Nd+Ep8PqitNM8Eg7xneucCrg6l8z?=
 =?us-ascii?Q?kJcHhwXJAFs0A+v4VVps+8nMNHZaOO26hNWKcXUTYo0rovA1BDjCiN8C33vE?=
 =?us-ascii?Q?hZd4C8y2vrJJHSOnKtUPaPHtx5qkhf5wHje07wKEixJ7hTqbJtcCVwlQjKPP?=
 =?us-ascii?Q?ttWrOogj89uF7yGrvdv7f3Ykkl6jMHcMY7URFHhRNMnltQxGWeM7SkMRuYei?=
 =?us-ascii?Q?MoZUUe/Ctba0IgVGlFvx3yhaQboF+PCvtKheF3sivDcDnn5R3kFhfh6o2Gs8?=
 =?us-ascii?Q?lnde/2BwwMwewngt/3I0Mideb8fn153JcKznKphq4jixIEHxfTbqu6y8lPn/?=
 =?us-ascii?Q?AlZyqR+O/fV8ayxXAUUzpbXd8D+BvkTKa/EK1eyQQ9FRMSI9Jfx8H7S0p5WG?=
 =?us-ascii?Q?luTwWOG2LaL63T5vBWs+7b0CCj6+JP+vgD3MKqxq7wYmd8lICc7UE52U2FFz?=
 =?us-ascii?Q?8XBdgIGdzyB2TBxn8mWLAbIrjvMDW2QTg6qT3zp8QWc5LjqFB9UIn+aNSz+1?=
 =?us-ascii?Q?MF7Z06ttwjtdxnI4GZBrbMUcPEENt6PCmaciK4eT+JuACqha/GKliOm60Y8G?=
 =?us-ascii?Q?8USKxPbWn/r3euzejFPkXbONPJWgNDeMze6gx+ZX1iCeuNc7F5DzIgeVcQZ5?=
 =?us-ascii?Q?zPABHGU2mLegreZt/z2/wTRx39zlgMXxgw7u1sM7V0zDdz3qvwwrnyVWnTih?=
 =?us-ascii?Q?Z4Y9qo5+CAUiLZt+oni22ITQm1gL6gt7bKZ+1eUXYTf6XzUTWc2ma4V3NqMP?=
 =?us-ascii?Q?QF93HB2lL4hraLZKbyVC5ZlNAeeJohX1zhYm/4HqJVdfRMs7z4WSS3nxOOCu?=
 =?us-ascii?Q?adOObbY3vTN5fCbhSc46eGXayQBZhQFT5BwyUsHUrlNm5P1mcUWG4oo5J1cZ?=
 =?us-ascii?Q?LTo1d9+R9Ub7YAJus36P5ebArOsHb8OMXhjG8k7dMFuoL4MfYzOkZCcBXqGi?=
 =?us-ascii?Q?pSY1+ql/3Zmf6MTebkwCV7pjhhlhLxImjReBiSDXshUCOBcf/eEci4VXhBa3?=
 =?us-ascii?Q?FB/R/OPP+fGhB0vLOww4JNXWlDmbzcurMTOKMs86DMp3ue3eN8h9L4HzwCne?=
 =?us-ascii?Q?5R7svenAafqdfZx5ZJ22IpFllpN7Mx4JXW48l0Hg3ODNIF9o8+6B6A88yvVU?=
 =?us-ascii?Q?5QvAZhWWi7eGm0GTxduFMiOSituSgyQ2dCAiS2WC1z1I63el52ArEXe49Q1F?=
 =?us-ascii?Q?acyp/7+4ZXJ7mVXQiptpUjnDKVnJPDI7v4sxYDHVYaage7tmeW9v3UEvFHsf?=
 =?us-ascii?Q?hVI4qiYWJfbkAg5zybDG3z1zfWyd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXajlNh9K0jvbG8HNGCTudk5but1SJnjN/gajXcJ7faXTJCbdUDZ0FROgarJ?=
 =?us-ascii?Q?k9Rj//axjghncrxoA3nuEaRWZV0zVoIdOnXk5EZVemYeEREUC+EYnTSxx4k/?=
 =?us-ascii?Q?VJcycF75RE7396VC7LFy8RrAunPwk6f35h1XoTFJG32kMJ3aIK5CbvLD0tB9?=
 =?us-ascii?Q?9nKyov+vxvD1YXlrjo93NJtASx0EdVSOkEt7BrmC+oJd4VBGdgFgomkPen1B?=
 =?us-ascii?Q?2nwPLFhQJ4ULXWoso/wITKvEzDBTnCamiMtdwn1/2KY533zfmoURXlc1mJ/d?=
 =?us-ascii?Q?TaZSBnAIOUTh6gg6CQLp1C0zgRD4RQGUJiez470ITDZs33KMlFUF5PzE1hJN?=
 =?us-ascii?Q?eo6ovQVfCoCGZRudvLPlBr4XMJOXJKgs84B0+nLQEY0unDTg0RliQUpM4MQR?=
 =?us-ascii?Q?73SugE4ksWYYack22a/Zj1RWFUYb5bQ8FGBD3vwEVvLOVIA3hZ4k3jIwwZac?=
 =?us-ascii?Q?wtBZBz6mHwykwTNoqzNJIFZbv85etIWWQGt07e/xh7Oo55SSxesci/kOFOFr?=
 =?us-ascii?Q?itL9QuTheTYOCE19WAS0JJgv5rghm7h1x4kDYOvjh1XNTDddTAXeVAUhm470?=
 =?us-ascii?Q?dsyVNvkZUSm5t8i9YOMQyl75A2ERgva7cLY23EsF03IUHd08U9p0df/We54x?=
 =?us-ascii?Q?8eLLLVhIg/mQ2zvNBoL8b3J+oIcwSv9yufvcJwYlumI64doMlt/pR9/9feRU?=
 =?us-ascii?Q?5TabNcDb4NeQmJBCAHXjGdLH0ssswzImI6O+MHZFXXJw2+fSvzwwcPuOea4S?=
 =?us-ascii?Q?LxDMARbvsaVYi3CLemWvQuzo5FH3dPgBLxrU/JihYMsmsPYar0H8rIjFMfO+?=
 =?us-ascii?Q?+4jaDIQVTM0X0VSI4jNzqzV3cibMeImIdopePFecRyoEO1ePGV+pRrtlILBt?=
 =?us-ascii?Q?nrE5VKNhEt92itBQ1r2PhN9HHhTRP68PhzXiaxHY7hV7dmvfaj/shLCE2cfx?=
 =?us-ascii?Q?288vVESFb5SFTREjdOS3MIYmjiuST+m2x+9FKIBaXqG1EmpIxivT+bblwtFu?=
 =?us-ascii?Q?S7Rs30HUlp6R1jKXX2TqTJ4XqrbBHdQDJfw2z8IhAQAhtsYQd/oji5yYmjeP?=
 =?us-ascii?Q?MQ88OMrtIQ0vwub4zSHa2/9OX6cY6XKpMtHY+Q3boRIOM2aSO2kp3jVeUejt?=
 =?us-ascii?Q?j0UHsPktpm/BP3oL6SzzODIS2WD27flw+utsYRRyrPmL1ut4Xvq4z4Azmglo?=
 =?us-ascii?Q?StT3DkTtjVyaTxjrDhRwOc0S1eviSYDlPOKuYVaVt9cpSUKUXp8Lz0EznxTk?=
 =?us-ascii?Q?VipSZpYffSmozewray8SMnVIPqs2T8wr1OexWWJvPdY4UVjWuWiOE2Esewex?=
 =?us-ascii?Q?znRdwgwCc73suhFdQtnAw6c0O5Or75By8QwQEqMx3kKHP7yt71i3vxx6SEz/?=
 =?us-ascii?Q?H7D/RiuFpUnmwp7NSjE9JFUQE9y0v/12Me4T8ZKkvql+i7cV9TIfEKWhZa44?=
 =?us-ascii?Q?S8laKwIjyeqqroldZIgPjmszyoOxNBUtAMRwzgnYZ2YH1kqoAR75TuLyapP/?=
 =?us-ascii?Q?1EXd3jICYByATnBedkpklJTNKn/4SSRpAoywaVp1SZ5x7JfOKn2f/+agb+6Z?=
 =?us-ascii?Q?g9PTqjAj3O8JN9uR2Gg5suJpqc1QhBHUCgH+NoOV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f726e5c-e83c-4600-6b4c-08dd4be0aaf7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:44:07.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6HKpw9gcrWuHmhGhmT891TxB1+4wEt9JQw1AkBCOHxxj1Gu3/V4xok0btbwM9p4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

During __filemap_add_folio(), a shadow entry is covering n slots and a
folio covers m slots with m < n is to be added. Instead of splitting all
n slots, only the m slots covered by the folio need to be split and the
remaining n-m shadow entries can be retained with orders ranging from m to
n-1. This method only requires (n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)
new xa_nodes instead of
(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)) new
xa_nodes, compared to the original xas_split_alloc() + xas_split() one.
For example, to insert an order-0 folio when an order-9 shadow entry is
present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead of 8.

xas_try_split_min_order() is introduced to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 46 +++++++++++++++++-------------------------
 3 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 9eb8c7425090..6ef3d682b189 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1557,6 +1557,7 @@ void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp);
+unsigned int xas_try_split_min_order(unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1583,6 +1584,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline unsigned int xas_try_split_min_order(unsigned int order)
+{
+	return 0;
+}
+
 #endif
 
 /**
diff --git a/lib/xarray.c b/lib/xarray.c
index c38beca77830..1805fde1c361 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xas_split);
 
+/**
+ * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
+ * @order: Current entry order.
+ *
+ * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
+ * no new xa_node is needed. This function provides the minimal order
+ * xas_try_split() supports.
+ *
+ * Return: the minimal order xas_try_split() supports
+ *
+ * Context: Any context.
+ *
+ */
+unsigned int xas_try_split_min_order(unsigned int order)
+{
+	if (order % XA_CHUNK_SHIFT == 0)
+		return order == 0 ? 0 : order - 1;
+
+	return order - (order % XA_CHUNK_SHIFT);
+}
+EXPORT_SYMBOL_GPL(xas_try_split_min_order);
+
 /**
  * xas_try_split() - Try to split a multi-index entry.
  * @xas: XArray operation state.
@@ -1145,6 +1167,9 @@ EXPORT_SYMBOL_GPL(xas_split);
  * be allocated, the function will use @gfp to get one. If more xa_node are
  * needed, the function gives EINVAL error.
  *
+ * NOTE: use xas_try_split_min_order() to get next split order instead of
+ * @order - 1 if you want to minmize xas_try_split() calls.
+ *
  * Context: Any context.  The caller should hold the xa_lock.
  */
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..e28a7a623889 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -860,11 +860,10 @@ EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0;
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
+	unsigned int forder = folio_order(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -873,7 +872,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
@@ -883,7 +881,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = xas.xa_index;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *entry, *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -901,21 +899,26 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				order = xas_get_order(&xas);
 		}
 
-		/* entry may have changed before we re-acquire the lock */
-		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		if (old) {
-			if (order > 0 && order > folio_order(folio)) {
+			if (order > 0 && order > forder) {
+				unsigned int split_order = max(forder,
+						xas_try_split_min_order(order));
+
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
-				if (!alloced_order) {
-					split_order = order;
-					goto unlock;
+
+				while (order > forder) {
+					xas_set_order(&xas, index, split_order);
+					xas_try_split(&xas, old, order,
+						      GFP_NOWAIT);
+					if (xas_error(&xas))
+						goto unlock;
+					order = split_order;
+					split_order =
+						max(xas_try_split_min_order(
+							    split_order),
+						    forder);
 				}
-				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 			if (shadowp)
@@ -939,17 +942,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
-- 
2.47.2


