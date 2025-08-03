Return-Path: <linux-fsdevel+bounces-56556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928DB19368
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266E87A8FD5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066E2877E6;
	Sun,  3 Aug 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XRUSiyCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D47202C48;
	Sun,  3 Aug 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754216584; cv=fail; b=ufCN0qHT1GRkcDfyBZ1XrZrQZ7fC7G43iBrAxYN5Ue8Au8JZCND2A2VFb8iIa8e/f7J9BRgvdE4JbSBKiF3Uz7E931CCy27XQD3dfHVHFO7cKcCLgRFj2gC8wetcqDcbzGH7Z7oe4xLC2wM8oVWdSFNTtpEenPEr9Kx5L9n1ZFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754216584; c=relaxed/simple;
	bh=ENKIbg9eTe+XB4KpSDrmM/R2J2tFNpzVAh+k2vTMmiU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gdGx9xzAt7l6Svcu1/YlPME4ZZlEuSzlhqhx0BRqzSsFmCWXDk6mbYpWgWyvQXB+86/S6lopK9elyTYLmi5DurLO2rczbkXNgucoaPsWJBxI3jjfxXQ5Fo0itGKkvhZdLB7snB418Wr0Vim0tR51eme4SPUsOsPoc78tKOEi4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XRUSiyCM; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSa3CGcQyNWzQwpcHZjnBGjSCfZEF3n16+6m3IEvyLcAWYfyZUzSRpnyyIFDeZxVHcJ+3zfIoZ4+GiZGLPGAWNdPLknfuHOInBXjk1TPOOQjFkjUPioM7ggFdD9WblSASuown0s3FoYFWPglO4npuYLUYLgD56V9UP8MY/6voxGOgA2L8Y9lZcvxIqWVPc9kX4ZjJ4+u8fdq/OGwwKPOy+Ki/6YL1oN7eKFRYNOLAdF3j0MnGhDd6fsw/7L05UVYnTvTssrm/Ku82UfifKerXbKG1fCRu5rfhm9E/N0QVRawLZXxXaEIIayMR3Bu8QP0vZ3qG6u6PABirFXd2ncGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP/IPr7W0VqyQz3hebTuy4+7MTD4AVZK/5l1NuR+45w=;
 b=QrLtnffz0BxOZnf1ohFok5I5fTJw4tMF9XgM0EBt7lnLH+h5wQsPoHp6s87aOK+vTiPxmUg2ty804wiB/hpaOlkaiiRA6s+AnygcBtfhasfH3oFRpPwRw6bjY0y9Z8Ur+O0jflGyGGc468yLS1OhUP+k9RwtE7ZAFpMKPsSoEUr2xBZxjkaV0MtCImE8G1VnqdxMcODEC3bbHqLAmkTn/fcDceLYMTDnfaFeBYj46gcunLby/sWt9rW0tEGHkx+SStr6MwJq5W/+Ek8xZP0ZSyuyQfJVMhb6STPRqTvl1iJj2z/tc3d8J7s3xRkc18RIqeiB+x39azEImU9A3QzDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP/IPr7W0VqyQz3hebTuy4+7MTD4AVZK/5l1NuR+45w=;
 b=XRUSiyCMrQ8ppWxxNOdxNbLOFEhc74lbSmsshGxLRwdymiG0H77MZkPRPmwLJzIoQIGOM9p4CNSXo4m0GhBNMI5ekDOEJi+xx2Ss9x1V3iSjlx5FCvGXTg/OvDx/WYmvvjApsIP9XGvTNpqiJx74OEvxq1aGEXOYaslb8w5Qw00XYg9HrC6ETzf6Tz9ajl7LRGS4anh4Oa8fFZOtZ7k79lCj8tt+e4YDIxxJhRW/l4KJRTuyhQej2G3bWSObXsHlPP+P+/Ojze+AqN2GCYT8GxKiW48RfJKd6En5Fv+Z9YZmJXE7/abwn57UhZ3Gcj9mbjnTi77SZpNTv2hq9Ql2Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Sun, 3 Aug 2025 10:22:57 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 10:22:57 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-bcachefs@vger.kernel.org (open list:BCACHEFS),
	linux-kernel@vger.kernel.org (open list),
	linux-fscrypt@vger.kernel.org (open list:FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT),
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 0/4] fs: Remove redundant __GFP_NOWARN
Date: Sun,  3 Aug 2025 18:22:38 +0800
Message-Id: <20250803102243.623705-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd135ab-2c79-4ebb-8d6e-08ddd277b6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrU+ROoKChSNAMGDehVC9jiMlEHXjkv7UWCKcnGREwj0O1iLj8+fL9cHCaaq?=
 =?us-ascii?Q?HubfUlsYQsr4v3/mMYhi4Y0RZhIDffn0TyWRLMakwoY+tncSDbK+kL6Yy80M?=
 =?us-ascii?Q?msKPEg/I528dXVWqE13yr7KfG0RBeFHUUkYw1egHZ/tgiFc5NUmMetCTsGBi?=
 =?us-ascii?Q?7U5gLPv+voEu5mTIds6W2UhdqcEL4Xu36+uHKsd/JuMXmDxR224f23nMQZdY?=
 =?us-ascii?Q?rd3HFY4q5WOjlEUzLFP2VNgLMZi/hr6b8SChFuQBLmcmiocuQQd//49uwCC4?=
 =?us-ascii?Q?5x9/tt1An0IDc5enDtMJ1HfoVqoUHx68rnm48jPSCPPKE1O5X0fnqu39PUIk?=
 =?us-ascii?Q?OYNtbbqb+DoaHcSNlGH2nm8TY8LQ3g7grFuytI2Jitj7x1fFNCwG9PIVwKhv?=
 =?us-ascii?Q?ticMMvv30aF+K+cUIkdVnTX7JSIBCxmM7aDL4IwHIyED+zNFBRJRxroyiV2i?=
 =?us-ascii?Q?JFIfp0vgxAbPpx3sGEEvsnLnA7ujSUByoiXISsuZ7hEaAofxFkLY9CgpGmQz?=
 =?us-ascii?Q?WFBAjMtJrsKOhd1LVFSGnm7iENCPZ6My9lRyNjUMd/o6h/Se+RemxXi9ZrT2?=
 =?us-ascii?Q?gwxq6JIspMKrupLSYXWa7RKY7lqBLUtPiI8ozn2Ht2b+NVF8YtpdhcHMTGtw?=
 =?us-ascii?Q?bKotbO+oper7nJNEITdtlcQJFMzsQTYXl3U0oa5Nl2PMs6ssC5cnY73itaWW?=
 =?us-ascii?Q?cCL+hh2W03lLMFIVuNgXRiU/Lr2ipKYAWbqZVI+4b3vp2LrLOFBCWBc2bnpL?=
 =?us-ascii?Q?RVP/uPr7ctLE45vEV5bwlMMjevnPfwb8l417hPyLEdQG7arCFSjUlrW7hocC?=
 =?us-ascii?Q?go3H1JhmMDgkHd4Fuqt7ikwJ/ikt1/Zf4PJESZZfaMnFHcClgVdXbdxyHilS?=
 =?us-ascii?Q?3afFo4BcWpMuR9SlzO1tK4lk4RX8k2BJePzAO7LfJEdODC7IFWSH3H6rNIEh?=
 =?us-ascii?Q?Q4n4FPqt5uZge2V/mNj6lhl5Fm2n/vBTzpXWewOaMhZnYaq9Q/73dHZd217o?=
 =?us-ascii?Q?vvz8EdxCFQz0QSnw80yrAIh+6WNS+7QYJ5MT/X855zEZU+oVDfHr+fWln/Ii?=
 =?us-ascii?Q?+Zx3aD6eoCZ/KbwSY5V8mnA10wA/gjat8ixQORhRmWnvi7GYp4N2PUYl6B8Z?=
 =?us-ascii?Q?TfGHXz3HfTT2SNDQZ5HRjBJqUObobgSQIwYLd/jXBzvotWKFi7FPRPVfU+d+?=
 =?us-ascii?Q?oMizY0aNPWfjOTFAImhuvE2XGkIlqnYPJzIFjWf82uXTE7PDRMkBa15X72m3?=
 =?us-ascii?Q?dKw+9tFfH3zqVEOwIJe48444+KlofVC7NJFYT3w5KxS+mkml/XzaA+sqlOE4?=
 =?us-ascii?Q?kB7b2ILLlx/JYV4c+uuFQu3FU9r9cYDS1wh4o78tlbD+SISFzObkKgMaWQmK?=
 =?us-ascii?Q?sjAZ2Eeo7TjOB8Z403yDlnTB7yzRfOlndg2bdYMsrsIJQDLlqzzk1h6uxiwR?=
 =?us-ascii?Q?WFlfgVXs4vJg1oP+Ppw6suL7whtgsQrBMW8n29R4BxqFZrukny0K2AuuTlKE?=
 =?us-ascii?Q?6mK3p2bkxx0BM20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+LHOhPX91n0ntyI9Uv3mREFZsE80NeP8hMhBBhNRvz/oTujKl9i7nD6QKqW?=
 =?us-ascii?Q?yQms89FgUAWVg4IX8VmqoJsSOaHLw6xzH6Vbtq0tA7Khvcnbi4lbaaxKO5A8?=
 =?us-ascii?Q?DbsOXXx412lQ5UyV2qVCZd8TuWT6ddm+IX5bFq9lv92Mt9Ud23VZg1dBCqbO?=
 =?us-ascii?Q?dlcF9W1/ryXg6nYIgWNSmB3NijSUbw1TRIkq7wQPhp5nK4EzLac0pXMgyPQw?=
 =?us-ascii?Q?dd3nc8uUvJnpg6EiPFydYiD85tdMSaOUOwNHH9oWlhKm7NqkeVZ9e/SL7hU6?=
 =?us-ascii?Q?4spby04P6MOxRwY0P0tI2r7ogbJfM2eQWjwqO2PyD9yMsNgylIAYEbNBqEXO?=
 =?us-ascii?Q?ZggOUVV/hM6dAlSsjpyZsjQ8Q2C63V9MDzZSmASMLHKxR9Rkmw/LFcwbjo0s?=
 =?us-ascii?Q?EnTtgqp6i/RCZnI8Go9AN6jkA2AXFUj6PfDqU51Lu88k41CFQr6EkjgkQ6yP?=
 =?us-ascii?Q?Mo/S/yBisZ+uTNdIR+FTkY6Lu5Gy6S0hbe87REuYf3kHXIMw4LJkJc0vAuGi?=
 =?us-ascii?Q?lEchqyADfHsGXbrLGXhZBFAaAf4vPBj4XPAG5crj0rHvFeTEeiFySS8xUgdB?=
 =?us-ascii?Q?unHoa948yBcz1AEChxcgWfezNonALMjGPaviY1D3L+eu+Gy1CZZnA3e2+/0U?=
 =?us-ascii?Q?9BbTvZhf5Y6GpkCB9/P9o3lg6KJm7VTyGXo7P5bg2xOl4w6DhCHVI9VzFpnq?=
 =?us-ascii?Q?2EJZMQShE/9mrRERoruoYvaEYXN5iwUGKVRrCKmrKTsRIS9cj/COBqxbEePV?=
 =?us-ascii?Q?1z0KNoEkwgGz7cusXzgQEO7tNoA5jMFSG4L2Sx6HWZpQYr3Y+fLYov1ykeZb?=
 =?us-ascii?Q?QzXCYOTuIxS19EUcDorNCpmqmq9vUrDxY2wPvvHI8rmG7Fg9g3VCI6n0kH+3?=
 =?us-ascii?Q?l/OapGeg6JNho4uHJtT9YniO4T5JDxooIJ6l8JJTJiTLZJ5kce6iDAKRgDyQ?=
 =?us-ascii?Q?jEonLKgEcaNm+ho60ypJkDh8eHVoeJ0v6j+5cPGQJtntcuUUft0i9AYQvw04?=
 =?us-ascii?Q?/IrG0A6bbxzVwCM+sOVrmPOyBXnX1hgw6AkmzLEAXQGWuYHm8uonBa2tb8G2?=
 =?us-ascii?Q?TCctW7WaR5lHhBKxo4eEzziKtfu7ltIBBZMcnDBEvJAhPlOw+Aqn4fPR7dmG?=
 =?us-ascii?Q?vZjvG1DXzVqRVpIglBWwr8L/e06uIlZ76BaAqnAuji5UIwMC7fi5hmStBw1B?=
 =?us-ascii?Q?2jAtbWVxmJiuMtmx9kQmoXww9hSfFKhM3zlWmDeGN41w4t8ZbednZqITcFAh?=
 =?us-ascii?Q?M2NuVy16LtxN7ghs6xao5B+GaawuNJPpPV/4ckZ61hVi9LfCMwibGk96YwI4?=
 =?us-ascii?Q?jyY249OOZ0vIuqDCmMXSueT31XPolbeHzyFGOxSXL9wJmt5vw+89ipfMfqpV?=
 =?us-ascii?Q?srIsaNazTRFgpkH/BuBPqge9DpHYeUbwSUXsOwDt983XLjBop68GVuWxWx8B?=
 =?us-ascii?Q?RIgvmICLFWND5ekFsJGzZOT/HIqNkC6qf7Uv1ln+Vpu2MG9COJPy82ybrTav?=
 =?us-ascii?Q?lGvh3uXriJGoz7aKchdXiocmwZ4XYu/ufaz2NzvXkMXP78j5kGIMoWvrmyMm?=
 =?us-ascii?Q?HwFR4v/1Sk205wVImhN5zGy2hQ25ZOb63j/AcQIh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd135ab-2c79-4ebb-8d6e-08ddd277b6f4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 10:22:57.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL9ZmxQyFo/Og87LsVv5hBpZk1o43SunjSLPs2YmeKkeCS8SlNhyjTOSV9n/KyeJb3CRyJfXFp/4eGiF1AXIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5128

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Qianfeng Rong (4):
  bcachefs: Remove redundant __GFP_NOWARN
  fscrypto: Remove redundant __GFP_NOWARN
  ext4: Remove redundant __GFP_NOWARN
  fs-writeback: Remove redundant __GFP_NOWARN

 fs/bcachefs/btree_cache.c        | 4 ++--
 fs/bcachefs/btree_io.c           | 2 +-
 fs/bcachefs/btree_iter.h         | 6 +++---
 fs/bcachefs/btree_trans_commit.c | 2 +-
 fs/bcachefs/fs.c                 | 2 +-
 fs/crypto/bio.c                  | 2 +-
 fs/ext4/page-io.c                | 2 +-
 fs/ext4/super.c                  | 2 +-
 fs/fs-writeback.c                | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.34.1


