Return-Path: <linux-fsdevel+bounces-26860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8395C303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B228284AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09F1D52D;
	Fri, 23 Aug 2024 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MgkCyABN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2063.outbound.protection.outlook.com [40.107.215.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBB111A1;
	Fri, 23 Aug 2024 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378163; cv=fail; b=fzH6X5O5f7G3KR/52kVsDTTNSzSaXTCnt3S7XBnvXrJ66griyi5jmD+GMWWmgQKwgGGBb3ftakORXdTTqP7o7GjWFSkY9lpGXCkTh2iezx/wnbdOFXgwOoDzIOzKSDtOBn1CrgngxTHHa9ToplolLHCwpNlya/7vXA/RYVvUlfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378163; c=relaxed/simple;
	bh=7Ca0EaA8b0Q5bGan3E/oNSnIRgjMYJI0VVhkjaBbA+U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Eh4RIt8BKHPryxGJRG0gnqUqWXGvHKuX2rWgTcCVGBFSxjUwzjIS8WvkDu2AqNVZjgbdGlRB8TEaKFl5zCerhxT2qOMv0b1+tjnSBvDpgtmvh3dRhVuWYOBWj6eaf5+os8VHNkRrLUj/PuW28NpTMWhe+LkCq8CWx6dOmldk6hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MgkCyABN; arc=fail smtp.client-ip=40.107.215.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSSZildPd3zVHhi7nJ7/ZIeo/sI1lp5Ph8X1JnVO7DEPy/YKOhJDg9hUkRH5hlGvTHKz0xJhKX4PpI97CZ3K1PSRagvREA7wuDRx8195FxaKquTTzloPhIbwhVD6YaVW4zhdg3DTnyB5GFKT9fx30vkOb4n3OjQ/+oW/bM12KkeEyq9/P+hwhRzznM61LiMTjwuZHLquKHvHXI7Zg/50VtJDeX6rwd6cIeRwSL5dIZ30BKyWOxwfPZR+BqN9B9M+1cP0V4dYuPiofs1MpmJXJkPwnRplndvR7O8Xenz+vJ8ZwZv8t2Mpkbx8F8BvEZM0jTFN3G+YXYn+gPK1IcKXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq4Hrwktrj1XzhBhf3Qz9g7vEtaTBziyk21TeYXygTs=;
 b=brMS9BSVurrutgN0gsq4io+tKA7Zlajhas3ZZHM2yHc0RtUtaKycWRsCpO1f/lEEx2tmY3e2CgxXdegZcEqYhxyvs/lts5iEz3IdZ8uZtjBvTWoe8uXiW2dc2/txbZ5+Hos3PUUrtoS9+6VrBkHYVxj0CvllZ4kRrFmoVfZg+XBN2qcjmhagUcEURvuqmD02WCe1/bIxgGUnxNKN037g5pMeffNLSoVkcAXeYhAKWbwf962AKWn8ZhBNIJO2S/3mP42nhCK+jkyW8mEp/eVRMxahML/tVQRfqMpc5KFxcEpuUwLROSpTJaVrhGwKKEgyio+1QGZF+IM7dbEe0Ipafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq4Hrwktrj1XzhBhf3Qz9g7vEtaTBziyk21TeYXygTs=;
 b=MgkCyABNfzWIOaeoYeNxXVKii/VdfdOYFS7SB81cNaqJd/CgwU7/tsJV+NhxvNU1VThDlA+sPIGDfTSv/3fUE1LgLoOiSh0F6EqzwQoHlNpVa3+VMvEdt9MlGxaUPYUxgN1bmYwpxTEujYNUelTNyYpR/NFqvacVmEmuh/TZIiheBKUw5UNHiQwDsWEvoj7QAqYcu4+pblBW8JloSm5WweGNTWg903UMONaulxHLyaJQtdt3NVoNZnGfBFqg5KB+wZUt0M/xE50nGfIhLBSdfKXLwzLI87gECIZ2DhsG/X12JvTPZod/NRvEd6bFqEPBmHXQ6QRb+BkG8nZ7V6d6Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEZPR06MB5764.apcprd06.prod.outlook.com (2603:1096:101:aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 01:55:56 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 01:55:56 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] mnt_idmapping: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Fri, 23 Aug 2024 09:55:41 +0800
Message-Id: <20240823015542.3006262-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:404::27)
 To TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEZPR06MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3685ddbf-7cfe-4b36-ab91-08dcc316ba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26g46b0EOe76+lMV+mXVeY2gXAnFKQgpunbjZnj7dCx6xEdHBJGNDF36nq8o?=
 =?us-ascii?Q?ndkSzZBlB74Ykf5hXuJ05dlpkRC1/9rre0OUbd7jtyUkEyMvjykI7V7WNJfS?=
 =?us-ascii?Q?CLXh1eEzwsa+kIp2Q/P1bDpdq6/PhGJE//r5r5DZbaVMBX7lRDrq7GFJexZ4?=
 =?us-ascii?Q?OFfgFw/cePdYwEThvaTZhHIDMV1iMu+t4kpm3u0EnjgDl92TT3q8LFp4U/rZ?=
 =?us-ascii?Q?yD297FJA/nijPv4G9bJD4TBcbrM+CwDJkvCmPFjwrPvBq2dDGdUea4jdu8zL?=
 =?us-ascii?Q?tXfWct73+2fU09Vi1ZeG394i3cF5FG4b5Zy9h6uZvPerBViwuMP1kXRVCe1O?=
 =?us-ascii?Q?mC40xGvhtMOauXJU50UkEKYnVvSFgyx/N8Nf8Rr8Ugtj0pqYk2Ef2fVW4Bq2?=
 =?us-ascii?Q?FbCTC8YaeW1nd0uNSB9xmEMKRtrN6TM3Q2tqmP5k3f0QaJRwLiqFw6MekiQ7?=
 =?us-ascii?Q?nTkRu6RG0EKOypvGsPz+7iRuv5DMeUHUeJC7+bBt0G1kDNvNvmlbGRe30StH?=
 =?us-ascii?Q?5ofnnyaNn9Yg+7g3ISp3+TWCn+vAgVGrJ78ab9VTIVRu55U8/OZ9W3HFgjuP?=
 =?us-ascii?Q?JYP7A+PtIAFqswJC1RzncGxyScuXonrZ7mUjjs7uPnQkN4XaMNYqI3ZUilyJ?=
 =?us-ascii?Q?fG+KpkPzolD9774nrX8pTj6gffX9XxBNre3KGFceQoZ1GBesS2KFBaBQbc3Z?=
 =?us-ascii?Q?jrj1UbtvUX4suer/inQi4qXxoi33mNm/Ii8cQtxHoM/AGKACzh8KBPBNV97F?=
 =?us-ascii?Q?F+SCzW1edkjuwAC7PDPI+KeUHn7+GyS9xSfqlghkV7GMBqskB6p12F26yNK7?=
 =?us-ascii?Q?ESS1JRCJDy3Mc6e9tBdygUwxRJAm8olFTOw7Dhvv/89WQgb3T+7/t8t5rVOr?=
 =?us-ascii?Q?cFfOb/maVUVERE8woS61+tVFdi771PMIC3gb/vg/d7cHKa0JDNRmTvyK2YTM?=
 =?us-ascii?Q?RQz02fTOiGV3gpgfCHlRSx8IBcnvYIU5OioUU69k92fOCtFEd34OrTZrebKY?=
 =?us-ascii?Q?kziciLKhV0VM6v/gVglyfLWTWyBbZRkXWbX1V8wkdbZyUy/GGkSs+DgxWQMr?=
 =?us-ascii?Q?c9eZCBAMvX2jXqh1AjfSvikdo0fL+21hB/TFmX3FdhAyRgbZ6uWWUr8N//T7?=
 =?us-ascii?Q?wcxVDMPFJeRkB8XuwxArVdceTxNMTzqOXV7kUKN5CK8JsLFN5Ro63rnZ20XZ?=
 =?us-ascii?Q?+BJ3ZLJw9Iiqwp8cu/oO0dVO8EbOy866A+/87fGRUoL+lTPUkBxVIGk2FioU?=
 =?us-ascii?Q?rnIR4cuZfoC+ohXCXwKGQWxMD6hoRHZuFItNm2W9+RQqyFkZgssda7byPZrh?=
 =?us-ascii?Q?y2a3R5I+9ysLEf9WbI1hmUGpfAHmzuloZE+L2gz8qbxwYK/lE7nNE4STDe7v?=
 =?us-ascii?Q?WQQU4cRW227nZm9uqGmKGHsKHMbq3Dq1cZmThnDUMgbOciaM+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5DrUa1yVsggKETMUJSPVk3TNL91XP+mYH/5diXwuL+sMG0UjHOy2BZUNjNm?=
 =?us-ascii?Q?WFsReORXpPYQ20OlPe7CjGUJPGgxNonyz1UOuI9zcstESeOiHpF69Vo6ZStb?=
 =?us-ascii?Q?Ko5OKSCZAPlwTcNoPfQ1Zj3GhvAgK99AFD2/jEij8BiFCcMxiO+OVZvuEs0Z?=
 =?us-ascii?Q?U8OJHfkzxdHfFbaB1N9fKYEWBlaKY/qIQiaam4h/EocuQBQi98qZEbAUcxJ+?=
 =?us-ascii?Q?+U72QiiiscnMB44ERSRsa/5ryt2426J9C4qcH9hm2xmvcVtzUssFRM7GEeIl?=
 =?us-ascii?Q?1QU5JR4/r73lngUx76wP9uteMgV/8CsWeMRFgq0RMt6nXqxYqRULJfW06mSV?=
 =?us-ascii?Q?UhnhXbCJqJRhdhSsLy+2LgyyIGiimrzt+tDEtnnQIEi9kFmg20ddLltnzjyt?=
 =?us-ascii?Q?zQMGx5mw5z9OY2sz8W7K3klfuO+BrsQVWGavvKFdrjVMNu7eioHqEGgCQZ7d?=
 =?us-ascii?Q?riWLZxEVykKhTTLQuzbJ3r2ImNZss2S+gRoUttOXkQQjP82QcT4/QwF64oQf?=
 =?us-ascii?Q?usn/h7SQIR7tS9brzlGj1knqhseJu1+IRZADv4LEFdjL7TRrzBi6pbyvfLdV?=
 =?us-ascii?Q?AhiWOelv65CAYO6mjBD9rALQOqdYnr08SxRGuyarODuB9gD4GgTw2KGt3czU?=
 =?us-ascii?Q?lPA8nSbXVGkBU15JdVai0oTKWS+UiSWQXisuc4jxqWc+AnrKyI3JGFbjh7El?=
 =?us-ascii?Q?N/e5HM8a4JogUVczCKWf0NJVvnylqgBulVVlMNO9+6Gv306qNoJZzg+qyATo?=
 =?us-ascii?Q?yejyiavNuLtCJ3k0McOOL0HxVCaPHwNtAzeO4rZtu5AgzY+WPE10fQ+K8Me1?=
 =?us-ascii?Q?WvJ1ZDpw5LX345WhohPKo1esRyW+amoWcGIJlvLDNtvIlmRFoLu98PtRseVi?=
 =?us-ascii?Q?EeuML72dP/Oe0pAybYE/owe07Ea6C5sduy6utWewyKQ0L0IKEdS5rb7zDNXk?=
 =?us-ascii?Q?FplFmY9r8IZu6cqzZXGHDv3p3aKVy2d08jwMJkLl+2/Hx3MAl4p/dOJ/ID4O?=
 =?us-ascii?Q?gvA3qVWhxUhnMPTT6SZUwoX13K3i4/tV8PZNcgaznoucF4hY5xbrTi7Etm+p?=
 =?us-ascii?Q?CsG8nSvLzOaDPQceiQzrMtnf1RkRFI8eEUnWvcMDgH0c+LjkWgnvg5oLyd35?=
 =?us-ascii?Q?WFPA3GJwzbu3pSpmMLcgKMCD/IjDjLXawSolTM5BHCHi2CvkZ31xOj+Xma0U?=
 =?us-ascii?Q?U0NJgWi4ue1zdmnW9nw/3h33QPmc8Fj2OWW9AHHF1xOUzoJKTUkhsv7FGC/l?=
 =?us-ascii?Q?4tsvqlIqrGEXlQ4PKMB53eKz+CV20j8ajJ1PWgVDvdI/g88GAWpdWcpU7Eup?=
 =?us-ascii?Q?jXpxIX89WCMmre/kfXbDCTXlF3x9mAVXMmi8fXgyW8UpteONpiXXuswsTmL/?=
 =?us-ascii?Q?18H5cFloFAyhVUo/zF29ApuwjMIqrphrkqYCXbWO6ApsI6ij6OI1/2+7JtX/?=
 =?us-ascii?Q?p9ICVY+iEib7OcM68A86gbIUD2dojUNcGHKCAxIICJkdy3KtIQb1hIFhqNMd?=
 =?us-ascii?Q?mwEuqogfTtfeM6cw0a/w/R7f0UUqgwXcmP98Fbf/TjuW0Ikr8Zy0vSJwQAGZ?=
 =?us-ascii?Q?n2ihzmMeuOwF47XW4KHfx2/WhGVsmJT1jG2BswPy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3685ddbf-7cfe-4b36-ab91-08dcc316ba7e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 01:55:56.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9S+FQYU695xlFfzVR9eKS3A0QTkcBgr8F1VnhlX7rQ9IEfAVmQhv8CdCLsMFlmpqaBpnozLOvD3LRaMHTpW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5764

Let the kememdup_array() take care about multiplication and possible
overflows.

v2:Add a new modification for reverse array.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 fs/mnt_idmapping.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 3c60f1eaca61..79491663dbc0 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -228,15 +228,15 @@ static int copy_mnt_idmap(struct uid_gid_map *map_from,
 		return 0;
 	}
 
-	forward = kmemdup(map_from->forward,
-			  nr_extents * sizeof(struct uid_gid_extent),
-			  GFP_KERNEL_ACCOUNT);
+	forward = kmemdup_array(map_from->forward, nr_extents,
+				sizeof(struct uid_gid_extent),
+				GFP_KERNEL_ACCOUNT);
 	if (!forward)
 		return -ENOMEM;
 
-	reverse = kmemdup(map_from->reverse,
-			  nr_extents * sizeof(struct uid_gid_extent),
-			  GFP_KERNEL_ACCOUNT);
+	reverse = kmemdup_array(map_from->reverse, nr_extents,
+				sizeof(struct uid_gid_extent),
+				GFP_KERNEL_ACCOUNT);
 	if (!reverse) {
 		kfree(forward);
 		return -ENOMEM;
-- 
2.34.1


