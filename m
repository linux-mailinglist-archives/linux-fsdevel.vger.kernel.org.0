Return-Path: <linux-fsdevel+bounces-45639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C11A7A34F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C757A5716
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348624E01A;
	Thu,  3 Apr 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="eYQZZKt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CF24C068
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685527; cv=fail; b=lmKtJ7Hf/heAA/xxP8uPcd0hr5KEyspwlgHwA0/u1h2aVDkyW9Jo9LQ7/4DFeDEZ+7fW/aMR/oZ+6K65mkz2Y5JxmFi7r+C8lxyK5KnRVzyaR0ZyyKUq3r03fyeb/HanPm4kE1ZcJ/nxLgwJRxikIP6m8QFMWYz/mFqWqtNGahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685527; c=relaxed/simple;
	bh=xw8CYtw/BxVT7RQ1DTa2mGGJBa99u8ScajoqWeFv6Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKpyo4JRaccTc0ywFB5DP7PbEvbH2u/cBCR/uZNdQ3PluJLzzbwssWVBp77+rglZcMjLqLMiRKjAyvxxyEsUJOFnuHIMSEhYqLyig2fT1GH0H0/6hKjffBfFvyNz2WVDn4/9/ibqSoLdwZ9stfopefEqSytt94RxyueB7riuKAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=eYQZZKt0; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44]) by mx-outbound21-128.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ruyv+xsa6BGgarMgOk4vOFJb4Shgb0aeYZlGWnLZeNbJ5gFoFhAkUt+cNb9eXfR9VmaQw3D+mTjHSxw0MMlO0sQizyuud0qizOJ3t6B72zDMmXz7eLP1QwxgzO1yrygCNOR5e22YPHFFmcAkOBhoVA/mFGtbGNu5iK2iC+bmZhZVPRYymgRrDvNpwDlafE88nr6cIfCfts2ky6HomgWxO2uzOFCP3undMPk/PUqEZmfamZXJ521vAI+TxfPFbQZNQSxUVR4jseEv28LqPf7bgsYAWMPVuDOsO2pfbnQgBYI+WXpXrHa8SbDWSvSpDu524e+TGytokN49WIUc5fX0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhbpBkTujXp33txi2/QTwqyKBWmaQs/jyijNlZr/TJQ=;
 b=wQ4hOxVkThhZ7/OnYRC1rp2MI9YZ5Ma53D7C1P4wgkOBeW18u9nbQypkvs0AzGhd/XtpbL9e4Y3hNvVfSItbzY3jZbKxz9uG+mZ4gQTxebbc7I8DVvVYUOJfaU1VgdWoXaIudBpMEoQRhXNYwFoFz2xxbzB3MepBYTC4AaAfHTHJ+OS89zqtpHFMwW9Nh05jwFMASjOWfOxrT3m4XsOv3bQ3Ka80LIdddBjP0CeY2Fs0bTlVy11h6FzN7i7TQJBijmqW26I1WRoi/2tBfprYinKOIE7zRfvERQt7g2iYBW3wytWdIaD1XZnz8g+rB1Wil4BEOuFOPf9pongcE4xxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhbpBkTujXp33txi2/QTwqyKBWmaQs/jyijNlZr/TJQ=;
 b=eYQZZKt0/FV2LhVyxueMJXv8CPou8HoqiksDr7+d5wbLUcZQqevI3YWtIXNeY9Q+JUaJbR0QD4U0zwvybHx8fwHd9Mqrkpxbm7h49wV89HBXrb0Xogmu+O43YjqNZbm3E89CUrpTe4mt8AQXE4GJGzWXbMKlEDOjKHprGRd5FZE=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by SJ1PR19MB6164.namprd19.prod.outlook.com (2603:10b6:a03:489::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 13:05:13 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c6) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 13:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 13:05:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 567264D;
	Thu,  3 Apr 2025 13:05:11 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 15:05:06 +0200
Subject: [PATCH v2 1/4] fuse: Make the fuse unique value a per-cpu counter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v2-1-bd04f2b22f91@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743685510; l=5049;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=xw8CYtw/BxVT7RQ1DTa2mGGJBa99u8ScajoqWeFv6Ew=;
 b=G4Kmws6NZNluQuUJ3vDe/k2Og68SBxbmUt9gZ/ykPAenfxCm6EJ+7MK4bys1DMTTs3QO35zc8
 fcD94LBxkHbBLIDKqcnHbuENlzc3DhfALfhH65k4NSjWn4VmxodI5Nd
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ1PR19MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ba6cc4-10da-4eb4-1604-08dd72b02b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUZ4dFgxYWxEdmthenlpOHJ2WXpOZW1qdWFIUUVReHdJMVIxd2pKeWhqVnZj?=
 =?utf-8?B?cTVkM1p4Y3NoTjU1ZFF0MWhpNCtFei9DSDY1enhwaUc2VTJlRU1ndG1sQU5x?=
 =?utf-8?B?UVhiVEpiS1pEVTQ3QTF5QnJuNkNQWHdPclRnS3BiNGkxU3JmSTltMk5BeDNL?=
 =?utf-8?B?RytxT2FONFhRM05NV0NqRFdlWE9WdG1oWGVqQVM5ZysrVTNCelpSSzJBZSta?=
 =?utf-8?B?VDNhbzJyTXRGUjdpRXBTNjJFZzFRMjZ6MndFTzJ0VjhLb25BQXhUblpZUFJt?=
 =?utf-8?B?blI4SzByY3B0NUNBZk92Q0cwTm1pSjVNS2ZQYVBISGtXVmZDejdXVXV2WjRr?=
 =?utf-8?B?cGtwRzRSckJYS0Fhd1RpOTByQTNkUmlIZEZLYzhkS1NwNUFxY2Qyc0diV3NV?=
 =?utf-8?B?anRFSDBqTG5GMENQSERvS1VHNHZWbUswUC90M3J5dFdSckRjNGNxbklwV2lT?=
 =?utf-8?B?OE1HYSszUUJjTnRTa3YvTHdHbXk0YnJTT0tiVzNpSVI2WXBQcFVYZ2dOc1o3?=
 =?utf-8?B?ZEt2YnRLS1FENk1Ec1FCRHpYT2g1RDByYzRQZTNtMlFhSmZTLzJUbHhRaU1C?=
 =?utf-8?B?M21PTXZFdjRrUW0wWjBRVXpZU2hLS3BBNTViYXVja0MraEQrSHAwMWIveWkr?=
 =?utf-8?B?c1dhL1V5cFV0Y0owY3ZIQXZaQzFjM1FrZERVaktWendzSGcybEczLytSVnhR?=
 =?utf-8?B?K212bEdDWjhVaUVFS0tYNUVYMktLZCttRGo2WnpRNlRXTi9PYzliQk1DWUNH?=
 =?utf-8?B?RHZ5UW0vQVpQbXBhd1lVL3RheFdQVk45UTZSYnlnQ0xJMW9sdG9JeldEWjNi?=
 =?utf-8?B?K0wvYUZrNWNZeWdlK2FESTVkVXJ2bmVZdlJyZU9EdXZiemV6UVZGYWhVZzR1?=
 =?utf-8?B?TTJUanNMelRtY0ZoWEVjMGNzNVFjT2lOVEJEVCtuQUV2aFN2Q1RlM3UrcTBO?=
 =?utf-8?B?bmh3YU5icEhxZG1GOFIweFFxY0diSGFCRGdJcmhPRkFwVGFReFJ1TGpFaDlU?=
 =?utf-8?B?MXA3RWtSYXBHWEVkL2FuK3ZYUU9BWnU4ekZxK29sejN5SW1uNFRwR1JYUUlt?=
 =?utf-8?B?RnF5c2s1VGtoeWMyZnZyVUlBWUtCcEUzY0c5azBFNC9TT2k5aUwreVIyRVNH?=
 =?utf-8?B?c1lKcTc2TjkrQ1NKMGFFT0MybmxMUHpxMTc2TGdwek1KeW9xU28zYzFpUGJM?=
 =?utf-8?B?bzlKNVpMUEV0YVdZU2lEaFlDT0loaUpBZXFyZWlvd0xhZHhBdFFFRTdEMnM4?=
 =?utf-8?B?N3hZdDNZQTdxN0hqZVUxQlB4RGl5YzR4bFhPelJRd29VaFJFUDArSURLcVEv?=
 =?utf-8?B?dDQyb3lDczZhNGRyZjhFaCtJSGlzalhFUERmTEVMck1iMWxqRzVEWDNQT3Bh?=
 =?utf-8?B?NnArMjV3a2ZXVXBkWXliYUJacmhIYlpzSTBzZ2ZHYnJnWkQ2dWNTT2ZobjVV?=
 =?utf-8?B?RldJVHI4WEozYVdxTWJIY1l5UiswQVJ5b211aGY0SEtRbEdHZXIwbWFZOEtn?=
 =?utf-8?B?NlFpYjFQbXgxTTZJWDlnYVFvaGVTRUlub01ic0ovcnhJelgwbVlyZElocEJJ?=
 =?utf-8?B?MWRVS2M5VkJXVTJhcHZsc3ZWOUMzSFB4NW8wd1dYZzNXRURjK2ZPdGtld0sr?=
 =?utf-8?B?cDRWUnVoS09aZWtad2svVkZweXd4d28yL1JkZXNhQStldG0wQXlUZHdQMnho?=
 =?utf-8?B?NEZ1alNKbXY5NFZTRXBDaGNZQlVBUEdFb3hNTjU4eFhHVW56cUZlZFg4SFYr?=
 =?utf-8?B?K2FCQk9hRk9vZk9uNG8xRThWTXJUSW81U0FxYUxTRlNyU2VuVXZLQW1UU0FY?=
 =?utf-8?B?OWlWSjE3SG84MDdiM1liejhIZUZhV2VkbnljUTFBbnVrUzdoTS9OQjdsczlh?=
 =?utf-8?B?Q1lEN29vblpNOFRNMUZqbUl1QXNDc0wxRUk2OUprVzRRck1ac21lVkxDWmZy?=
 =?utf-8?B?VXIwNXNhY2pnci9jYWxhd0VJays4c2dlNEdkbG82c1pMekZzSTFwWkdBTUs0?=
 =?utf-8?Q?0Ciw3y7JRT0TAF/Q/pIEC3+my2jbsA=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o3G+bQ5Y3S+KZv5Pmo9cTFlgNM68a7pKOBxIYFYepCY8MwHaV9GhaKcmRkDGa+z3mQEg7heo6E06Kih2KLQ4PuSmavY64AxtSpo7wqg9hJr/Ees+MZXEtzEG6yJkrdIdvnBMZ+7+qM5N0Sk//Vnh+UeRLFyv1HGr71kD+IOfFOMNlh7lABa1qA3ES9b1JHFiIIkfCABzYLI2Fwpk7nOC+3uqJrEaoa5hMfZWJAVqDbP0bcs5pftogryB5szo7Xt/hvz6IZzt9pVvnNDy83ERPtCTd1lORXWsNCalqNSRrjCeFxBz+DpF18wu55POoNhSlFQuFp0hGZChVZG+Ib1SU6OjUjVDDZZz/NEwGsxv+/3fQbpLGNidam9tpF3FSmBM98EoMTCYxyJgN9FD3PdwZKjlCGEIQm3bpYuxtSuO8L1XNJhZf9RDV76cjPQz6NdKJYVjhZDt/U521K9okX5wzOaten0K9e8S8ivtQD2ybITaMI1fSxMLHUELyTEis2Hvden+aw/li9sloIYY3NpJVqEYxDWfFiR1xO0LB+Qqfn1jRBxezMp1Hb378eYLApqTi7Vcf6S34dKfM1CJQlFHcHj/U+GJq0KJKrtf2y1NIeNonlyfJjMX/PC1C5klpZ9BBiTpFJxXny1fvyY+h0QCmA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:05:12.5090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ba6cc4-10da-4eb4-1604-08dd72b02b86
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6164
X-BESS-ID: 1743685518-105504-7636-3322-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.51.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYWFhZAVgZQ0MLMMM0g0czCIi
	3F2CAt2cgiNdXcGEglpyanJlmkGCrVxgIAATDFVkEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan22-59.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

No need to take lock, we can have that per cpu and
add in the current cpu as offset.

fuse-io-uring and virtiofs especially benefit from it
as they don't need the fiq lock at all.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 24 +++---------------------
 fs/fuse/fuse_dev_i.h |  4 ----
 fs/fuse/fuse_i.h     | 23 ++++++++++++++++++-----
 fs/fuse/inode.c      |  1 +
 4 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51e31df4c54613280a9c295f530b18e1d461a974..e9592ab092b948bacb5034018bd1f32c917d5c9f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -204,24 +204,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
-{
-	fiq->reqctr += FUSE_REQ_ID_STEP;
-	return fiq->reqctr;
-}
-
-u64 fuse_get_unique(struct fuse_iqueue *fiq)
-{
-	u64 ret;
-
-	spin_lock(&fiq->lock);
-	ret = fuse_get_unique_locked(fiq);
-	spin_unlock(&fiq->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(fuse_get_unique);
-
 unsigned int fuse_req_hash(u64 unique)
 {
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
@@ -278,7 +260,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
 		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique_locked(fiq);
+			req->in.h.unique = fuse_get_unique(fiq);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -1177,7 +1159,7 @@ __releases(fiq->lock)
 	struct fuse_in_header ih = {
 		.opcode = FUSE_FORGET,
 		.nodeid = forget->forget_one.nodeid,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
@@ -1208,7 +1190,7 @@ __releases(fiq->lock)
 	struct fuse_batch_forget_in arg = { .count = 0 };
 	struct fuse_in_header ih = {
 		.opcode = FUSE_BATCH_FORGET,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..e0afd837a8024450bab77312c7eebdcc7a39bd36 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,10 +8,6 @@
 
 #include <linux/types.h>
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b30cd57b8a6bbda11447a228cf446..73c612dd58e45ecde0b8f72fd58ac603d12cf202 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -9,6 +9,8 @@
 #ifndef _FS_FUSE_I_H
 #define _FS_FUSE_I_H
 
+#include "linux/percpu-defs.h"
+#include "linux/threads.h"
 #ifndef pr_fmt
 # define pr_fmt(fmt) "fuse: " fmt
 #endif
@@ -44,6 +46,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 
@@ -490,7 +496,7 @@ struct fuse_iqueue {
 	wait_queue_head_t waitq;
 
 	/** The next unique request id */
-	u64 reqctr;
+	u64 __percpu *reqctr;
 
 	/** The list of pending requests */
 	struct list_head pending;
@@ -1065,6 +1071,17 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+/**
+ * Get the next unique ID for a request
+ */
+static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
+{
+	int step = FUSE_REQ_ID_STEP * (task_cpu(current) + 1);
+	u64 cntr = this_cpu_inc_return(*fiq->reqctr);
+
+	return cntr * FUSE_REQ_ID_STEP * NR_CPUS + step;
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
@@ -1415,10 +1432,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
-/**
- * Get the next unique ID for a request
- */
-u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150878634728685af0fa15e7ade628f..12012bfbf59a93deb9d27e0e0641e4ea2ec4c233 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -930,6 +930,7 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
 	memset(fiq, 0, sizeof(struct fuse_iqueue));
 	spin_lock_init(&fiq->lock);
 	init_waitqueue_head(&fiq->waitq);
+	fiq->reqctr = alloc_percpu(u64);
 	INIT_LIST_HEAD(&fiq->pending);
 	INIT_LIST_HEAD(&fiq->interrupts);
 	fiq->forget_list_tail = &fiq->forget_list_head;

-- 
2.43.0


