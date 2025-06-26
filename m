Return-Path: <linux-fsdevel+bounces-53110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A8AEA417
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3351C4A83A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D7C2EF673;
	Thu, 26 Jun 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IgSGDFZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012056.outbound.protection.outlook.com [40.107.75.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A492EF2A6;
	Thu, 26 Jun 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957828; cv=fail; b=euIBoy60BpgfAmaJWIxh85ylkhCbYPU/eUcfSBmxBdyDl8Xe/zEpCA1wDgs1cBG2SOE4vrTSu1ncvOE46VFs+fH27r6U2QyiObPAx8ru9IU1whdQLh4Q4ouk4d3kK0TiZja/yTI8KYjk92+hNpy+KXgv52SsFBz31FJcVmmmyK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957828; c=relaxed/simple;
	bh=f9RsYmfAZ8Ts4nFE8qKdlDOI4sgqjvz9fOiW5y7vdRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9vgusyLsK7QCHI+F0E+cbvT0d/+gdbu3NJcLXBPxvZtVzsVdcC1HCxFf8/LxqMuT4b6ZUdDhc+1QFpgQ/U2ccuMqhNENQsuBKoc/bWni0iWTDumShV529Qm7owvjoxiLaoeXASJ0mj8o4HO+1L4VR/WhwbEsHZOqriA3HMUKjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IgSGDFZv; arc=fail smtp.client-ip=40.107.75.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWH7NtuFT3SyN4tDuLQC177uRJ1DqG1zod+6zX2M0+Zvatusz9aLgQ3JrVWfsowI+gPH9d2G+BW6mCQAYMtMs75zzemIzbNflYypV3G+HPSKkzr/e1ciQbyMFVgbWTmlr+z46Pkk1G69fJ1+nmRaCg3b5pOlAStbyDh/QuzU+TlcGQwzp/qHZ9dDNQrZwjzD0ZEHU5d6ZLwUWk1VTt/H66oqb1SJ1Tra8aE/jZF8Gfxnqye/ht9XiEttNRUQWeaA/CNErXiebRuSMFfHzaX1wizm/9f8Q6+DpOOSSp8CJiCg69L1N8Cju6rpt4wZBseKAxG0r21cqrOVl4foFQ2btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBL/LgXL65dskK1IRduIL0vDv6ff6aBttOrsCCIBypc=;
 b=k591/qYNa+6rAvSKvQQKSv8o+WrVyMLCJrAfYiH+xzBFGIH5Bsa4iA7LPS4OmmUpsHMSHaA90DZgI4g+m/tS0HF+1wmZm2ywuMw/Z1DOk7qlwTmt7P5SuN59smLLzzrruJ6RvDQO0S+1dSjOUoxGA42lCIynQUiz2DI4oFyKxlGrauIFkeXHNiH1gS2hCtjU6/hCRkX5c6WGjOY2j58LSyaubQd1dwBIzBkDCRIqkMkShmIu8N3vEFjPGwzRcQ85iyYrVPdIVI1tWtLtihXYMcF3hbO4NFifq0TqUDZCPogp8Dwz8t6KN0Xszq+A8PKkfxiLlLPzyNK3NrQFAp6jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBL/LgXL65dskK1IRduIL0vDv6ff6aBttOrsCCIBypc=;
 b=IgSGDFZv2MnwivML3SnLqkoZyFhD0+8l1uxQ3GfeH9CHZT6sY4haDz41H0TrXrYawBUAnn/46D/8eCJKK4KD1HWKodBDmdqhocMTc5DmcIqGGPXYcsALBpV5492AO5XuZN13w+jSnhDKovQ2sRkFA92gDwn9d9LpoYC++brQtEvCO1W2uzP5OrnIUaFBlZU5HKc2Nz+9O3pWJV5Ya9tyVUlpvIZ6Sw6PH3sT+YePmxonPPYlh9BE9yHg+VwQatQ/mPTq40pm7lWt0HSNCYY6LoBP1Z/h7VsjgIJYJa6IHUF2F7AyuuBozyCgfoyGcIr/ZqePmKy9XNqhvslpTy+iyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 17:10:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 17:10:24 +0000
From: Yangtao Li <frank.li@vivo.com>
To: axboe@kernel.dk,
	aivazian.tigran@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	shaggy@kernel.org,
	konishi.ryusuke@gmail.com,
	almaz.alexandrovich@paragon-software.com,
	me@bobcopeland.com,
	willy@infradead.org,
	josef@toxicpanda.com,
	kovalev@altlinux.org,
	dave@stgolabs.net,
	mhocko@suse.com,
	chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	bpf@vger.kernel.org
Subject: [PATCH 3/4] hfsplus: enable uncached buffer io support
Date: Thu, 26 Jun 2025 11:30:22 -0600
Message-Id: <20250626173023.2702554-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626173023.2702554-1-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 27efdec5-c9fc-4d16-7e1b-08ddb4d45738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yL+kbB+wjLir4PNAGolJNIfocoEyCXJ646illY08+isssSB23s8JpaB1Xxp?=
 =?us-ascii?Q?e+HkcrYkJfSpMFwtZ/F9ByyE3KL4NuP9NnM3mnIKO1t3nFVi4AcKHShgz2Xp?=
 =?us-ascii?Q?2E0xl+IF6hmtuuZBrA3TokdWucCsUBzukcpctzA0zmRIY7G9heWW2rsz5qw3?=
 =?us-ascii?Q?w1Qy/ynnk6tAaySMxD/V0K3YroVdoc/HsnX4jc9BiPxCQA0NQJ8atjwPSIJG?=
 =?us-ascii?Q?D9ix4H4rK0ihmkaBTzOEUerjgTaVPy1MoBHo6qT2yi6nNkA5J2WfAucajSHn?=
 =?us-ascii?Q?SLRi343b1xR1KMxS52/bVovkYhdBb64jS6dnS+fBwpQ6fucXxe49STgQ/OSP?=
 =?us-ascii?Q?y6l15zfoAL4d6xjuiO2Nx/3lxVX82MMSGAak+1klsvfTVSqLnv8d8/FiyssK?=
 =?us-ascii?Q?JcicGHbC38U3BjD2NWTjxpXT0aEEnST3EVzBczzMIGRdX7f58GzIU217l5Kg?=
 =?us-ascii?Q?24d5OKBjW4jGXkgl2rOwt1BL4W9DqQRHrFpG8Mh2q1B1YHP10rLLuAJLoLVd?=
 =?us-ascii?Q?Oz31mMpjuCJyACsXwj8gE4lvdvV5sW3zJZ67n2NcSO7xFztceTr8NZvTu5AW?=
 =?us-ascii?Q?ptqALQjrxj3SdD47ELZqNp7Nko/jDyrBU9Qefh4wUdTZ/xCVOYXFnZdMFZxa?=
 =?us-ascii?Q?mpduUlEjc2I3emhcp705OvUJ3cPVfTLaf78dl3zxrUxL0AJEQmLa+isWzydO?=
 =?us-ascii?Q?oCmg8IDB334qYHCrQhP0DjzorwA9GqO78LqVig06/Kfv53H3xyRMuQlPo+18?=
 =?us-ascii?Q?ro3ZAtW48wsDF98GAgazu7vyZ8NOEEa5AL3f8NXFiulTkC3UQ1M62CwKhA+A?=
 =?us-ascii?Q?4z59WdTPYuAU50MmHgTGd0PQHbq3pIZaadQnR7HeVEqhIGWJV3OUWDFlrNX/?=
 =?us-ascii?Q?gLMxwgFtM5c0wPyIss5pKfbeSoql3K/c95OOQ2BaCcFTVlb9W/G7M7f7zYeM?=
 =?us-ascii?Q?YX7wZpymIS6uOVsTjoCmwvAkZY885KnWKIc5CAlvloIc/o/8vhqHor+1vJNJ?=
 =?us-ascii?Q?zm39va5KaoZrM2/4TeZTdIpdDoWiGf6BmNPWEjAmBOppG6U3EWKN1fmrLOHP?=
 =?us-ascii?Q?ovuckXPAi18zeD1urYYRS5D880HkN673jxvum0+NK/4BfvYYM2mAcY8sY5EL?=
 =?us-ascii?Q?BgjuJs05ft507R9KdR/Nr7cS9t8Ap8qsvOhIhHMmJy+0rYYplsFLptWFragt?=
 =?us-ascii?Q?UQHhFVViiQl/aMUiyz2ewbA2TzxF7Jv8YWHq29WaA8IjLmGMN/TPnMnXaxGp?=
 =?us-ascii?Q?eozQ2tV5faiK7gziVwFN+prE3LJvOhIIeAwnEKRb6Rf8x0JCHL3LOFdiPo6i?=
 =?us-ascii?Q?Jte08TlI1SEr/0ueijTQqpraAn74ncctrlK8j8sDXf6KUJwOugYiTgXnndyy?=
 =?us-ascii?Q?l9I+29f4rbjN3a2HOQUaQ2BXiQLZzD/pQPtqfNjYbhs7xmsxN9WfQrSEPdCG?=
 =?us-ascii?Q?l2nHH6wRj9h8QJ86Q3eINXgA3K2pSTcrDOGWMQzM8a2PTKEO7O3jE4wlxWSf?=
 =?us-ascii?Q?W+LVv1Z6KvIB7S4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3BVLTisrGQsjPXHDa/+sit3tHS2N595xVcd3xwAznsUz4lw+oJ7wDjfgwFRU?=
 =?us-ascii?Q?DxZHrnDg+aObiSfz3dieoStbsltjlnL5J9WM9PZQox4ioSN5nlmkqHchwQ1/?=
 =?us-ascii?Q?ZdN143uuYF7hmRyO9xly276pnc8hylTap+j6h+dgzTvhcI44qiBgTLy/lkMG?=
 =?us-ascii?Q?ravuymbj/Ts7XVV5bOM5PVxuygkxjt4FDfc322qahuNdm3tGwowbUwioxTkb?=
 =?us-ascii?Q?H8Vxe37tPrspW7xYIixa7lKwTMU1uOhQyq4V7GSKRmE5gVYAykeIfjufPVXU?=
 =?us-ascii?Q?QmWnYw2CklhfG0isTBYGz8r0xVwSpNP3xz5cCWVwYiYIgre94ASfmL5WQHo8?=
 =?us-ascii?Q?6STiRTk6hY9ozT1F9BZqrq/u4wYAFCZdRX9tgMIzmvHZzP8TjMd/yxTxSWbX?=
 =?us-ascii?Q?6bo3tWDJ8r3BQfGHW/6FTliJ+o51Ud3YnkXAKBTj3W7quE3uvY+koa3RuSpa?=
 =?us-ascii?Q?pOsMmN/OulDcv9hRwJ91+T82rCqG7CPQJQMnAuT269a1o3KzRB9FXUp8xgnN?=
 =?us-ascii?Q?8ZlN6UcndPSx4eqHNKu7WmgyKms1swRTg90D24b0So4QWbfO0JOWqUThN+OP?=
 =?us-ascii?Q?2hWKn+C/+rupAN+bBSTUWeKLvupf+izR6V0dI68W7djv4rf0EUlHI/2K8O9s?=
 =?us-ascii?Q?KMWySRYem8GT1v9mjaQbOa0/27yU1h0b0UFdgRVWFmZZmuQk7uDoSbyWdilC?=
 =?us-ascii?Q?HmSygLa0/TT5uM0su151SsyiDNRvD52NwFpmGRtAipfhZs7GMq0srnD7x/zt?=
 =?us-ascii?Q?zf69IL1fI/yymZXvzSygIRmoQrQCinTqi5kq/RtBLzzSxlbfEBb6RGHwn9qP?=
 =?us-ascii?Q?eaes65UjiscuBOe+J5l+9DSS2K0h/Em/Nmyn/Xg8hQSFnhHV0zGSiS7WON9o?=
 =?us-ascii?Q?qgsxKdO3UDEJplZTZ+K5MMzgcQjkeMOJ/uJ9HAS/zhvjBiwC6pn7nTISWbCh?=
 =?us-ascii?Q?OVtmORChs/Az5EAdVTSR4E6bMdN3jB6VCO7ecDjDM33H90S0v3jRGJpaysOh?=
 =?us-ascii?Q?YKcAEyWIqxEhux/Mzz9cEvqzFSrU9uh3QdXTPzgpJwBBY9ei5tYeVhAEECPh?=
 =?us-ascii?Q?kEAWXaBjWD5/t5b6iJ3K/qm16vkArlEOEptTT+e+vUVPXBGKYS+wHFCFHdz3?=
 =?us-ascii?Q?IkHBHsYAJmLxEDiV7Cj/EWXcxT62K5jhky72/3w6xhIHIzLfPUON0x6VC9u9?=
 =?us-ascii?Q?qeBpVVmNvZtQ4CZ+3+yIXbqJ6adhK0Bfe+0LWNRcuTHNfJi6g1fOG4ANSusH?=
 =?us-ascii?Q?2myNcSgHqLx30pNQwfJe0fsfKVbG26twbo53Eg2z+O9QETMh7gaI4H+wVIc8?=
 =?us-ascii?Q?WF/ASZHPWik773Otnjh1YzoVEakbeiS418QhM+8ApsANkqZuhxvy2le/+L0i?=
 =?us-ascii?Q?zIR5aBZQSS2XhSfxhiHm5+GqTCg7OTOQSJT0JKCivhY3X1t6yByuy2yBxjFw?=
 =?us-ascii?Q?NMpAvHN9mDVdgbo7al3LitO5k1T8Ppo7M8r3zHX3KNVezjvVuai0aHc2inED?=
 =?us-ascii?Q?v5KI3ntL6iWf6ynhwoPEieR4MOXq7D+mq8TLfHjqSrIhIJfDMH4NnFUrTP/+?=
 =?us-ascii?Q?/GPWQElzdybhsfDedbvajZ2OpiZl4sh7gPfJx0Un?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27efdec5-c9fc-4d16-7e1b-08ddb4d45738
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:10:24.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJixQcLY1QuSKuQLoq5IejOzgVnRZOyTSZwSUUVEImW8tOZHAZWWbiEsW5q4C6cExS10aSjcTMm5NOCPMJYnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

Now cont_write_begin() support DONTCACHE mode, let's set FOP_DONTCACHE
flag to enable uncached buffer io support for hfsplus.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfsplus/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 26cc150856b9..b790ffe92019 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -372,6 +372,7 @@ static const struct file_operations hfsplus_file_operations = {
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
 	.unlocked_ioctl = hfsplus_ioctl,
+	.fop_flags	= FOP_DONTCACHE,
 };
 
 struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
-- 
2.48.1


