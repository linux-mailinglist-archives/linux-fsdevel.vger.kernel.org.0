Return-Path: <linux-fsdevel+bounces-58132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F4B29DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD53A5886
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676330E0C1;
	Mon, 18 Aug 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NFG2P6UD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CF30E0C5;
	Mon, 18 Aug 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509310; cv=fail; b=eYB/4stCxOGmJHhaegFG8eCnku1Md5RQN8pLU004qqiGQDWbkrqUoirbRGm4rPU/DRNXxfYZhxb9QN81GK45WKeBr/rGARgNrSerAiOQFzTO4ZrqRXdoXqVj/tU4R/Hm68gYOQ5FZw1LkEpbYE0+bEyowAdxwwgLEUaqnDv4NQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509310; c=relaxed/simple;
	bh=epxknCKVCsCOiC4ElJpNLAJLkIVCIuHGwLquwICDJ14=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JsCRATB9maleZf6ijVsSF09dsma74O2Xic2Jg7Y8Bw2PeT2y3I+Sh2BFB2Q2k+YZO7DLapnH3m8wqTw0tGJaoX5Fu02tAktmC5UdgNZKJ8Bgd3A7HyVNC4qlq6TOMgaL+6MHVl+K/SiwICn4yNqVeYq0Fx/n2X1t+vU1A+tue+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NFG2P6UD; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrlpRNtqDjxMcBU7ZNJMYl4KJaaWjHhtM4hetIuEF/Lfe271p7WSdI5fyxDCl9X4VcJg8peT1NpfV8uNS5DrZC48X57rM3+eaYpEnb2M/KqEOyv4KNND7TVBsS4ipriq3O56N0LFXloS1QpBJcCcdjBNqj4SVmEPicC85hea06oFJ3n4W44ulUXEwTJeXjuZU+FIpY6UW7bee4yY1Tc+PLKQuvUKNVpooPZnE100IPCnE1DD+8IogVrkgCgUKC8pHqznIfcZ7VxIKH8eUHWVZ0VTj33Or2h1HRA/TPhqAknfqk/kblef47Tva9+RPUJMmGMmy1dPNtm4UtC7IRFL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EoCy6iIhWnu+rSIy4wQsuCc732VEUTQV9EeqaD9KsM=;
 b=F3FFMB0zc9fTJJdzumoBrb5/uCr6w+rtBoHRJrEyYe8ed04LLeKbuYg7wdD9lj6SIZnE/E93wyEMNG3yCZB5L0wlHqzXZbFrKd20xEEoVTPTXyJDvJEvpbJQkPYRx58q22wjhPOoAxtGMllV6m3fSEvv+jYqhJoabN3PIhu1kKz2s0x0pNCA7OhHTLUdkGm8ntv3b9zjxLayKhwfHuqkGvxYobTEMKTQTdV+lB9JwDd4I9wh54wzKwWN/R0knayaDRAPRmq6hxzH7JG803VPu7FQpTYt8tl1K2hw4yPLiQanusrPY9KSxPDfdwWpSExb69HPDY+resD+LTM6iBPQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EoCy6iIhWnu+rSIy4wQsuCc732VEUTQV9EeqaD9KsM=;
 b=NFG2P6UDa3c4CfqSgqqIQMCNM97khH28puwkDhnRuryp09U/bTYTSJfo7xY1TddgYO51P+rEs0QMViKN+mg35rz2cRmw30eF6U/Eo2/5+RSh/1fQkbZsmWdK2aGpbDEnMKdGkZRzDiFaK9BGCoq6Jl7JSGOXt8Sra/weVVl5XdVJKzFYR4tuU8/bOgQdm+sFQ5IEa8LHy018NpNIWobV7hR0l9boNWdQ7SLzAicF+nCIg7fXfjciOaVqcov4HhDPDtnMS2tYvIxqIQUStbMzHMVIGUDZPTCRzfjp0LNb8s2GVTK0sfpQu9O5TytTGZNgadM/vxx6OSfpln8bksgMnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYSPR06MB7258.apcprd06.prod.outlook.com (2603:1096:405:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 09:28:24 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 09:28:24 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] exfat: drop redundant conversion to bool
Date: Mon, 18 Aug 2025 17:28:15 +0800
Message-Id: <20250818092815.556750-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYSPR06MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 864b32fc-a0e3-4a8d-1b16-08ddde39945e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZdPLDQSGsD6rhjC7N9xvXoRx8JY9hYfl7P6Vy9TwZW+uepu4aS5NNYpc1E4?=
 =?us-ascii?Q?h9oQtw7zcxrVAHmgr1NK9TO2IivP4B3pm5ea/VZ7RLzxukXDvTdVOWBpeK4Z?=
 =?us-ascii?Q?mJdcmYLX9Na5CcYjlYLuuaQXuzMwYZMyC5WkIvV0yrmDqiL6+LoMQtDcCwyY?=
 =?us-ascii?Q?buxY3JMpuD5T7ZmPJTRFopt8xutsJXruV58Qgc/fb5b5uuCiUHAoh6BZL2Km?=
 =?us-ascii?Q?fPtDymVOdGqAbZEaJatTmVanXy3jvCkcdmgkdIDXbXhI9Vi0ekYsWfTOf5Ot?=
 =?us-ascii?Q?N9uUyLANBQCWk3x0scckDhQaf+t3F1tvar8BSU+95Rtyecaf0qcNknucLnNL?=
 =?us-ascii?Q?20xoshz9Xdfa9xor137e/39+y03glsZTGncQRE0kyIPZdqIVDHulGjxLFmwQ?=
 =?us-ascii?Q?UyQelVV+625k0oDJwm/IdQatlfBzMbjw5Ky6pQRpiG1N68NYKlKgJ16T4B07?=
 =?us-ascii?Q?aXSyNGrk4V4Iuyokn8ggrE8fOPT+VGF6qOsgF8Y0ePBiu4xQaJpv5DkS8lGO?=
 =?us-ascii?Q?XMSsZVn0FxtYcJqzhz/nHbphbE9rocm2Tw4/iUvm5MvpXSD5LNwMLNmep+R1?=
 =?us-ascii?Q?89f2vP3p6P7NyBNvkJ1++oa19YBeB/klgmwvlQ5ksnCEzlOJ5WBG0Z0R+T+i?=
 =?us-ascii?Q?XloydL1RMo1GAWvSEk46rgXS7ffHr1gKjEpuluHvrvD84pMviEC5Dk53b5FW?=
 =?us-ascii?Q?94tm/fPf2tzI+m1XDzwbQ8a9zE5P5s/nhXG6afEs1AJh14EAkFf06AQwmOu9?=
 =?us-ascii?Q?EsuqCnUtUhKQhBlv0t2P9XLqIg6INxXufNQ9y/glY8JPLRvlZiys8Fmb7qLy?=
 =?us-ascii?Q?J/4taY4brWqH5fEKg3yY0K2z28o6NbatZu+DJ7wdBt+4lxwdWGsJwbPWDLnP?=
 =?us-ascii?Q?5nosujiRrWwVvJRwS8eGUohdjOid8T/1xl4RIMUs72xwhQjNJudy+m0i3Obf?=
 =?us-ascii?Q?HjNLyD76Kajy/yrHV0//w1Zj974iCcmtWPX0Nnz5kNlgoXRDBhoyUDWQrDNg?=
 =?us-ascii?Q?RdMmjUDJvghsJf++9Y5nBLlPOIVX1IxiApbNoaC/gUHvWN7plXPWckMZP0pb?=
 =?us-ascii?Q?ICrOn4COy486+6VGFTbZDClPNW7NyjmPXjilDdC9bcvCjcWOA8XRjgApCZCl?=
 =?us-ascii?Q?dhiYspT9fcbSzDrtzeQc5K8M3vEpnRvN6T1JFgGgF5Nb55DmJomvijjIVYpW?=
 =?us-ascii?Q?/Att0EbdbplF+EC9qlBRM/4aKgWHFxJcVe2SXfMjCxIId/WIBwLSP0YSNG2t?=
 =?us-ascii?Q?utaYsKHQV4nVOcSnb580uISVDauvbIKXFyw6Bc//m1zB+lTwgg4lxxpTl8uw?=
 =?us-ascii?Q?uw3Ehwwd+w+FvpcFotFu8lvG+FSEKh9+ZoEN0fqyzdU9SaFovH+UlgLIWruZ?=
 =?us-ascii?Q?59t7jq1qbDz3EgCSJJB6kwaSFv8dVUZGNSDnx6igp6GX1XmAaBUd2qsvG84l?=
 =?us-ascii?Q?+4itRb9asPwhRfby9MDA8DmJnjEs6MLEnQWHcQM/8A4qTgxnX6GLIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGA3RG2/JU5tP30PR6ng6qTNROKXSL8WYVhyqQOZfGIIh2BDHs7C3YOG/QRX?=
 =?us-ascii?Q?WwDJl47Tn0RcwHHSWBZqMC3wbVcsv1FG9pabeYHyrc4KSkMts6i/6GqtV9gm?=
 =?us-ascii?Q?ae3tfiGZSNP7lznVLbKFXnNGFAGyKXQ8g7RjJmytvO1nTDBz9OACph0D+LxS?=
 =?us-ascii?Q?DZIYHiXGbHhT4HQfUAPR652x7eqn3eSLXeWKvuzhFG2ApphzgpUOtil8Ak5K?=
 =?us-ascii?Q?O7H4N7D6ydziz26PleB49mfr47ogAbZmsJcXShY9j5tyc9fk+K2cC+/ZINdG?=
 =?us-ascii?Q?pQRFtI7MXEzoSUMvDzFckvrWBbvvd6r2UApvx/r+JLsKuKZo7TJWU81p9urD?=
 =?us-ascii?Q?P59MPCP3j6AqQ9sfAjY0eeQmRXuTtQKSifN9r5tH3OGwha2IPGert6Gce3YF?=
 =?us-ascii?Q?uOp7X3xXtaTj2LL7qLs9ihtbFFzD3H6gikZ12Q4PLGxne39RgU65G7zmKd5D?=
 =?us-ascii?Q?GRGnmFHiiGyOeYe2yQdAllDrZJ35119W4YAeALCwneSPsm1uNfTBHUic7D22?=
 =?us-ascii?Q?kZNMw2ppGqL5+nKu9pyw2FbgpqfO4yyw42FgZdoTgiAUUaXxx1eOXYdekY0c?=
 =?us-ascii?Q?/3TTu5cIkGFH+LdfNOIIo/H40ABBR6Ep/SqzRCTi/Hz5K8isWxHXaF2DpHqJ?=
 =?us-ascii?Q?eDMUVScUrs/MR7u3DOa07Bojv6936t3JWJOaiJyfzCH2fk6EgF4RT/cV5i7v?=
 =?us-ascii?Q?TGSrtHavLkZ8QoeP79qQ1uuoZabhESSYVFCi8feZocdKmqX6duKSTCFM4phM?=
 =?us-ascii?Q?lm69W0hEMEOqybIXtd+W24JoQApedjIjgisn8bB2oVr8OZb/ch/+R9jzhkHY?=
 =?us-ascii?Q?feYmvPY9AUHU1wQiEL9eMVNITXLtdo3SS4zrg2IQjRiR2GWwzaXqDSUiaSzc?=
 =?us-ascii?Q?c4bWQFbzED45JqnogtFq1JMkvGEv4IIYjln/3t1dX7ZnyIplmX+9lLASPUEU?=
 =?us-ascii?Q?KC3g3gZg37XakPW3OL4i5Z73cYl1VUl/XXvQC9taiA9clRXY2ydJhxwR4EbE?=
 =?us-ascii?Q?KAdCk6VUSGeu6KNUhklhL/VMeUqENK5fxSN0z+MDSQ800aUaRljoNrdzzl65?=
 =?us-ascii?Q?0/cuTw1oIV+zJu+6TjPopUS1axy6giwBndo0GzzesWkBoKpAVWZK88E/ymT0?=
 =?us-ascii?Q?eRFhQTbcccPS6l8zRnubhdkiOq5nTxn5bxdcv1E4ndC218afJoZ3jadRpc7P?=
 =?us-ascii?Q?qtqyfmeUfSr2eHkSwEfDQYjgcUdRuQc9Hrv804y3vq8VunnJsp3aKSgo2n1+?=
 =?us-ascii?Q?pFFhwvUkD64Fsvy3PJVOBNVossT/5vLOVy8FZs4QEdCgDIYp8f9eWdpMIJ25?=
 =?us-ascii?Q?aM5JDqBUos/E11HANwz+rCY6rDWk8f8poxNWiFrLXtJdTGnxU5cgWNLwPCVv?=
 =?us-ascii?Q?Wea/pNBH468rV0I3j5CeZsvFtixzhsWNfcQFg4dQI6p138ThDN6pmmUQqSYb?=
 =?us-ascii?Q?P12lOJKDqxxJCTuD7aQOvPIK2E1CCruGk5MAZ4tksSXtmiHe965obZ5VSBwR?=
 =?us-ascii?Q?LwhbTVuWRrlcAJT9/s8Uze7iEv/x345qllZlcbD1mHE54JjQ8WNLpjOLkCtQ?=
 =?us-ascii?Q?NGJGq55KY5CNWzMZ3xdvWdsKgXS8bEuPzRsFBhVQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864b32fc-a0e3-4a8d-1b16-08ddde39945e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:28:24.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Bf02wkVqN7l29YWZ1EvQrew/X5BDoHrAlCVxvYtUsbgfCMgBCjWV5qzAMl7zf46lK8qhv7QxhhCo2UZQ2ZEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7258

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

No functional impact.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/exfat/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index c10844e1e16c..f9501c3a3666 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -25,7 +25,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	bool is_dir = (ei->type == TYPE_DIR) ? true : false;
+	bool is_dir = (ei->type == TYPE_DIR);
 	struct timespec64 ts;
 
 	if (inode->i_ino == EXFAT_ROOT_INO)
-- 
2.34.1


