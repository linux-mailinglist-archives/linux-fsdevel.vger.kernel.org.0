Return-Path: <linux-fsdevel+bounces-59615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C1B3B36F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25B8189DCE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD019248873;
	Fri, 29 Aug 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="O8XfvXE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012008.outbound.protection.outlook.com [40.107.75.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875852309B9;
	Fri, 29 Aug 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449066; cv=fail; b=WkT6Z9Ue8WvB+ZnDvczMOgCwMV5nUn0BAlatjMbyHY7kN7nX41nOGF6wR0wXAHYfg9hm9nhH7wMqj8N/IBIEMB1/tj0M3rIWCMj9tdPAhAOxV+zJKmzSp43nG3t8BLk3oTbRpQNZlCQ76OGxJHyi0UiVPMM+4jBXXsU6wAIM0VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449066; c=relaxed/simple;
	bh=Thu8b4g5GppvBDUzUB5tfVnDLhqAp95JVnrCtcnLAvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpZR54iWNrV2yf91xIkH2PlHfbxGsXlq1Hy46T6AObABkcJyRqll4eKr417GiZaCNndHyomDlnfHoOGOzv5FoA39eWw/puK8MfH4eynEuouL07wVAKOUa5RloB66F3d8opJUvcARwAeytgD600Wq2e8LY3+JZltkHu9ioss/q3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=O8XfvXE6; arc=fail smtp.client-ip=40.107.75.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANpsf+UwJ5teET3/tlCi+2k+sW6sTmwVjQ+sgY5yvNW/xqqLQ1PzrnNQS5i7ETiGkToxul5qrGzE7z45fZMGNcmHTPwrFygy9S5Rah6MfWj1upFow9mH5ibT1ed2CY8tgxYnjcOx4e2oV/kmQ9Q4/Wa5iXS7kWRD6pPQ4fz4yR9B9jfBEGqo45L3LVVOHuMl2yWd02sBOs8SR6wpaLuxXaBiE3PolWqgG0etrnw8rSUceC5j5MeFUuTug/TWS9SkgQ3vt1AQSamvEMnicr5aKhPlKgJz+kxOMTIxIwVt3DSlH/u8qKjE6XjQARxhl2aRcVyM+Qu6V8S5vTwsLQ2iZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RUCPvCf09IPDQQqWWIm5R4zfjfv/7NOrP1YkmczTKY=;
 b=NmBZi9nHn9GG4jJADe02Qc2n4nTQaUO/TS+/rpr1ZYy0W9+m7UcbuDBRd4bCB0JpdVu7LQV5QMR6eOBV9Pd5v/Si4pbDRfwvctu3xMaeMiyBO5ZZuuGFJKsuRvzSf56AknRHhOoetu3IaBIewowhs/+hwmlvSp6/SgYuGCNYHnD4lN2vVWAoTYu045c6pcmhSQkiRmxhienLAQfxFABYaEU/ZXBh90+WtriYQ9/86ZsMYZ9FWcJb6ZxIMrj7ilLGRU4osOYnQRU8v+TXiT4MtbLqgmPjtQrZDdTn9T/tSdCYgX7zmu92x2fgVxwSu6UYewZaAYzH/tDhgzP37KuSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RUCPvCf09IPDQQqWWIm5R4zfjfv/7NOrP1YkmczTKY=;
 b=O8XfvXE6Pq4sJFSZ6nJT/8+BL1z/D2gxJHaP73Fc9BDRuv0izLU9loEbXbLSgCLT04CrZDw27n/F8d4YM7Sor3l2EvpcIGT8MWSmv79fjQVnSFquRHLhB+b1+S+fFGSqh8qJgql2TAAkDax5WQ+lIZjGPpaRJQHNGmyUuR0gdf9zZbeVharcOGY8C0jPShxx6OSmNt3kMS2ZThPbguJeGld7Z/Pl4yzZSN/Uy/eQpMjdfMRWqofhdIDib/cRLTSWdHFocp+3q+5edhZC+DJ22/u7yat23sc+7MvYipHx00wPMnh4XsvW1xCgA/x+iDMpzfK0uASglF6GY4jT6CP+nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PPF56C578557.apcprd06.prod.outlook.com (2603:1096:308::24f)
 by TY2PPF4597475D5.apcprd06.prod.outlook.com (2603:1096:408::78b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Fri, 29 Aug
 2025 06:31:00 +0000
Received: from PS1PPF56C578557.apcprd06.prod.outlook.com
 ([fe80::3f4b:934a:19d4:9d23]) by PS1PPF56C578557.apcprd06.prod.outlook.com
 ([fe80::3f4b:934a:19d4:9d23%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 06:31:00 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: syztest
Date: Fri, 29 Aug 2025 14:30:46 +0800
Message-Id: <20250829063046.514229-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000efee7905fe4c9a46@google.com>
References: <000000000000efee7905fe4c9a46@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:405::28)
 To PS1PPF56C578557.apcprd06.prod.outlook.com (2603:1096:308::24f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF56C578557:EE_|TY2PPF4597475D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e3d623-7ffa-4a0b-f53f-08dde6c59dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejdDQYIq2dfZZuD65aYNwEVUpe7F0gi/kvcYKKaMPOT2qchmQfLC/16wjC3r?=
 =?us-ascii?Q?aBHQj9nYhIUzlnRwk+AkxL0b2JPX/Xdcuu8bjG/pO75Z2BFAIR2XkLITv6Yv?=
 =?us-ascii?Q?MeA1f1mo2BKrqa1RbGYPqTUvDt5OXrw5l0Ky+St+8FgqR7xBD+19SGZk7qFk?=
 =?us-ascii?Q?Z0xwnT1e4+TT5oKtUkC0xPpQR3xywk0m+7wH2GsXy00jDLFsIfhbAkPJvpzM?=
 =?us-ascii?Q?LkC6d7tFJu2yniqaPByqa0YouvP7x3t88FG2hO9Hybp+Hw3RCeqvp4ycTihm?=
 =?us-ascii?Q?UjVHY2ENXHTXkvFlKbQB6IDvXhyBnWwdtLpxsVXlUP5IoO/YX37RlA+C/CxY?=
 =?us-ascii?Q?kamGmbvF9LASNFayk4Tfs9iwCkzFMNnQWxbodVnv1fxVMUlve4QfQIG5DVJ+?=
 =?us-ascii?Q?vw384gJp7Okpj+v3L4+SIonXrzbMoQagWNrb+X3GBN7GIovsyiBeqrZQTvqG?=
 =?us-ascii?Q?gJ0ba3VjtH0hX7ZBfuzWvotU3ighZPno36mTOwPbhW3P51LUiLn/LlXSCg09?=
 =?us-ascii?Q?MsMofyhNiWbvJzWaMfl6xkRef4WHgqREtlQTUtWj6jdBGgZ70p7M+VCVTOSj?=
 =?us-ascii?Q?AxKHr4+lukeMe7IncTQlkcMjYOaK1cY6thKmIodOts30X0+YTIJPP0dMIgCH?=
 =?us-ascii?Q?cTeTwiAmdnDfVQcj6FMQ1Jy71V+ziJpoP5/5WIcSWPj06qbbgC02ECDitVXK?=
 =?us-ascii?Q?ge30y3k14tX2x4t/nmwvXeP89m2rPAxJ3d8G9pUPJzy2soXFQJ8esbXaE23w?=
 =?us-ascii?Q?bPU2QuhsbpJnERg2UcS4bndiEY/B70r2zU9tce/5rKQyojGussTFUGVevHmX?=
 =?us-ascii?Q?DFO1M57RgrOVnwYr1qvZV9HlzjWEWnzSWoyW2ToG/C4FBmwTXSLYOduE4SHU?=
 =?us-ascii?Q?y5kL0zP5JEK6WyOx64d/6RSWKhOm+XPodnvmMceMU4qkpisGvSjufXkngoz9?=
 =?us-ascii?Q?Hmjb/GEJXZAAQC7DBMtjCfdOsPEUfuQh0OK81gNfKLP9jW93jUdzV681N1lM?=
 =?us-ascii?Q?xnE/FBkk2JmH/DKLLeopJj6C9WapMyAv/WyDR/upO57sDOTuVDtil/Y7QtJv?=
 =?us-ascii?Q?2fbdOaUUYVw4NULMwP5pNNct2CQoVLURtY8XP46C9nkIixJ8tMo+40A3eNxX?=
 =?us-ascii?Q?kPpZenRaOW2O3kvmiidkcUPNJSvqxbYYsH2GHS+DVbxpccwbpGvZ2ihxdNRM?=
 =?us-ascii?Q?bgwqmuHAk43jiUPYCF/kB/1I8TBrMX5iClndCgLFYFkLrFxZbCdjAx6fYChu?=
 =?us-ascii?Q?mnNxL2ZEpvkAk9+fbAmu5NuhaeeoDj1DGnto1FX3BJEu5Mgz+zV4n3KNasBt?=
 =?us-ascii?Q?zzllp5V/T4cpNACu21qreyTsUTI0PO5A7TDi8tK7bw82LLp2VZZaKhC48A+v?=
 =?us-ascii?Q?27QfRIn2yY8Si7GwqfmrAo2N1BJHccX/NwlQuoguop6aU4MUZ4sFeqrUlVM4?=
 =?us-ascii?Q?KednjQa6kcz5aw2S9tq1OJOR+60QR51pUeRW6nNkCFKmnFcQlMUgdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF56C578557.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X9yuyc8ivthAUq4a2cKKzEzXJk5teJB3jETfE4X8u9C0UmHRd+YGUd9frP5q?=
 =?us-ascii?Q?5KX8yCI5JJ35CTZP6MIa6EcBinJMrbf/WKmn2uFoRHjYYTgKWAYIUILDsV6J?=
 =?us-ascii?Q?mwHzWW3etbeblZ9HBnTFK8RIMOl/iOM/dT58uZp8WPwHAGJotgUcI1/m2yUY?=
 =?us-ascii?Q?+mTi77s8zFVlacFaF872X6Sbiz8JYVQXT2ePSrPkJTT0wZkE+/YfDf7W1PEC?=
 =?us-ascii?Q?buMZHdzHBA4PLTQ14xzWhs2ATZ4HHSdVy1/i4pL5vZSUhKPFzBw6oyb2GweG?=
 =?us-ascii?Q?FtSULTwLC0lS1hBXC969I60bM+Sh11usmf1ffEgvWKLTHWHuFyXAR433ykj7?=
 =?us-ascii?Q?CInHn9g4WR8TwF4/qJ+5xwSaIwKSkwz0AFaOJLfl6n/oUTju87XwbLNt/hDS?=
 =?us-ascii?Q?ddUYejrq2O30bAx4QrXvulZrTow6HGYfwXjt5DNYB/qGpARhm+Wm7s3nbO9P?=
 =?us-ascii?Q?CNb/ARlZ6uTTFjA9zdbXaXnpkFGpayJ1WFAMSOoWzPfXgfZLkT52J7pot/g2?=
 =?us-ascii?Q?bkEcLdmRDuNY3x229OM35N/D4G1B2TRRd7sHI7MDw50e9ksVBuX3J0Egzok9?=
 =?us-ascii?Q?HqTSO+vl6oyKy3uV43n3IWOdJZ/vTFLrPXfwNbHVQQkB7OIm0Vd9jffJ2MjN?=
 =?us-ascii?Q?990at8+MHsIjczCBO3RY/8WGsXVm66zwp8kE/6h4YSEP7ti2IpNi4ZfN/dwA?=
 =?us-ascii?Q?kS9OxFnEB+KVWmoF3/jp8LGdxq8EEbFKlqFSSf/F45kOqfv2PfZTvcurlNCC?=
 =?us-ascii?Q?oPrfGewijAb7rZvOlIznXMK9TkeChLjJHVlFBM8VNLHka4U08mCTTX7defeR?=
 =?us-ascii?Q?5LY8mLJbkMPHSEDtptBwQOS00Xupp60rNUBRctOHuf2K/xUPHDaRZodve3Ds?=
 =?us-ascii?Q?Bb0Z7001+jQFc4tJMrZDNGtnHfv0pCgvQsEboG/sQtaPfPO45caDi/5Beqgv?=
 =?us-ascii?Q?orq4NSY1ABk0M1LZdSV1FMoMvttBNMKzQoAy9YQ0vnJ4O9pBQq/LkHB+sO0n?=
 =?us-ascii?Q?ggfvW91D506GC7T3TazrsQwmtQ1Sa3T4arD4mneaICwQUOaMXJhstvkhNFNw?=
 =?us-ascii?Q?c3UR6wldPjPptorN4DsLhWgQ43yV7fDcSA3PDablnYVXMAW7hFjME7xU5JO8?=
 =?us-ascii?Q?qrSc1pZKhrXrjnm5kEL1lDFwa8Yg/NnSNXFs/AebBB4grKpgG8qAxi9mpqbQ?=
 =?us-ascii?Q?ZF7KaxcL40sVs5hGY73WOITZxWynRFNnB0L5sQQTDYBE6F0LEgjxYXGuJQ+o?=
 =?us-ascii?Q?H5rVwDuovLglYJwgLwt16t7Sk5DXo/UuLwpvnb/uikLjH9q8RPricFNbJT5k?=
 =?us-ascii?Q?UCoyLaC0dS+pquujwkuYpP7Uj4EUfRmoCSsmfc4laBiOeLa1RXySBpFuuNBr?=
 =?us-ascii?Q?XxrvPDkqssYPSFBULMwugUrWh0dRZKv/Zvhxg29j/h9KgG/+7itOkM71mhcw?=
 =?us-ascii?Q?LDXoyqBodVJgHTd2tsvrYA5yFG6WYX5kMz6VQs0ygkThPZ4ZKaQP+UJ8VOOk?=
 =?us-ascii?Q?OVpfgsLtpKVssZJFs14E3db5xkIm82PnY/jUIONiUTPcNabrHms9+hcSD9UR?=
 =?us-ascii?Q?1dQjRc7IuIbBk80XPP8i17+1l23PVJxiFsG4WNoy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e3d623-7ffa-4a0b-f53f-08dde6c59dfe
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF56C578557.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:30:59.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuTAWV8+Q8cKhiw+ML/pk1PO96ffgwhP29rjjk2myggkUfCtRZ6KlYy0VmyRCE9rI7xA3o9jpvc9GZBgwpK8cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4597475D5

From: Yang Chenzhi <yang.chenzhi@vivo.com>

#syz test

--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -522,6 +522,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		tree->node_hash[hash] = node;
 		tree->node_hash_cnt++;
 	} else {
+		hfs_bnode_get(node2);
 		spin_unlock(&tree->hash_lock);
 		kfree(node);
 		wait_event(node2->lock_wq,
-- 
2.43.0


