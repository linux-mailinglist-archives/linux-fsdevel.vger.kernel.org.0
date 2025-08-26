Return-Path: <linux-fsdevel+bounces-59155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B93B35241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B661A86224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A672D322C;
	Tue, 26 Aug 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XWt6vivS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62426155322;
	Tue, 26 Aug 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179457; cv=fail; b=KGutF0pi6xhExCCJym2BG3YsBCQT99IihyteAPgg0F7osXBa4SaJCvFLvLvyAjxHV2pKG7iOl1WEpd9V/x6Y3hh1NBBzJ4xA2siJwLF9l0sZd7Pt9N3FlcU7ejRozDoNKYKjwyKhtWF4c7jLj0rqyifRE0IJJ+twr6SYh7I08xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179457; c=relaxed/simple;
	bh=XjWFp3KvMn2RqWYNwDQi+A4WEs8/PtOG0A+rgAav0Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wh8GjGyQmDdgF1OP6N1zOV3IIfdEwi8Jlt7SzF1TVCLC+cTngk3IsTknrATMJZSHzIuH/sT2tF3ANPsF2RTBKq0JJ3xO4KWD+77J7zr2ZNjEwS3R+502FBPdVJ4nvMjMJZVPQAYpTCbJR7qSjZ/Dx1jXzqwZa0RoUayFyMwJQ6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XWt6vivS; arc=fail smtp.client-ip=40.107.44.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAYvyTZ12pVM5deWhIHuhuH6FMD4MyjBk07NGXfPKBHwAana0SX6k1MR6m8UPGjqOAaQu8UL98/V3XRslKso9eY9IeFhSr1pPS1WljbNXb+lV5d5C9oELgiYWNs3r6K37Zyz47izpxdfjC/Isy0HeWg7Ua6Gt07bBKzr5/9mdHNZti10rvv+5bw9hPtwfsIy1hl9/mV48lRWSLfJv+vKkswpHEP5CvuhsrdR03iqwltMfHN64eDP3LGTexv+Xkwel84/r7t0lWbSfx4kzundT1PSjUhrmqaft+eB+DJaZWxpUnWj2ffGsYUyNAOeCO+JIhVfSbAC9xzmJLbflQXrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q40968wNTzEEvILSBwvKGqgEh0Xg8L9CHY7Ik20CaQ0=;
 b=rY3w8X1zRCwF/GMRjGxA5N1KL852cTsrMihuuvXEzwRkVNGwQHE3mLUtOBsWP2T5MK7R2xu8zWhXJDd9FxSPmvrn1KLAMIAnCRTKimpnWcvCEMB6OdYdkmuwSbispobKHJey/gusHujI5mVhPIyOLlA6O4k+RkH7UPm22jVtcPDKeok8rEkdIxjMDh/Ik62D0roi1uzY3uh9eXJAKkhxOp2gOtq/AOlOe2hkkDy1iWuCzt0vwyD2pMkms1fdyXDIjXVUba3yMwbA9FRi3qiwX+ju8mQa2Qvy3b0zHsrQIOBXDo8gm4Fs2Go5W6R1Y3RFgm4j4YkKsoFO/51XyUwTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q40968wNTzEEvILSBwvKGqgEh0Xg8L9CHY7Ik20CaQ0=;
 b=XWt6vivSH5u9EyXuS/kMk6GawZiyA1WydJi7I7BELZm/GDaPRlPwl/7YfZDfGy+WvtLPTI9pwxJ7NFWxFLKhrzSTTsr9BVY+abPJULoAnt8ab+PzQnx2jQWm29f6TSZNNSfLPU2h69oKhYwv7vcRjbOjs1+1cjCExPn9GbumqoHi/3Ok/kL8MqNsGkV/F1Yb30s80YC6gN/lyBgTwIRPGgcz9xF0YTF7VcfCowA9Y8qru+6Ohicr3xGqrk4J6C9UuTqAm2tUqS4Dl/SO1dP+DqAlrKpvuouaapZ3H8x55TvaydBwiZhvTPs80lKi9DnJh1S8rlML1hRo0Zie7mOtew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 03:37:32 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 03:37:32 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [RFC PATCH 1/4] hfs: add hfs_off_and_len_is_valid helper
Date: Tue, 26 Aug 2025 11:35:54 +0800
Message-Id: <20250826033557.127367-2-yang.chenzhi@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TY2PPF5421A6930:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: a80b0dd9-6996-455b-cb02-08dde451e392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zwQmx6zRdogLw+HvUkLNSg0bPBJI51zbEOtND8kx/0vJfZ1mFScMvxatWh9I?=
 =?us-ascii?Q?dMFi+hVJj2oE2+UR6x6xuIqNREcBIZRVCRF2hIw3Qej9xPqkauhsxoHtLZzs?=
 =?us-ascii?Q?DP3HpP4r86Tl18K7O+Y2wteIOJX73XEty4Zgyr2WKZKgjzcBo56+i27qsbw5?=
 =?us-ascii?Q?3JyjdNMIlb0sTflwZc6fgZ/+rBXdEScJlt9EcTwvsDd6+Nx0S6NXINSCt9Im?=
 =?us-ascii?Q?8Urk0sbht/vhn7EJGoe29Q+Yz/B3GnurwlVXq6zwjfXSQTlD2xCaDNlhRm3R?=
 =?us-ascii?Q?YmQH1wdQEciykmkwyCyQlcxbT0HV1uEaULT28Tzxpypvu2P1HVuM2OO/Yv+I?=
 =?us-ascii?Q?EYxmF79dAQBJG3gGlFob6pnabMY9cwGBxA9IgRRHx4TZiNP18THP0KHmM530?=
 =?us-ascii?Q?Ddry4Nue1JIAyUKWqk8LCkgfslkYEF1koRU7XGxVUm+uUN7wR1p22norR+g5?=
 =?us-ascii?Q?NDn2lWTAwBOjVoz09bJrBSQ+BTpzgUf/SVgBW969tQ3QR80DLtvpeJ06feON?=
 =?us-ascii?Q?mzFAWo6vRTFkcR69ExbaxKo7AsQxJjDgu9RjSULAGEVirJZgbBSxtX+OnSn1?=
 =?us-ascii?Q?xm5ioV5LkvhEzK8P9B/CyvX040NnGH/GdcQvjNs2BA+0Bab1Jy1fBXOnafu4?=
 =?us-ascii?Q?kG0Ox8p9qjwOLVKfN+uMwfJdHDQ2KoOXvFftTsf7DbbimAwC1nxCXdKR7bew?=
 =?us-ascii?Q?AoPPOwmiMM/YXjydG46Ps6zzEQ3uExzfy+rUfqezVIbCh1RkhA/j/ZslMcOz?=
 =?us-ascii?Q?3UgROrIZWTMg7v7hMPSdBzNAkDuG37ccX2kKeEURn20tgON5vQbL74Ga9vb3?=
 =?us-ascii?Q?oBUgxK9KQqlIaKU6qQVa3JCKinR2mqz6DgYpzZqh1kjcykFJ9ujIfOpyjD6/?=
 =?us-ascii?Q?//TN0wRZifrWJgG3sBz7R8y8B8+MFDX/8bTJTeLOxKooxsegqZk4zVtagyQp?=
 =?us-ascii?Q?1XS6hCcZBdWnCMWKY9xyWODatxggkUTWFinzKIWElw+xVycxkdfBpd/3gIM/?=
 =?us-ascii?Q?d3m2SaL5dRtLXDPQtuMh6wAzYEn/31RVqF4xrh94SB2GkCYnAT6A4W1OSv9Y?=
 =?us-ascii?Q?bSztajCetTY/dawLr0D7h0MUZHPlbIt1ZWta5zzltfVW36LfouP87XENWm2c?=
 =?us-ascii?Q?g/CMlVmvxRMQmdToqcIvQK36t0cubqzlEEI70DCBFI5lQY8i0wNI1n083195?=
 =?us-ascii?Q?VBPYRsTRzhunKQ5yvdaVs/VhaMSlYyVz/SL8ByVfM/UwYfqjors3QUVonF9Y?=
 =?us-ascii?Q?kcUFv69mYS5ACqEcE4rbuFgJDKm8VQtgjxhS0NlvYdQreE3HXmS695ZUs0b9?=
 =?us-ascii?Q?L9UBG5b+A1t2uTgFTGMKXUGpj2b6fzPEJJBh4r4hH5B3kIHMDXjLnQJViWyV?=
 =?us-ascii?Q?qoNvI2BxBEJLduVrBic9EiZcvjcD/u4zXNWDYX1vhxq2ALlwf+ZIdGHH5Nvu?=
 =?us-ascii?Q?5UnVulFuzQn0r+vIP7UWu1JAabuYJIxOKydV/8o/RGdTFpNFrFrZwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaBc9U2lmG3T+AtYnH3RfqIzSifAiNKt7Pu09afrP01k/FNfbUe3cUemEyfu?=
 =?us-ascii?Q?F74XkzvgP2rGBmBYxE0XhdaaTfX1YTAGnE2vTclYCbJrpz/yujpu+w5YzARP?=
 =?us-ascii?Q?aHdmYcizD3/g8EjMWwif8YgUJgMY8mjBBRnLMFtQfjioI8r2Yu/dKVG+p5RJ?=
 =?us-ascii?Q?hwupv9R07hLzk1g87Gfn14muAeNsMJNM77INZ45eml+pYk7d/rT7wbIjcRV1?=
 =?us-ascii?Q?dsQwuKQh6pi23Ut5HWpDgpJrfybvGqu+pY89SuB+Zq+Add9pmQZhtrCZyZoU?=
 =?us-ascii?Q?uAG2xyXLCTqP5/PI3s6UF5iPO2papXlmAh+6jqzc02dqXK81oFNkwJoBQ6qg?=
 =?us-ascii?Q?HgFdBWBgorTVZgHKDWN3fGep7nNgzacjE1/IuulTZoVUomUcsKx0+/OS0QRO?=
 =?us-ascii?Q?Hz2+vScJScUpR7Bb2+G956UcB6LJ1o1brNsCbSFrDrD6wbmkZ3fUjr8CKua0?=
 =?us-ascii?Q?zLlBnxZ01woizY52eY1h42TPQ8hShSnR1ATtJSaLjrhM1zGZN8/GYCKLOO2P?=
 =?us-ascii?Q?uvRho1QSGTzxXN2aBxjxU+g+qRfTEBI1IEWHiBAZEMnoZxFDfKnKA/kcSGEN?=
 =?us-ascii?Q?PKrHM6F6iHEA/aQnKCbipg9Xlfz3K9K1ii/Q5yMu/omagNpA/n6nW6WNWtbI?=
 =?us-ascii?Q?D9J+97xekd8sykssq9shzDajtwPhLJ3rwnfZphtoTdG2Nl3ncxSFDTw1wyJd?=
 =?us-ascii?Q?1yKeqlcdHsHP5RpzLhNzWHDz08eQgX0yBssXyFex6Nx8BYa/fJKhmsijNW/L?=
 =?us-ascii?Q?2ztOPmOfvsZlRwoPJDoheWBRblXiJup8f8rAsnw5SG0Zk8SuSKs2SG9/D8Di?=
 =?us-ascii?Q?kATUBC/8nqtbpflvnr2D0NG8ctzCbK7aAkPmYQTqDjLD09u/S3xJpmCrTGQw?=
 =?us-ascii?Q?Ny6nO3r0FmHTC/Lu0eYsKt12aJmhjBV3Utwo9LoTr0qYkK2zCa6Vnr/PCIE2?=
 =?us-ascii?Q?oSwhTK4SoHJv7aqCiUtup0O9A7eBImCgVsZwz1FQ9/TWhlXoWr8CprsCjRKB?=
 =?us-ascii?Q?kCn4ZA5lj/NiTQamcDBiCWCSgmTEK0XmppPILWFKkSWQMdf6SC8efRZSYfRc?=
 =?us-ascii?Q?8d2bgfjB5x+NGvVZSFItRPAINwtJTNQJy4PlFic4YvtFKVzWeVOPhEdCXhgv?=
 =?us-ascii?Q?MQu/EvlnlwXGwI9rUeKoiown/+J/chXQxGKiZXsi3YhOgl1FCp/dhIBqOXxf?=
 =?us-ascii?Q?DM/lr9DkMtEi3Yr9BDa4IHYtYnSGuF35kOxIhQTQm7Bza9OERkiGUV2Z5Ypc?=
 =?us-ascii?Q?D16v97YpMYHEIB029F97Mpq9N7k3r3y+P5BRNDS257TxOoV+vi9D3OlKdIu6?=
 =?us-ascii?Q?CilnZQU/1QHkEWBF5k+jVzDvLFZK3+bVdGSjZY+83fSmt7YOE2hbzoyQBp1Y?=
 =?us-ascii?Q?TcPNtozC1Akp+Nq4B7LA55AZwz4IyBmxgGV3R0k7LS1/fR118kXo9En5fWNV?=
 =?us-ascii?Q?HMTx62ZD2HO8gsD7AialJ4mqy37u6H7ih8VhBem6XqD/XFLl3IyU6x7rOwYk?=
 =?us-ascii?Q?/rdGs/zUX6NeT4XHlbLHfxar7XGpB/JzeIK8aExb/KgNF3bQ2jxQoUEfIly2?=
 =?us-ascii?Q?X5kelvZBydsMRws+521X3arqoZbOQ6jA6SmsJ+zY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80b0dd9-6996-455b-cb02-08dde451e392
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:37:32.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjprYz8xOWMhuJo+2xlmkbNtpEuIHF14ZkOhNyF5FbajTrkXk1hLdQkwuo6yB9/nEobGsaLBcPwevGLPnPTiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027

From: Yang Chenzhi <yang.chenzhi@vivo.com>

Introduce a helper function hfs_off_and_len_is_valid, which combines
is_bnode_offset_valid and check_and_correct_request_len.

The motivation is that check_and_correct_request_len correcting the
length may force the caller to continue the execution, but the
corrected length might not match the buffer size, this may trigger a
out-of-bounds memory access. In addition, if the bnode is corrupted,
continuing to read data may trigger unknown bugs.

It is still unclear whether there are special cases where the
length must be corrected, so instead of replacing the existing
logic, this helper function is added.

Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfs/btree.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..fb69f66409f4 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -170,3 +170,21 @@ struct hfs_btree_header_rec {
 						   max key length. use din catalog
 						   b-tree but not in extents
 						   b-tree (hfsplus). */
+static inline
+bool hfs_off_and_len_is_valid(struct hfs_bnode *node, u16 off, u16 len)
+{
+	bool ret = true;
+	if (off > node->tree->node_size ||
+			off + len > node->tree->node_size)
+		ret = false;
+
+	if (!ret) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %u, length %u\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+	}
+
+	return ret;
+}
-- 
2.43.0


