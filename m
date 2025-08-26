Return-Path: <linux-fsdevel+bounces-59157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC9CB35245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9F43B2A98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676A23FC66;
	Tue, 26 Aug 2025 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n1ymOUSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013055.outbound.protection.outlook.com [52.101.127.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363812D3731;
	Tue, 26 Aug 2025 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179461; cv=fail; b=IqPv3Ro7Z9V9wtGPY7oMnhvX44CaIpMrhjNFHmvCTJVzqHThjACemURV1goP5Z1/1uoRTqfjnzuey5LtydM+BgTycLNAtbhx2iYID6L83Iq+2hBYUWcixWX7TAsFJM93Q0maxMIT2+Zk87sK7dxZcyXId+t4jR7S9KllwEWJEG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179461; c=relaxed/simple;
	bh=OwCYh9IurLDC/c2pQUjCGwiY9AQi1prv1MbGyjRYxF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rf041Awh6kLt2jEcIMIMgFNBDs6EM03qdiwepbKe9v7gvcy3chCtN9JnCLd2CduEYr177970HzJtSik9PFhr0A03Wy9j07D7Kxz3reowTK95YCGgoueLSUpX11L0tuY2SByGE7brl5huuNviBU0nkuKXVhFEWDRWBLvojliLWT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n1ymOUSC; arc=fail smtp.client-ip=52.101.127.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPOdVAIxLhemmcGHWTGKAJtNtme8cokuAbSOI1FIeDcVDt+ZH5vz393AXuwgJsKpfEjApveD2qzWM/mPrFvQP3LD/1/SI68RZa+7PRKdKvEHrWw44mUpyzzmNKNeE2hUfCRVKofvIj4We2FNf+fg9uzVhsws8bPfl3ECVGQcjjVG049vfc9KZfDgRLNNdrjoGlUUmWpzV1HssXSiFohmUAkNPwOVuwzxhH2IG4ImgeYAMLfXJsCfjpy8qPPJgc8fTmLXKS5N8p9pg0uPpzsAJPqqpsmLB2gr9gwV6yfNPkJkbYoFjSrcQi1FVllUqxG0BEu+jMLll6C/JrG8q582rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARh5dcjodp3ZPnPzP3ZpLjL2HDumQH6RcxDKH88Yzyg=;
 b=Z7Gbsc46irx7D2NlNhgQS6MyFpRtH09zfYhLdqIIPYjf+jxeeNrKzQUbGchVgSSJywQigvep2yzYSpUXCmLu0czbp7Mv3pfwXUadmbfiU/X2Wy68qfBOjgXjZFGw07r7SYjvD87sHHQ47gN9UKQbRix9VIT+v444The/EzZ8SvjR1aLPw1FNTww67gk9WJHs+aYhSlKY++I/jSeER1UofAkNpQoFhRn5YL+zsMCUtXuCbf+xntiGSZqvmhnYR7+M/F/DgLM0jisfokWG0xAuLWgaEnvhsy35rGxneRxngvKtDRJrNOlVEtfHuVTl4b8W/jg+6yYG7CDqeozIK8Uxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARh5dcjodp3ZPnPzP3ZpLjL2HDumQH6RcxDKH88Yzyg=;
 b=n1ymOUSCFbCe43mvGOmum80dsHf65MAmFSwotzAXz2GGqtYVHm+IjCIvTO9y5ln+t85Btf8LwP1MNqUHLEGeNy8OZN3YviLFOkyPR65cePw9sTv3gm2G6tSJZpoBKU7PWUhurrXw00+YtxW+0LgaCIdZueATmPJL6khCW7F1AAqpqu7R90AKpexStZqpaQNmQcVyNz4zdyKUqufrraJSB3/f1uUELC4G+/RKoCkB+pe0b9PGlVQr+J2RLLtvq0g9YiQx1Nqj8oBT1+izBINg0QIGFFRdZUPUT2wBKNi64DjTiwNY7erOtTvAcIrXYjyd1wPbP0caWAOfLHXGxUYo7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by TYPPR06MB8049.apcprd06.prod.outlook.com (2603:1096:405:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 03:37:38 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 03:37:38 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [RFC PATCH 3/4] hfs: restruct hfs_bnode_read
Date: Tue, 26 Aug 2025 11:35:56 +0800
Message-Id: <20250826033557.127367-4-yang.chenzhi@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a54c495-5b85-42db-de89-08dde451e726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oj5KeGfsAZnqTUbyHGd8yCHzHXJtpN/9X1dXKK2sWZLl5TeyShzNPyGqKs3?=
 =?us-ascii?Q?nnYFlbS0W82V44D41c80Gcbh72KQBq5/4EYz70bjeskDCtPzUJ61fIKfPZ0X?=
 =?us-ascii?Q?ZFTgmUOC2DBG5YPOAACmpvNSxVnxe8rH3XmqL2CrjruJJUOQQna1wF8jXj+O?=
 =?us-ascii?Q?ANJLTglJWCJoG/ALe9Zr2Ranwti5ZRIJY9+H5i4hxcLBpZm3dAjvHPRYoGEU?=
 =?us-ascii?Q?Vh1G1Bsv90oiXbyCU7YTgZGghucW3SIyD+Rlam3JReYXuJK6kXfelvex7KAV?=
 =?us-ascii?Q?odUrZKFEgij3ss6g3y2C/CY2hnbpxR36NTXUvj+ahuE6rywqEXDnZoNiP7my?=
 =?us-ascii?Q?9imfxOxakxB+KmzC1Q7Gx/wEQC/Di5h4hqPywtbVL8Y56sell9ZrSzs0KtC+?=
 =?us-ascii?Q?oCqyTnDcIaLCzO3w52XXH6pk+noagyL5YqcBk3yJDZNNWNGFFJeAEXKRSUL3?=
 =?us-ascii?Q?c5xwHq5iFFx8jt3nMLUoRA7MlXQNbP5tu1renETFND1pgF5AKbV9sHH8zdVV?=
 =?us-ascii?Q?Pj7AW4YTaf/ux9ct6H1pBmYh3H4AUgksDkOIbeWhys7ac7aavsCycqPk2p3E?=
 =?us-ascii?Q?/crHXk9XbbkZaLIQ/iNuU8sd6mBtVqJPk2ndRF7MVTjpq5mG6Ud8a3F7mw7x?=
 =?us-ascii?Q?AIaG5GfS0DEnEjOG/umsjBsLRgW791+LKNBZ0Sl6XShV57cAYVFqoSaQZgdb?=
 =?us-ascii?Q?iG7py9FmZONt2t2ewJkvSVL6sJedbyCafwM/7OkI6GwB8o5QdqWGcwdWyP74?=
 =?us-ascii?Q?BN03EeEIC9AmH+8hyS9i85LxhdjziYAraJTjBANPBUYqF5VqOsZKX/IJXmON?=
 =?us-ascii?Q?oEBe0WTCSl6JaTaUr8maf3FkJ1aedR/r4HM8RwtwUMz+X0FIRkGp8UUYf7JV?=
 =?us-ascii?Q?yIZjqCr3dYYU2mIY4D/M8ngLI0jpJThRsnZnagyQ7hZEQSafdK8eTkwZRGz0?=
 =?us-ascii?Q?IgtbpWDa3TM488fsGhilikdLozcFRqUeEJk5kZ6SJx/+NKFrXAbkqLyvGfOj?=
 =?us-ascii?Q?1pqudllLVGvGSHWgzmE89zwdRdseepy4hJF09DT7Rvo9cUrMI/yXXykoB7cT?=
 =?us-ascii?Q?FydVw5OSiChb8LV3I8RKBLbvvMUo/HTm2qqWdDBgHvKERCRWK873lGdtxlsL?=
 =?us-ascii?Q?vQtNJpG5VPkx8xPS5t/PflYBhpiZeqixoJbqYkKlZvz2zDiPu7jelZt58Jrw?=
 =?us-ascii?Q?4KrjAT5rW0iHaxG44Rp92s6SYB3zz6reDefyFcyQxH/ULIuoim1jDGtm/GTn?=
 =?us-ascii?Q?N1J8IrFWT2XcUPX7c8j4TzCYyMI06xhl9AEs+nSC1FVKk0K/TW1tMGg0asop?=
 =?us-ascii?Q?mXFEOehgaGaxYU3VvEsDEF6AF+piGNPPAr+GD/KxdtU4xTCAsuA8IXjmNEHH?=
 =?us-ascii?Q?7m4G5EY3+MQJnsDjDaIIT3SfzGSvYmvsaG5Dgh7Gg2+e/kiFJv0EnJbPKbJa?=
 =?us-ascii?Q?4M1S1CNGfuP1hQW4EzE7tO9WR1A6nchc9CJ1CttBWBWmXgr1bUJgrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keMAbUihDxsuo5et9TPPK/BoFxv+XqlykcO/fc4/op03S9Eo2lKBWqSbV7LH?=
 =?us-ascii?Q?HBmiECydSoCLWYA0/5TbpkKvMBFxMd+If+kIah3CsQaiaFHjDptm0emldh0C?=
 =?us-ascii?Q?XB5XB2xcFG8WGx6hBP6ScI7Una5HGFS55TfWEsHVqDUubrIXcWgxQEQymYVS?=
 =?us-ascii?Q?yKRJkSjmp8cqJnOEtDLgYvUtO3ZQmuW39pWnAl/2fIufQf9BiZX/UC2++Be/?=
 =?us-ascii?Q?6/U160tG8OVRM7P4QiNPjzF+rJ0xhsuhU12Rn6dH3INLuKZf+LyL4EhJuWqD?=
 =?us-ascii?Q?zWMTgwNCmiblgKkTcHYYw5BLD81LWvmUlClaQi+bptjJog6UUmOWexCDUIz0?=
 =?us-ascii?Q?XQzrMH0y0khrgl0UtZH8Q/xd2Lu1+wopJA6RAA8pT+AU0OGd8OVflNg5Bmqh?=
 =?us-ascii?Q?WB/AXk4BpYvSeSNvEHOoq0hG/gXyHPEslZoaVBLLukis3ptTalASFnNhuiav?=
 =?us-ascii?Q?eDRCo++8eHeFVCjE9+VDlPorxb9moCbcXxFoowGs61io19r+2a0Q3oYay6FU?=
 =?us-ascii?Q?DSlpYv44HUiz7BohDkzkStL48hZhDHa3zI7tZeX0cqbttJOXzrbRbfTl83F0?=
 =?us-ascii?Q?mNWUJUwZaqdioAUnAoGbrLzp8JoxTeoZJOB9jGQ7W+Y9FHygzHmXoRh6wFbv?=
 =?us-ascii?Q?pdwPNWBdPYWDHTbVU6Tfa2M1CrN4PZhqpIEPHSyeMlgMQivMbGcXvqFCKYI2?=
 =?us-ascii?Q?4Jvms/auCAj9Q4htm5djB1c/Z9m71XcpIOHp8vP0lJjl8ILZdkjan79mvDiK?=
 =?us-ascii?Q?/NK3lUOT72A5M1Px4xYOJk71urekW8lHw6BDLAmp9u7z/J3Ac8155Cy+6P31?=
 =?us-ascii?Q?a+YIqwnoFh1oKh8tpk6gMKuhWu82fR7meMkseOpeWyb8uKDRe4mv/6MOkkwk?=
 =?us-ascii?Q?tLuKoQG7AkrdFKD6TxR0yYxRzjZqrdeXT9LOSYxNzlfYAPdUIvpsKPARkY+J?=
 =?us-ascii?Q?C35v4/T5Poyzzu2A1NlmihDrmJ+lRZd0niwI04gYfhpCD1e8NOI6TTUl/S/t?=
 =?us-ascii?Q?S9o+yJ1Ebo8D1RegbADeqqx4Z5KaJwvjGuAkn30Fx/vG6K0MCW8SNCPT8eVf?=
 =?us-ascii?Q?abHlrREwD/itGILJYmeHoOYNYMAjWlJDv9g91mzE1u6xsE0jgtP/Q61KUsv6?=
 =?us-ascii?Q?rNgnEKSRK22ho8SCv1saDYGL6lZsts2zY3heIiFkV7lb3mVOFc65pRHWsG0g?=
 =?us-ascii?Q?IMdnvYiBAhciUfjGMkbs+qvof7N+Rwpr7qoAMIu4Y6dAxpMwDAQrishINavM?=
 =?us-ascii?Q?S/6R5sHQj96SCY+9AP5F5tRs/SpOldPr0MRtKXZJHHDZSTVLBFEWZpFet7Rg?=
 =?us-ascii?Q?Zi1w1yFIzePy4b6oiDrWDzECO4fveGR3CK40g4C1ZTrdPQYo31WeS5l28S31?=
 =?us-ascii?Q?Z6YszuYzYC6n48w+EGCYRgb1veupUjknCEhuy9vrt8fczKsxdnINyRpnv+nt?=
 =?us-ascii?Q?Wi/0GUe38k7bNYbuwMroB6yyrtDqoyrcmtA7+ThsmZ0Qou4NrRjDpmloIRAB?=
 =?us-ascii?Q?NspY06MY6NRkaUtpWDPXx98G9xezUWvHfI7Oa50AKGa+p1HsM1cgzEl5qaz4?=
 =?us-ascii?Q?0wMOlTky60C5JR/bcCnH4nmQo5I0pltMFrBULB8I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a54c495-5b85-42db-de89-08dde451e726
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:37:38.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc+P6hk2LRd1CAitUuQR9EQD+0VAYfUCPwuk9GPxC7ksKEH3K5PgBsDARFUcDKrFRYjQsab6tMlySklXYvhiKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8049

From: Yang Chenzhi <yang.chenzhi@vivo.com>

Since __hfs_bnode_read and hfs_bnode_read have the same
implementation, make hfs_bnode_read call __hfs_bnode_read
and report errors when detected, while keeping the
original function logic unchanged.

Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfs/bnode.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index da0ab993921d..b0bbaf016b8d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -112,40 +112,18 @@ static int __hfs_bnode_read_u8(struct hfs_bnode *node, u8* buf, u16 off)
 
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
-	struct page *page;
-	int pagenum;
-	int bytes_read;
-	int bytes_to_read;
-
-	if (!is_bnode_offset_valid(node, off))
-		return;
+	int res;
 
-	if (len == 0) {
-		pr_err("requested zero length: "
+	len = check_and_correct_requested_length(node, off, len);
+	res = __hfs_bnode_read(node, buf, (u16)off, (u16)len);
+	if (res) {
+		pr_err("hfs_bnode_read error: "
 		       "NODE: id %u, type %#x, height %u, "
 		       "node_size %u, offset %d, len %d\n",
 		       node->this, node->type, node->height,
 		       node->tree->node_size, off, len);
-		return;
-	}
-
-	len = check_and_correct_requested_length(node, off, len);
-
-	off += node->page_offset;
-	pagenum = off >> PAGE_SHIFT;
-	off &= ~PAGE_MASK; /* compute page offset for the first page */
-
-	for (bytes_read = 0; bytes_read < len; bytes_read += bytes_to_read) {
-		if (pagenum >= node->tree->pages_per_bnode)
-			break;
-		page = node->page[pagenum];
-		bytes_to_read = min_t(int, len - bytes_read, PAGE_SIZE - off);
-
-		memcpy_from_page(buf + bytes_read, page, off, bytes_to_read);
-
-		pagenum++;
-		off = 0; /* page offset only applies to the first page */
 	}
+	return;
 }
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
-- 
2.43.0


