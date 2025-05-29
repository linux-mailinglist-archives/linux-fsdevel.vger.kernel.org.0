Return-Path: <linux-fsdevel+bounces-50068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EFAC7EF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24D27A3FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916E22688B;
	Thu, 29 May 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mi1qYD77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011067.outbound.protection.outlook.com [52.101.129.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247B63CB;
	Thu, 29 May 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526007; cv=fail; b=oXBFM5jbbzDimtyKaFpBTXRmLu49+DCzQyOUcmmA/PLn9OwFt6esAv6pFFwYU6K0B0hBaMfXVSirntcTk11BmH+ujjYxTHJJUgSHDt7GE3yGsnx00Lj2xx5x5TiMDUE6mhWcyhr3srDndX8SfuVC3YfJ9eD7bqiUmHkzbGMJ38E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526007; c=relaxed/simple;
	bh=RYEsfFWKEwdCLf5T6Ief6paPZDaA3jsUYazwCkEYDcs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oM55IAC+vctb84jNELkoW3yytAM1JntbGVRb/6qnwIdanAiOysjZFKgj28S0YZqxSbR0UNj+NTKBGdRQnJAtBiThDwhei6iiRDb8YB+tGY//D38XSZyDZbf2HDd+awMVTmRH6Z/aKhiIZzwnbciijGciZl7DZ3adm+8Rb1S+alU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mi1qYD77; arc=fail smtp.client-ip=52.101.129.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9zC1W4kKZDDNR7e3+02f0Dh6LkP9BovqOlrC4vO+GD4pMZtO9+N4Hzrmx3KqFwCGLGSB44XdXD1tuxJUrZmSOK+6z1HpiZ8Yol3V/qOf291AvM8rL+jBqtwJpG/joyq+3LgO4WgOcSDvZRWis+8Z985DIiq0gdNfcfD4+2F5MoAE4pLtwgE/MBUwVRBUb+BICNZrrFCppALEj4zhXzKpmbfpkQXeeJ5scc4TrefRklXYK+LY+UftI2kIl22HN0lPvQEQ7MeqOnPzb0vdnRZOC+u/OEbKm7RDqGQtf4qUVLKQn9h2mi+5CJ+A9H40Q8NyQvQ1DxP79jlS6Aatk+3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js7UCecyJNMeVjcQcDxqD62C9u0kvoOc4EEL2z56hbU=;
 b=iHfU2laoDjt7+tF/wrkw3vgS13mgEWPDpyVciJ4nOBL5sposbPI6y5Z4oLQlSeUtE6bfaA6tTrXotuQ0HuH2ABI+0VZUTphITlSHoQWdAEM0npd+sD9mN7iuU+OPw1m6HVxR/ERQOxyKxX90ULq6HBg5orKbq7Uqw7AhP3SAvZ5RHPsDJIe/DGFFIDJ54/zKW8h0eTloKGxQ5rmfMwS41xJWcjxscWr4tw7MZefZUA7WVVWAHgwNMXALC+gY8UOBM5r26ikFSLXhC2V/bRydKVNnfAIgcNNUB19xTEZPzfDa/gJKQfuUH2BEeca6Ef72+FE3p1jfG9jpObOb0XU+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js7UCecyJNMeVjcQcDxqD62C9u0kvoOc4EEL2z56hbU=;
 b=Mi1qYD77vVO0v4Zi0OUT4ZUY/6sDC+n1KUQjTDoWZ6hJ8aMOIE9slpyuCSTOCxzrV1IfoFi155P5lP24pWq5DMB0oB/Wukbo8ie2K+yYA5m1VPDtZy36Au5BPMN1ubRifPt1ZTr3Nx9DO3EiXyHUqXx/hko5LVFPewU8/0ndL9i24dZg/JCjMetiX31/y+woPcF/+P56KWXPbUgMH8gDzX3RA8IA1GhqWy5Sy27mDz7Q4JPnE7OetWSwhYt1jPIG0vON3VU012KsDmngCdl2Q/QFDcD01qZTSlxKgN1wrJrsjZR2dR3CT9cpuESgdooc6YVK05tCPyadIwoW7Qc85g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 13:40:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 13:40:01 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hfsplus: make splice write available again
Date: Thu, 29 May 2025 08:00:31 -0600
Message-Id: <20250529140033.2296791-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::35) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: b33affb0-e726-4306-d6fc-08dd9eb64f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fifFUX8COozdVtA56LPl93X5b0SHjDxA2Q0h3ZU3mo3JHrizrJcohhaw8xD+?=
 =?us-ascii?Q?timr7Ty3bFm9s7151vc56/D2FlIWs3L5sZG6Ijo6OrZuvAI3MgdfFq91kzTN?=
 =?us-ascii?Q?ceNP8dOBuTeSJqb6PViake+r19fQTXSUioc3aBc+0o7YRbW++mELRGf0ZwXH?=
 =?us-ascii?Q?uYcKj+IDVrbxWXis7/JjlrDsK+38H2GmwZmNV4vqMhb9eFLr8D0XvCKDmWkU?=
 =?us-ascii?Q?jaAfDdpDAXGA4gUQ0ZswfUp8ajbAxLEsirqVYvQI9mVGyrcdLe9Q/D/EulXu?=
 =?us-ascii?Q?K2nAM3DaN3+hAXhtxLCYqk37jcI5z9T/KlEWj+NpF8wkQNeU9uYbhvi8JnEi?=
 =?us-ascii?Q?B4krlIkt3j8EMNm8IfdE1p8y3EVaOix3i/CjUV2G1l/O7BhIpSTiIUTrMEH+?=
 =?us-ascii?Q?b09UO23BL02Rm1JAr2PHNVbitapxeXU4lxn19r1mWjD1r9s86JvR3gY1Le+2?=
 =?us-ascii?Q?OZ1tvkRAJApqT7b6IMho7uIDi3cbL54rOFjEnAWVGRDz9OomWtkAjTGI1buQ?=
 =?us-ascii?Q?vZx0SLJ2xbCn5eBEDdS0SLjsbmPJi4h1kM/4042v+QTuz7/OMUclmr9sHBGq?=
 =?us-ascii?Q?vgdUJQ3zmJSQXsdcbOCVPKUVN2KbQ5Xbl6ISh06nRlB3o0kv+MxzVSs8bGc1?=
 =?us-ascii?Q?WHw8jYiRM2l6DYysWQDoGP+IZTFvFOFw7dUmTSfx5Mz8OvuUm2RnFtpbZXg2?=
 =?us-ascii?Q?M/zDRa7SvF/HQ/vSYzSrbWE91TcOqyh4zFB382d/HIp7G8EYdXnDvihwfnAB?=
 =?us-ascii?Q?I7u37fvPMGUVLyC9uFGaDuJl/cziw78IAMYqSR+WvZ4SaR4gzLfQnDhnBdBL?=
 =?us-ascii?Q?ozac7o35uwH0ga7SGtwPYInGBXB3FzbB19TfEFuQP67UVmPD4S+g84WJlMMm?=
 =?us-ascii?Q?WXE4jLTocvuUwrfC/sKtoQib1kefjP2ywC7XEIQcmJOjuqf+tZ086/9liMka?=
 =?us-ascii?Q?xy0Vj/NS+NCEauF7GxPuc0uKCytFFqUK1xPoptXP1mKGulKoIBL9ZHfLP4vi?=
 =?us-ascii?Q?+sn0kzAZaw8GhDjpP8VwMfg8ztC9bEljYZFCQj20wfVE56k3j7Tlv+3A4YkF?=
 =?us-ascii?Q?ozYxAW7/o6eKnZGGbE6PuwszXU+DO0NlFvaubL1soYd8t4ODI4xRM3J2aBCO?=
 =?us-ascii?Q?1cB3QrJ9OVfkEQ4CuzXe3ocpuLk5Xkw5VBVBbdtOkrWcJoiF6VOqEVyrpI2G?=
 =?us-ascii?Q?GRZIycqoN+n+QXXr8B3PjkMeG5UEOVqVTfvwZ937fctIVO9iRAwcNLmT4qKE?=
 =?us-ascii?Q?lx4DC2rqBsD+qaf2TMD1bqYs+e44Xrblew0/O4qHqUYlEUBP6oQV/3m2gTDt?=
 =?us-ascii?Q?pTNaXAx2YBj/LKw5JSEmT2K2iTtehFSeMXaBpX69RUr7yVfoiVVwcOnt5fE+?=
 =?us-ascii?Q?IkKkB67cI0ziFQWctj18wBEcRgut6esEG5BrRfPYGYyihFjg4UG+RFJMJAqM?=
 =?us-ascii?Q?i05pTHk0kxExl5vcDi7ToghG1ehnyWZF2sCSDDjJfRjDx515WQ4nPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jzJu8YjW0tMgt9Ur6jUUE3r1cSRUmOxaUXr7HMdlEUzLGu1E9jr3GGK1ABJz?=
 =?us-ascii?Q?6A9dNOZtnav5aAV4KJ2fEzFQWXrJ4iwBPF4sGIwvFHp1KDw8e2wMcufabel6?=
 =?us-ascii?Q?G5DWwTi5PLrOcYbG6rOvHSFAysckfDNhhClUiD1HJWrCZm1kBitszJnDifMF?=
 =?us-ascii?Q?vBmO42XZosWXktc61KNnduPUUvTvEO19MP/aR5b2qjoA5XXXe7hMJnkOzapy?=
 =?us-ascii?Q?JcKhbjCAD7epl1o3EVNE9AoPeGwd3M7aoF2tNn85vQj5ksBUzUlCqfAwi3tF?=
 =?us-ascii?Q?vRijlfx9t+sNIXOR8hSBo0qqGlcljepkw0l1/Upmo7MLMpxsss0XapigihM4?=
 =?us-ascii?Q?GV4GOeP+oiBoY+tS840XZrgDTKagV3PrcAFMQQ+ZUvK2Ww996nXS1DW1rVZR?=
 =?us-ascii?Q?3Z6c+dOlhznfkugMH8KD/9crlfFw7cOMl2swwsRCq7e1bck97pMMjfTyiCno?=
 =?us-ascii?Q?xKLzQIII9hu7myK66WhQ1csBCACCQr5tcrs1Zkir4bzRKMpQ47aHbtcrwmdy?=
 =?us-ascii?Q?xRRxe7R2aatDDzuEbn9bZJTo4kDh4GQAD4EgKrzRWDLmKADVo0jiIS9BxA3S?=
 =?us-ascii?Q?aOBGGYQX4YSo7TeAgMmcfLpJvwmFSw0kazHq7Fnr+L+VdSvI/UhuIHGdvVz4?=
 =?us-ascii?Q?9o8dAIEAsL6zN/SKisQbjgwxqScvU8viMl29c5n7cD3ukUwgQaAQWN9BHUyi?=
 =?us-ascii?Q?emRpWwYugAxV3M+pcPYvZ6Q+jo4yu8lGZ3KC+4X+wz8UpzMb5XLQ9FPsU+nM?=
 =?us-ascii?Q?JWgZbz7nzQEkMoJUDRNqznxOzQIbdRz5+t+yTnV7qOZRVZvpzu+CIc7GBW6b?=
 =?us-ascii?Q?n2Rwa1isrE964m1ek3xRGjt16OkHVvGLK/QkPSlmPoBa3zGmIWyrz9SUJifg?=
 =?us-ascii?Q?oodvO9zZfJBo0HEiB5THRYhw3PBLdV9xFnuGQ+jW4/YvknLNlCWLUr5VhN1w?=
 =?us-ascii?Q?cLbrffWy8q9NJr3fQXp+AnJn3WTE+FeRoqprsgagIUzVGHzrJ7yUDsxMCnKR?=
 =?us-ascii?Q?8h9wEQRxuhn5GA1yEe3CIF/rQTwmSNdI89R4E+20ryElX96Wn6xz8n3YcVB1?=
 =?us-ascii?Q?IPFXXHZ+iJ6NIMXmrX9F6tT3yOQV2HkfSTRlf94DUT7dwDjyXKnzTb52WTYm?=
 =?us-ascii?Q?toAVvjQaOtdCYVnVTL1yVkgROpoKj0S108pXEiJrxeUSwULgc6HrZu/Rq88Z?=
 =?us-ascii?Q?bHSDvAF8MnCbjBdazA2j3ZaJdrD1sF+A4z9Ps5/T2XYn0mfzmnUzKXPHnrUj?=
 =?us-ascii?Q?9bwuTK4w5cDx988ly1graZn4nrEvfvb1MFqAo4h2g5NOGtJ9EEyEeJyHKbuq?=
 =?us-ascii?Q?vrALWyh54u/q91TShRAYP5dnzhgZstEEazWjiVXUIjlkNP93KwoK65KOV024?=
 =?us-ascii?Q?5ed2qfhSiWyG0gULGrheEb9X5XOFi65TJymgnsCtDqKAVdkZuPUyhtGHRhov?=
 =?us-ascii?Q?3BqCcNZi/FXyPp0/EBtwbbWuHM0k1WopqUrm4y8a2IrO7GzVgO29I5+qGE2Y?=
 =?us-ascii?Q?soKFuIdgQ7UdG8GE5p+V3vIIoo/jtJR0CfAyY2MxiVWeYkxPQedSw3L53Wdj?=
 =?us-ascii?Q?xnT68UrCEhtwNPbYZ01xeUfrYFGRxBuuOsQ6beuP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33affb0-e726-4306-d6fc-08dd9eb64f26
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 13:40:00.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JVV4A3HaIhYAhezhHUTeEm/Iq69pbZN5y61IYs8YGbK7d0cMPXaNHKbQoeLpTAeCELtCmqOcM95CWZm6Qh2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034

Since 5.10, splice() or sendfile() return EINVAL. This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfsplus/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f331e9574217..c85b5802ec0f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -368,6 +368,7 @@ static const struct file_operations hfsplus_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.fsync		= hfsplus_file_fsync,
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
-- 
2.48.1


