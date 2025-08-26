Return-Path: <linux-fsdevel+bounces-59156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE111B35244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A57B02E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B62D3EDF;
	Tue, 26 Aug 2025 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fRjbm8tc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013055.outbound.protection.outlook.com [52.101.127.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A42D3732;
	Tue, 26 Aug 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179460; cv=fail; b=C54B7u/IbaDomUoITcCXgxw0XO6xGQ0FtD1ZlbtshEXJCz0FhH9XEMS/1Kp1F4oT6QHrd5x1Pu9p77dUQtBO4evQ0/9+qIT27oRtNnQCSXianti04IYZZ01JvelvBJMkqbXJ0welOGpMcPpItd3b82mFFXVfDNySRieGcJXoou4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179460; c=relaxed/simple;
	bh=Tn252cv819uc3eQc97QlJbW7i4jYO2SvmKFbZW6PXY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUUF8yRaImkcR9+vmmZfQO4jUnbsCtRS3lhBkdwf79GatLBQIu95AVb2V4xF9NMkvCkirU41f2JHR75tafk0RAG4uiAaYlwa6r0kR+IrqGtiZPj7yAHwARWcE5HJB3vTmOgpDVlY2Gqrc4ovmugC5s8E45lFv0dIAqw4gGz5/M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fRjbm8tc; arc=fail smtp.client-ip=52.101.127.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMrwPRFcdlYsHfyw7jVOXaOHciNqTDUV2eVnaaPYbiQZE3TbewQQshDAb9j6PCj8hP3I8UrX2HVvHA5oBIBTzLxsl6dTrK7FHl8/J60hLzCy8kNwkmZP93E1+ckt5O5wV/pKqRziKAR37dO/HrSfVh3dF6eQYN7FNHKgPal+CVkCCXb49Wet8cUapJ58G3pllGqP71y/MN1ICqKOuY3C0j4GyVpMSAIID12cLMP4hVAPLe9WpYRJDTugyIrhRN1av73jpVnrW8lUTHU6UyyJb3ZYm6/rsMwWlYMLcl/fwk8DJZqsfVogRIfLkLtdsjnfCabrno/rKvjOB73KuGQg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR03hK1Pyiu7MPpKxqm4V5g53mBQm0rieKvi7dRhbTY=;
 b=G9eljkeVHZ35yn5indKV4owiKxBZPZ3PrVsDS0qoEuQz4s9R8P4hSc7c/jelev61PZbqAJbgw3wSbYX2BxXSiVjQMqx9OdPOBrU23RL4xpGjqUt8d2OqM66phaCnGkNYeyf0X/xNBZTs3FcCs1P97WN8+rTM0ABX3qYKFZtgzsHfKwbiFyc82UQr0Mm+cU9CUJa1WK92U/Xg34UOi2IVdZX+wNYq9geV5aiBNydPxIPlh9qfBxXN5DM65L0NNcVFM/ydVFqsq2Ohld6NFni3gIVM8/0CZscOSMCy1FGvWv5jeYpSNHBuFx6jXdSBRGu5PeFJ/6Phb48Y/MznLAwcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR03hK1Pyiu7MPpKxqm4V5g53mBQm0rieKvi7dRhbTY=;
 b=fRjbm8tcDSB3lcShXIKIXTS19ya1vf3DXgx+CfUKM8ru47hxjPk0pc81TPa4ktiHcnU/qAzPQSCjqTl7zeJubteFcni21AbWcEOePG8My7rGslKehzGktuMsk9D1qdua65DBFr/627kEacOSehuOTXZlbVPdo3I2EuIhMkOyPvkdZsnkMXTvNHhoWgY6pceW/N0lbI306AYJ84bzuCFl+fw6Bk5+eBHbycX4rapD5qHs8yKVCdJaRKnlpdSHwxTydWAbqsSjO1qGPuwplk7bEYSusdfw0lIGoMTOxClnjoTeknNQYIz6Rp5cDkJymnTRwI33TOKWgpPwNj/QboDgGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by TYPPR06MB8049.apcprd06.prod.outlook.com (2603:1096:405:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 03:37:35 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 03:37:35 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [RFC PATCH 2/4] hfs: introduce __hfs_bnode_read* to fix KMSAN uninit-value
Date: Tue, 26 Aug 2025 11:35:55 +0800
Message-Id: <20250826033557.127367-3-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826033557.127367-1-yang.chenzhi@vivo.com>
References: <20250826033557.127367-1-yang.chenzhi@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To TY2PPF5421A6930.apcprd06.prod.outlook.com
 (2603:1096:408::78f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PPF5421A6930:EE_|TYPPR06MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e2a0be-6298-497b-e2e5-08dde451e573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOIfuqYd1sYBBusDFFOyYsARX4tX7ZF5Dw3FJ/QH/84zlh3H2GFVcf87rBWW?=
 =?us-ascii?Q?KgmFSq9q6HD8Zv4BqzuHyzZcZlSnsQjLsDZMD7thGt/Uq2vaccHCmqsogXLc?=
 =?us-ascii?Q?u+XnSv2/g/wixTQHzvwIJo20bZ5+j0o0IRqNmcxOYIbN9LT/mvcMg5X0OpLr?=
 =?us-ascii?Q?J4LJQa1dsVoQX7B67se0F3fS0Vlp7VF6EWX6huJ4jcXSykwqeq6u856g9Ixe?=
 =?us-ascii?Q?c4NPISPN61ksAZhKjPP3ZSG6Errm+APzwPvE5vA76LQpSq67NHCOzRBsSnRp?=
 =?us-ascii?Q?usFbFSrINrlvSxyvlkcJANvINf3U6MrqTfukZAGDGm6+IwsflSx/1iqfKokT?=
 =?us-ascii?Q?cJYSxFYB1YG29IJLr9mdZVQ0QZPfvPEWjlN2FbRc/DJpj9cfwrEyknO+Zp1Y?=
 =?us-ascii?Q?Gq0AMwzs5E4++pCREp2nhpywx0s6idwpUFlgGPw8R3PX9qjE0RUIDVvWZZyT?=
 =?us-ascii?Q?5+V7Rd1zDDfd7JXZVkCYn9qeYGxgfMR9dgkSl0aGXtp3qz58NbmBGJjK/r+j?=
 =?us-ascii?Q?qpFU0Y6QMsnN+jnKneQh/b9GLAsDa2cUFD4gvIy72Ub5ZG8DZKjHgneN/y7V?=
 =?us-ascii?Q?krZCthdmfX0xFImK3+024BayX2dXj/eKN9SZ2HIDBVrg5UzyxgpdmKO6GqBU?=
 =?us-ascii?Q?D7ryxCsMmnQGFTOCvQg72qBW4UxOmahGEGuiIhzKsN94/prymAYuL5Ld5R0F?=
 =?us-ascii?Q?unIswIHkS/oly+bDReVuMAtKXbfMYHwHET716sv2cCFMOHudwd1YJEG6hIuk?=
 =?us-ascii?Q?T5gTr0bCvgWkzkNHPUBZqHSA5DZc8el7rlPhCeA4fCimB9pUiwzcmlgFNtTw?=
 =?us-ascii?Q?iWzE1TlUlW+H+HFjX8w57G2ZlYD49i69/y91rNe2iu8oaNHQqDrAyIxTC+9F?=
 =?us-ascii?Q?/zJXFhS94RteOZJyBydY9BoHJLRIgQ/ccxIT5NVbFWSJyI2Sd7P9cpChb4yi?=
 =?us-ascii?Q?cJs3yKvuWrQC5BEc7qPmswDzZGG1Vqa3gBPjhDl+wwNBethJH6BoJ5Y6QwlZ?=
 =?us-ascii?Q?Dr2TXnLBE4SNMfAvhcnsDSq0sxVyycXiBePcxw7lxBT4uPy5aLa15TbD6uFh?=
 =?us-ascii?Q?6lPskeiB1gP4RJmUluY0oBRhRAl3SlGcBzNT4M29BZFFyPNzyuUEHqy16497?=
 =?us-ascii?Q?T8lUPZekWjPF+TN57zqiaAx/MjlM4Mb2RgByiQ7dnDWTFk2VnQazRZIJ8lbW?=
 =?us-ascii?Q?W/P0P7FxOiRhOi9+2+mGZxAzJ826+4FHRui9WGIoy95o/fPjQkLkTQHfgCod?=
 =?us-ascii?Q?v/7MgZOyCfWSnSl5jWHCnFi0G9KZeyvMQfpu6QxOL/614HVV4LXTvBjkiB5j?=
 =?us-ascii?Q?zKnYLEJUDBsQjiKHiw5rr1aTc5Wcv73uWVv8PcbTR6re7+PMpW5he0u01Hme?=
 =?us-ascii?Q?fy5oB2/drmqHlROc9KdyQIfDnBaix/Yh2bRULG1Vx6Yt5eGWfRZrfZQ22Epl?=
 =?us-ascii?Q?+AdQ0iExlDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxEsBzOSgr76eXw/1p1x3BHUglbTtB46BhoXHLsLreHr1Ziq78MjDnO3iNHJ?=
 =?us-ascii?Q?VNSF8aZKnDznXfbBOaRzAcBusAOoxyaWwdftbYACC3YjjgcK8ZVKROX7orcH?=
 =?us-ascii?Q?Jjk14kFvpSGsPx8fFuHf7zbhhoFBzo/Fw95T2dLMPo/EU2ZpIqfDeB3duAXP?=
 =?us-ascii?Q?GX0WtPV1DAXneUzltjUaQsMKcKf71kwQ6S1+o2KoFP18C9mSYjC346qcYFM/?=
 =?us-ascii?Q?ZzaqOICeaU9BOuRElmPxxlD0qqV0sEIYV++QbCCLTHG22KAMkdrAuHsR7zBv?=
 =?us-ascii?Q?zLE4+VXjklgdAZm1SXoVxuYae8LFaxmqbG+lQB82Ffa1zRK4/sCMW3l+6uCa?=
 =?us-ascii?Q?+D2lJN7fpML9I4RS5wRYmrzHAYlXTR8oflqlq7YaMsjlYJPv4myQaiyVxhad?=
 =?us-ascii?Q?aKeatLUUc1j12RrBZYXF55fn+eFqwOlgpDzeJPwI5fDdDU4k5bkO8Qzmv1Ll?=
 =?us-ascii?Q?/U6D5tP3JaYRFy015I5NaMztjZhjwBaeO0UC4/TRn+S8+4W/GBrJvqwuJs+1?=
 =?us-ascii?Q?NQtIxkuc18ooliBDwIWkqR/X9N+jRl50Ui0OZITVvoKc4lCdBiHz0cSg7/xA?=
 =?us-ascii?Q?hkCiSV+2BUyHFxupKkwy0J8c38D1mP+qtcy09/pqEZ7kwC0RAXIX8wORhDYL?=
 =?us-ascii?Q?rGzIzEQjWdWz2AalP08tACIeHeMFjWsoh0FezOu4jaOmpvslRt+NTl3Q8GLp?=
 =?us-ascii?Q?6XQ3ODfqRRXCNzPl27m6FwEedx4w2O6xLgv7TTJuQuqq+Wqn/F8XIhcJLDvD?=
 =?us-ascii?Q?CS66fpmVpBGOX93sX+H816acyKA8J7P+iMPqEfz2QfsMor24APAEcGCFrMbb?=
 =?us-ascii?Q?NRN29iH8yDauJn4m6+uA3nv+D1NhueDnlQqtLeVeYzpZIKtR8UN/H6kLTvXo?=
 =?us-ascii?Q?kmENe0tZcE+gvT67eG1+loXiKhau4Y8NiSK4uSAZJtYGuh0z6MJluOMZQYWb?=
 =?us-ascii?Q?4HD1m++jvZqXeFokzIDUsr8N7txb4LBUlkdN2/ZwY7hhTjdTLK1CTB+wqxSb?=
 =?us-ascii?Q?vxSflekFtn73GNRmVCh4lb4LbpZG2+SiLb0wJZ6p2uukIsFNuuUX8waYtQLg?=
 =?us-ascii?Q?oeVUkdsbmglwu//Hw59VgmRMhK3/485bbIFxpIiDDG9RkcKXiOycZhQD5izA?=
 =?us-ascii?Q?lyityhDX4QcYZIZ1+s/dl30y6eubq4xkbvbygIqXuZ56eI0EzsoH7gLXuNUM?=
 =?us-ascii?Q?aovAJaM26G/mFBMUQtorKQymNe0TF+v5o9plO8icMeEjYL29WFY5G5AcaI6y?=
 =?us-ascii?Q?ZJqhEWxZfENbH36R1FSu/6+71Z+uF0qwIoq81EucybHwJzQZZ5HV7Z212zUS?=
 =?us-ascii?Q?NLuFmJ1t569Wc120UBtIssJF5q87Ih+5KAT2g2lWeKFqWOMDEaiTnygPoJ/M?=
 =?us-ascii?Q?uWGGIRk0XwbIN/2b7W0TNQn3V8Erw//m712daCgLX2pY0sFDQrYTDvgBMR8V?=
 =?us-ascii?Q?p52Cmtw07AWim2h93D118Ac7d2YZasPzpEBsTHxHBGOFLAR8YdbhUFhjd1HX?=
 =?us-ascii?Q?7Bj66VZwgaSkM1R+Sctitv9/wzV1L8M3shPCZsAhsWNfhhWCNm6wi1NVEehz?=
 =?us-ascii?Q?kWH7m6drduVNS/WESg+3/Rj+66klW6nfsmcpCZ61?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e2a0be-6298-497b-e2e5-08dde451e573
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:37:35.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zq7Nas4bs2ZMqNuUCO62tVdOoBYD8+21+i0TTUYXoOXdyaeD6z0mVQmT1RdkLxBmPIDFxkHVoAPFOO8C1F0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8049

From: Yang Chenzhi <yang.chenzhi@vivo.com>

Original bug report:
https://groups.google.com/g/syzkaller-bugs/c/xSRmGOV0xLw/m/D8DA6JGcCAAJ

This bug was fixed by the commit:

commit a431930c9bac518bf99d6b1da526a7f37ddee8d8
Author: Viacheslav Dubeyko <slava@dubeyko.com>
Date:   Thu Jul 3 14:49:12 2025 -0700

However, hfs_bnode_read will return early detecting invalid offset.
In that case, hfs_bnode_read_u16 accesses and uninitialized data variable
via be32_to_cpu(data), which trigger a KMSAN uninit-value report.

This RFC patch introduce __hfs_bnode_read* helpers, which
are returned-value versions of hfs_bnode_read.

In principle, hfs_bnode_read() should return an error, but this API
is widely used across HFS. Some heavy functions such as
hfs_bnode_split() and hfs_brec_insert() do not have robust error
handling. Turning hfs_bnode_read() into an error-returning function
would therefore require significant rework and testing.

This patch is only a minimal attempt to address the issue and to
gather feedback. If error-returning semantics are not desired, simply
initializing the local variable in hfs_bnode_read_u16() and
hfs_bnode_read_u8() would also avoid the problem.

Replace old hfs_bnode_read* in hfs_bnode_dump with __hfs_bnode_read*.
so that an error return can be used to fix the problem

This is not a comprehensive fix yet; more work is needed.

Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfs/bnode.c | 81 +++++++++++++++++++++++++++++++++++++++++++-------
 fs/hfs/btree.h |  1 +
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index e8cd1a31f247..da0ab993921d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -57,6 +57,59 @@ int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
 	return len;
 }
 
+int __hfs_bnode_read(struct hfs_bnode *node, void *buf, u16 off, u16 len)
+{
+	struct page *page;
+	int pagenum;
+	int bytes_read;
+	int bytes_to_read;
+
+	/* len = 0 is invalid: prevent use of an uninitalized buffer*/
+	if (!len || !hfs_off_and_len_is_valid(node, off, len))
+		return -EINVAL;
+
+	off += node->page_offset;
+	pagenum = off >> PAGE_SHIFT;
+	off &= ~PAGE_MASK; /* compute page offset for the first page */
+
+	for (bytes_read = 0; bytes_read < len; bytes_read += bytes_to_read) {
+		if (pagenum >= node->tree->pages_per_bnode)
+			break;
+		page = node->page[pagenum];
+		bytes_to_read = min_t(int, len - bytes_read, PAGE_SIZE - off);
+
+		memcpy_from_page(buf + bytes_read, page, off, bytes_to_read);
+
+		pagenum++;
+		off = 0; /* page offset only applies to the first page */
+	}
+
+	return 0;
+}
+
+static int __hfs_bnode_read_u16(struct hfs_bnode *node, u16* buf, u16 off)
+{
+	__be16 data;
+	int res;
+
+	res = __hfs_bnode_read(node, (void*)(&data), off, 2);
+	if (res)
+		return res;
+	*buf = be16_to_cpu(data);
+	return 0;
+}
+
+
+static int __hfs_bnode_read_u8(struct hfs_bnode *node, u8* buf, u16 off)
+{
+	int res;
+
+	res = __hfs_bnode_read(node, (void*)(&buf), off, 2);
+	if (res)
+		return res;
+	return 0;
+}
+
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
@@ -241,7 +294,8 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 {
 	struct hfs_bnode_desc desc;
 	__be32 cnid;
-	int i, off, key_off;
+	int i, res;
+	u16 off, key_off;
 
 	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
@@ -251,23 +305,28 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 
 	off = node->tree->node_size - 2;
 	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
-		key_off = hfs_bnode_read_u16(node, off);
+		res = __hfs_bnode_read_u16(node, &key_off, off);
+		if (res) return;
 		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
-			int tmp;
-
-			if (node->tree->attributes & HFS_TREE_VARIDXKEYS)
-				tmp = (hfs_bnode_read_u8(node, key_off) | 1) + 1;
-			else
+			u8 tmp, data;
+			if (node->tree->attributes & HFS_TREE_VARIDXKEYS) {
+				res = __hfs_bnode_read_u8(node, &data, key_off);
+				if (res) return;
+				tmp = (data | 1) + 1;
+			} else {
 				tmp = node->tree->max_key_len + 1;
-			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
-				     tmp, hfs_bnode_read_u8(node, key_off));
+			}
+			res = __hfs_bnode_read_u8(node, &data, key_off);
+			if (res) return;
+			hfs_dbg_cont(BNODE_MOD, " (%d,%d", tmp, data);
 			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
 			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
 		} else if (i && node->type == HFS_NODE_LEAF) {
-			int tmp;
+			u8 tmp;
 
-			tmp = hfs_bnode_read_u8(node, key_off);
+			res = __hfs_bnode_read_u8(node, &tmp, key_off);
+			if (res) return;
 			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
 		}
 	}
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index fb69f66409f4..bf780bf4a016 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -94,6 +94,7 @@ extern struct hfs_bnode * hfs_bmap_alloc(struct hfs_btree *);
 extern void hfs_bmap_free(struct hfs_bnode *node);
 
 /* bnode.c */
+extern int __hfs_bnode_read(struct hfs_bnode *, void *, u16, u16);
 extern void hfs_bnode_read(struct hfs_bnode *, void *, int, int);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *, int);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *, int);
-- 
2.43.0


