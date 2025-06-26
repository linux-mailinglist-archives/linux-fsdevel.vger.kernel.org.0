Return-Path: <linux-fsdevel+bounces-53109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90541AEA419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83D51C44593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225A2EF283;
	Thu, 26 Jun 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PoLggKQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988A2EE615;
	Thu, 26 Jun 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957824; cv=fail; b=B60UQqT0mMvBIDFnAUNs2cy0i63ASBGnVB8uIdJpF+/zkKI0JZANT7Jq9ncabtp4G/6yItDxL9mQIj4RxpSyZtXTdUWYDWChicH/iE49+1ez0mK0C6KYldA7uBVh3qA4eT0o8dahsblyMKpd67tWlqqqVnptX/VPQDWZI6Vdnx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957824; c=relaxed/simple;
	bh=/3NwelnYdHm9NBDODqYT+FKQ7Z+hctYJD/+Xk4PvIw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLBvHEzqkiFe7FFI98yaX4309AVMotioYJynbqeCTmFj8/8PPsIG/RsHLHFcSsWz/IWCOGks9AWiCpwc3w7YOLNNo9tL06dRK5yrEBElhXzlbdn7QbL+p/aaN4NdLoWiR5O0CeQIu+Ju1QTWJv43rBdn6XdwMAp0JkBGHD/lws8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PoLggKQs; arc=fail smtp.client-ip=52.101.127.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIp5F4U4GrHKj+55aseqzTM8VfLmVz6P937t0rFrZRnlnwsUPUPUQHxMdufRKSy8CMIPzBsHbUpkccXzIFI33092Bscrzz1ubdhO0EM8rX+9SSr70tAwzoHX+2Gk5amFTxVfwrRszg1XqAvLWrC9u6gRQ/zayQQQGFRXCGMUJDi4aN5/TojgJBZ3/uUbAeDuRQsFeNG40rG4wVnVFK0vedqpKAl+DbhN28JWsUg7wWCqTRvbMAgwzuJjr96H6IgfrcrGIyC7HnrGg0m1KPdd4cjfnC8BOqBxC4Yv2DsmZVLMYTq3u9v/3y5SmTItuRGwTeNpLdLgCwV/9mWQB6zXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4S8HgT3dcJ3Y9KF3iZx37Ix39c8W5ovYnMeHSssmTI=;
 b=db4MDsa36w9kk1xdDb83CaAUBfCmK72eRZ8z2BC26vMB1Bh7kI5jdoipOiz89ltP/VG2iNnnFwJGkDeFw0WsiT139+7TWVq5fLABcEuZjbh2ugVB4Hx+pNT0tqeIp55fhIwpnbbk7s6Kbmp/q2EoZBxHZCfEWHipqtTPAnQvK9ll2GdBNdWSBlljUoP5U7P1lCHreg+Kik+u8j/ZPmpm4E9tZout+vqz3as89aClj5wawQNrnYST39+b/u6tyRZFdoXN9z03V4qAXhkQ/mRQ3wX4SOPtnYl5huc1MCs6AUQ8c1yNMQG3MBdJqy1UznBS2WADa0FWPwfh57hEIHiHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4S8HgT3dcJ3Y9KF3iZx37Ix39c8W5ovYnMeHSssmTI=;
 b=PoLggKQsURsg95OdIMmq/y66vBExSGbaRFFnKEHScZ+Ew3TmdoXI5xJyZEDpLbgDn0jAmD2X60TsjruQhrzdKq7US+37SxsmTo+umG8sxtlLdG9g6tx+v2DKOdyrmmVYiyjb0fD7laQuumibemBkynq1vLeirXz/lrLEzMXOQQKC1fD6em1Pd6TkV3tjm4YlHnb53gHk1Kd+rbPtUc3QuuW9vP2l8pZiotLvbHZhTpnO0lZtS+QXJkBzUV5UalEEqDMSAEVuZ9dTkl6gYN8v2MrOXRkNCoYdmY9gsGuDE53xL5MrOKzJBmbk986Osu3YEIAPd+MNFvcS0AyJMnsD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 17:10:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 17:10:20 +0000
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
Subject: [PATCH 2/4] fs/buffer: parse IOCB_DONTCACHE flag in block_write_begin()
Date: Thu, 26 Jun 2025 11:30:21 -0600
Message-Id: <20250626173023.2702554-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d8b0cd6-cb99-42c9-4d11-08ddb4d45452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVlAM32K4Q6+JfM1QzvbNLih/Mntwz4I3Xf/8lcd8FYW6cKmV8yGcze5THGD?=
 =?us-ascii?Q?tPFnIOWpz5fCaAigP0w3uUj3Fn6duPcor7SDXsBOxZTgakcwqnSwC3eEpuWg?=
 =?us-ascii?Q?8ZBlKWNJCZ61JdDI8Bjb/qvqNI4nRHdf5PvuPMNVt8wH8gkdOexRSREuUXZl?=
 =?us-ascii?Q?iAaO3Rytlf8PYTqGavcbv2aJqkrcWgbgCxsvdqiglfdDDgUnJjiuUhVFvDNM?=
 =?us-ascii?Q?Ke8KPXXjfpZryl72M3Qoh7Fsx0ppVJpRYnguwBi+PnkYzoPtuYWhJyUEbgIn?=
 =?us-ascii?Q?d/j8GcNT00tHS5xJgOA2u1jbxSEPeE5xv+wKFE+zFQ8KOcs+7hY4PUDcN7vt?=
 =?us-ascii?Q?G5WKlulmIheQAyhAhjZRvhX32WyAkxdvfKefoD4nihBkvaepGViUNr9A4e2N?=
 =?us-ascii?Q?qwMtbKOrbozS8WGtRq3M+mlCPpa53fjEHsB+YeHxKadYedzYji7X8kmACcAM?=
 =?us-ascii?Q?HPSOgN8CUAq8tu3NoQEp6pDDIQ/59E4Zy+R2BatyxkeLDeJkVYBq5ILNVVde?=
 =?us-ascii?Q?Q2WzjjKl5oDxkVCxRgPNUNua60bJerHM3DU0FDbx9FtarNFTBUs3UWEhTPLY?=
 =?us-ascii?Q?TFJEKUiXL1DMGimdRo3ftu4g9ajW5ZksDPwgMtZ8iuLZspt06mBWOzOiPiO+?=
 =?us-ascii?Q?2dhY3p1rEeQzrNzye3lX4UeETIpZKJm+7AZnlmOJspkUV4ZsLAXd2zabE944?=
 =?us-ascii?Q?DhdCSo1wDs0U9fLobmb87r2/mASPBxRryslonyGjXjTjKBpn031HEu4TyLLB?=
 =?us-ascii?Q?dkCVBQOjy9rXmsbn+Lzfzq5LPnZsKaG7zh2CXAUD+zGgInFqeZsbJ7Yp7j8H?=
 =?us-ascii?Q?1odcnTDkWKKcq4dWoajikp5T0dZ3VNuHSMryUK3OiKyeiyBNLkQlEC+21cVB?=
 =?us-ascii?Q?yn9MTKV8sRII8VC1pK29QtDKpllG+QZCmYUQyEYe7z1aftt1ggmjyFsZdH6i?=
 =?us-ascii?Q?fFxJ3/Iw/zkFE5y2afpSJR9zR/UVd/II4bt79K7B15HG7C0s30oQfE7oh4aL?=
 =?us-ascii?Q?4rrX+sXBUX8NlXKSw8xlKFTRINGY19senl+r90f98IFdNhbCpzP+4upsRU/o?=
 =?us-ascii?Q?Tlfz4Tirr0fwBtnX5RXCe+qR8QY5Pm7GvE9rsMLL6nrNm5cRSM4KOJN2pzS/?=
 =?us-ascii?Q?xVLgQGHUrwrfVMy6lT2UpUspPX2xAZD9+i6uotWxXRlLeqWPXzSmsFGMLrFt?=
 =?us-ascii?Q?TpbmHpCIU61MOMUoFilTG4FNTha8BMDDPOqioWJBsywT9D5Z//aRY2Ypk5Y5?=
 =?us-ascii?Q?tCEOhvYEqyvHVInfBV9P/TGWJFVS2P88GQm5g49IgORfXwcjue/udtDZVYvQ?=
 =?us-ascii?Q?f5syr6YTQgNyTTMd0qUcDdemIcJZyF70IZGTWJnuwHD+p1b4B7fBysZN5nUH?=
 =?us-ascii?Q?KiCwwnS56yWXU/RH848ZE6I8/NFFiTug5ugFe3AVq0GrjCjflM7sOnUVf7uZ?=
 =?us-ascii?Q?J0KCX+M48gw3Npmjndv4RK8aLxwh1r58h+lLIJEIQ9HWSjhGCh6QogXy1eRK?=
 =?us-ascii?Q?N/L8zbKoU+bw6Ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kESWIPHyXWbbtddyd0Z7rxdM2K5hdCV1y9lOYV6xQIgim28QNyTfD9i6KG3?=
 =?us-ascii?Q?zRBLxSCOjeOeZwFfscz74woevTJRi4WwrKRyfnS3NkDraDGdrf4syevtKzGv?=
 =?us-ascii?Q?elD2/CPv0MMsnMNaa1VEE5+YZor0V3U4IGl97xxaF8eO4rBTtUBB8qVluHgz?=
 =?us-ascii?Q?HZz/twFhVMTT0xcEnzu4pbYQMOlQp6ILYgTp7ODRfOrKXL7OZVLYqE8rhn8M?=
 =?us-ascii?Q?6xwcyb0KSp0rMwetTSKrKwzpXh1xjGrrCO+JQLXO38oe0M4x9NlqgiEphg/s?=
 =?us-ascii?Q?gcIMsHB9BfRFcWRT/UAz+HUt0f3/cXE1pdhD0Sj+ijnQZXkyITh+yYW5JvE3?=
 =?us-ascii?Q?kcoaHGLKFSYPW1UQnBPA1kmB22HzwOA4GTcGOg8QaVLlTHOlaio6Ow7medl5?=
 =?us-ascii?Q?ryXuYs2SXNu9pPaZsKaJshpVR56cetHji3FNiPzM4xXM2EuUbWsay+FzWgye?=
 =?us-ascii?Q?V4VOKD/KMEUAADPRa+QGOTisvPhrAolXtXDSTKqkW8t4gYFCoyrcsXO0YkUu?=
 =?us-ascii?Q?6ms2XDcB15/iK0nQl7vQQOSB39sI0rY6ABJEPB/3mjANHPD4hhpsLBctjI6c?=
 =?us-ascii?Q?eeuX20LWQ1HSq8a6ImuOdUpyQPW+hufaPuX7Ozpst3eJIeVanFQ8flHLIkbh?=
 =?us-ascii?Q?gvcyZGLy8ghgTaq0ZQBNH+ZE9kbGkJrOiI0ezcj34Bn4nY5OC32vZTgBKgfT?=
 =?us-ascii?Q?cy1JGSAbWFVe50lzkxeKOW3dZb7RGXX9hz2aU0WyLBEXynvK8E28WN/TbHEx?=
 =?us-ascii?Q?YGdWWlq17ObjBMMZNhxu2ibeo/QDLV1j0vG1WiDX0vi96FetKKTXsnJRMRez?=
 =?us-ascii?Q?rO4pSKQDx5OcsHEzjjK9+kz5HxxWCo50rK8iYc/S2IUZU4y2t5Hl1aRV1pFB?=
 =?us-ascii?Q?PLWCj9eOEnLfniN9usJB6B7W1YkXC3PW471BVAI/8hIhHXoKccvpGH6/0oXr?=
 =?us-ascii?Q?K+/a1AJTCQQLZcOpch9m3HSj0Py4UtwyGBBPhOUXQUmz7Eqk+dM44ipGfUL5?=
 =?us-ascii?Q?D4G95ERA/VAnAoTEF2QkEogyIlGS6EMipk5myFVboLrvPLxKiwXfdDN/hnZQ?=
 =?us-ascii?Q?KThuicsSYJTvMJq35gMX6ZhHTY9ao4/ILpCFk8U5Do7xP26hdnkSjyRvjV7n?=
 =?us-ascii?Q?Y/JVGGYa14CXX9Kpf3Brg4cLIlH558v2xCIzUDQPh4GObBviXTBe5qm0G7oG?=
 =?us-ascii?Q?YKnrc03y3Ykb6IH91jfqOSJ4ag9Fk7+iy9sGg7uHfh/Viv9DV9OLIYJQKPoY?=
 =?us-ascii?Q?nz7RgIAtclYwKzaGj8dKtahSES7w9fVgHRSL3C442Z0+5PuXTcmVZOG8icLW?=
 =?us-ascii?Q?u/ZsIB15KJnahHq+EzVeCLUAiJ2W6LkXIRaIOP+VdZzfgBVlNZZOSo1auT9n?=
 =?us-ascii?Q?7S8box+cJJv9M8S4v+w9PmJJDfDkIbD85wZM91rfs8WqjepMJ3heLV6zuHnh?=
 =?us-ascii?Q?J21XkaN5n2TTx9b2Y605Uw5vE1spV9rbDr/ST8Ko2txDfv4FdFC8Balv6vOV?=
 =?us-ascii?Q?QmDz5fffYfasJQrG3dn3u3+X+zMw5Il22mWNSZ5nO83sNDwnagPqdoqE/yZv?=
 =?us-ascii?Q?s5TqZ5GHQZPWuv+1F0FG6FH5ZxNK4IfDt1/7hNd0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b0cd6-cb99-42c9-4d11-08ddb4d45452
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:10:20.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpKrZHGDcrmY3RH5zJRUY5X7a1MQzwrjNJYhpN1YIGeKahZyqh+JOb9hwC+pUQn8ltYlbjHZGaJDXRO6Vu/hfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

When iocb flags passes IOCB_DONTCACHE, use FGP_DONTCACHE mode to get folio.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f2b7b30a76ca..0ed80b62feea 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2251,11 +2251,14 @@ int block_write_begin(struct kiocb *iocb, struct address_space *mapping, loff_t
 		unsigned len, struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int status;
 
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp |= FGP_DONTCACHE;
+
+	folio = __filemap_get_folio(mapping, index, fgp, mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-- 
2.48.1


