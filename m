Return-Path: <linux-fsdevel+bounces-57046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382AB1E494
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3053218A43E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F124264F9F;
	Fri,  8 Aug 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p/5Rhmcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285601990C7;
	Fri,  8 Aug 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642548; cv=fail; b=ieSCOlmu9SqUlIqXkaaQcs7uvcSrUVnw9CxFWiYR7IhWmh6yPa9+QteFer+M2/ha7aUDLsimjY7U04Nk64yWB+BptAALtByrrcMBYxDkcIa6ao1j4iu3x+tj9Qm12npXvIY3e8VjZ2ybjtC8TiBXN4JkBYd0c+geNeRZEiWKqfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642548; c=relaxed/simple;
	bh=Q1xDVcw2WeY3qudsEDcQDGI5tFxpdAtQWW/9ZAL15Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gT7bUTTIGlk5EWK53NlA1kSBF94T2TN+S2l1BQ0nsWoG2zp9rHF3oOrOgIp0WHE4yuYb8oT8iqCrBpYgJXiOMbzCbPtTuT9spnzCXxWByDD8+iMiQvmFFAt3nDZlNi2XCfrmcrx09xMHSMXTxLzAMX5TkKxAOj6A+8eXGkL3FWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p/5Rhmcp; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKsDUCsqpCjS+jtQ9Kp6MO4GhLHug4E9cqQGr9TmKtBvM57hrkCPcKRL8QDKUf/MFR7C2N23XyaT0nh84XOLT0PpVDGKxkhxrLZ/tTgHlDRYopROxIKlSlszFC3uD0hRfwD1Y5Wq4r2Eyo61zfqoktbPrDe/fwSjjbjfZdtiixt0LunHfDBd2HFh1PEU29pjOy0l9+lDiQDM7cB6U2DO50KoF70u1zYKsH+dIP6h4Id5Q8peKmhLlIZ9T2qAm7M69vhqXQsS3kS84Opwt8v8SXFhwYsGhaFxryzHsfqwDR9/H7lR0WA2W4FiM7a3GX2rMPTxnFThfYBlHnE5aB+pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY4C/TXlNxromm2FmCHowIbRV3cuIDnz/Xc5omIFpBQ=;
 b=Rd0iM12s95H+4kj7vLJnCCOySLI1E/me3t7KgXm4XqvIOYT1RGthumqOInS0VEwAc2qkIlsZqi0ox4UWwfw0dihRKAX1ajxRg2YtezNSIXL0E+T+cAqUUGnKMv2V3c6P4QTGdnT3EyyLZjYsCOHRST5nd93Fx+r3T0z1vTtKAr9rk8wr+6LGoQl2MyulTXJdupQc+5o3Wq0gq9i+JX6/dNmCzLfL+qKi3/4ZzF5acLgL86y9DWSWMWRdKvysHftUscs+xJwmkCkC8yBcYwEHUfUVVDmDokCetUH4c7ifh2GYYhPmT1jXBXC+Goz6uzh4+2HDy44h1zsWxcZcrYPWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY4C/TXlNxromm2FmCHowIbRV3cuIDnz/Xc5omIFpBQ=;
 b=p/5Rhmcp/Y9KTYAYeiniJidsZ2Ip2/x1fJU4/oxF+hdHtPba/iBM8RAZn2aTLq2YmkVtRU7GLHiJJPrPWJyShpzaXIak5iAzblp6Pwsy+7u/TxiQRZHhA+T6SmLdRgOeSfP3HSN4kcCgYz+WmWhk3hpDgx0CXPvhbhJOoZCc/e8a1JT0OtfIbRUf837ggtWcIWMtLT2+tUXFkMNZ+Lm20ISN9fqxmagU/NtjpSjithH+/SlT5gj1tX6HS5oDt1bcJeyVHXIAHhthtiaorcBglq3fGroLKKjBW3fyI4ZeRCujg4X1Ayr7xktJ/6BY3On8pSzZhRo+Bz385E5KyiwgHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 08:42:24 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:42:23 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] fsnotify: fix "rewriten"->"rewritten"
Date: Fri,  8 Aug 2025 16:42:13 +0800
Message-Id: <20250808084213.230592-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 74157f7d-0ca1-4a26-e1a2-08ddd6577e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVo366KBP5yLoYPEdeyhEjfuqkhEKPS2rr/2duPKy3wWZ7Z5cqrlz0iyVLvH?=
 =?us-ascii?Q?YAIL6DQEGgl8wn8WKvM9fyaiLdxS328S6HtoY7RqjrRXw1VLQoz7zsX7VwA5?=
 =?us-ascii?Q?9QVARAcvTeTdDeGYQLNRnbe5Tq3RV+B+bHfSyDtkta3eLGQojoI4t02KAr0T?=
 =?us-ascii?Q?ViPac0040TUdQQ9bUOsPFEI9f3A0zbpxmf3olMMaFbxVFa2bwTAwy6IWk9Or?=
 =?us-ascii?Q?X1oiuUs4eWtX3W0I/WodU+89lPRrBgQxdNkbPoA3K8kbbYz1mxaWyTGyYsPL?=
 =?us-ascii?Q?tqgjF15cIAElrR9lxRfARQZXxKR2OnIKN4bWY4MJ+8oPoegbd34Q27h+mbqn?=
 =?us-ascii?Q?/vrRjyGwgFWu8/XPMmDo8qG9Nj+XIaAKu4QXkd5+LNsls8La6JzII+nEaS74?=
 =?us-ascii?Q?hysXe0TrnKZKYzVJElF/CFykO3VvrOqHarlf2soWGDCYGi3Tl7igkhWNDM2D?=
 =?us-ascii?Q?P25t+dXcpAocm7EAUrQ+ZzRZ9yT9jFmncNAzXjJRGGI80PygNTkmOQ+aBXud?=
 =?us-ascii?Q?+vEfHozXfusg+wooq8ndcRPuBN6lWquPDbSU1BO4I+5W2WgOlMv5rDbQeA8L?=
 =?us-ascii?Q?IzVoV8f4DfqFh9FueCL36D75WY8qk0dEICHoqJU9TuXUK0Fe3Md+bRJH5cmM?=
 =?us-ascii?Q?JYKGCK0gkt77O0gVlausO02JUJB+SzQQpdv7X7Q7XRHlwMDK/NEkUafzTi4J?=
 =?us-ascii?Q?6UR4ztwc2k9Mdr4buHWjTgY5IDZw+sb8rQ0sqNE7ycccLuSfu9DI++Y2ivRH?=
 =?us-ascii?Q?75HBGtlghIJlDFutjS/zM4Rfvry593Oiu/Uh7aPO4KLwhv+t3hngwGNlxCpW?=
 =?us-ascii?Q?ofgaUpG1Z4eXhej2NEpaTIRP+wvbEa30S+UFjp3wsVXgPR66L++tCmJboCv0?=
 =?us-ascii?Q?0ccrh8hK0cSg70cZ3HgDtDpf5ds3JbGZ0/rs4thFqkTYSVejD1KagSvJcFgh?=
 =?us-ascii?Q?aPaWE1Av/H+k92p8En0MiRiH3kvRhLw3qWquplscaIVZzXgKO+81Fb9LOuY1?=
 =?us-ascii?Q?3OtEKApUFxlomUCpuVW2tGionSEbG9EGarcRw47IsG5GRv/UASZetkEPR3F1?=
 =?us-ascii?Q?RX4zN+IDZzz8/BVq+mt76AgUohDb0moumgSbaHHgXLVKfOdAomQDl2lhdXM8?=
 =?us-ascii?Q?8F+vuvn9Y0+is1CdHEOrp8NCJ4kt8QY6P3OqcQWIiynCzF0s8XJMEMAkwBC6?=
 =?us-ascii?Q?AorBCSATs7+MmP8vtY0yoXvZ2ObKS/2FEDcxGknkve7fS3EcXzx+9NnEgv0F?=
 =?us-ascii?Q?3vfRh41UHxTgdJBDf6IZiiubb49a1sGkLnt8ap1ZcY01qMOPAVGeBaRiBzMu?=
 =?us-ascii?Q?r94wKEdPoXfMRDWVzga9i8zEGgjQeKPXtZ8uXRvAqvJNsKQSvEhVjBw+/IqA?=
 =?us-ascii?Q?jN4jP9oLNGWSo/TwGUqnCbLfiEtaj25hKpZayZxDtrFtrFwbAw+yclbCGIai?=
 =?us-ascii?Q?WjRIzHRC/M7H7OUyVLapcaV3T7j6UAKmRMm5IMwiap4Zdw1zs3UY2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgpZO3uCiYzmV/LIWkpF6t3qlGRpgu3nmfMFdJg9VubK+BA82dJ+FOEMmndw?=
 =?us-ascii?Q?SmQgadWfqKVAAN6K07344I3aXAeW4cETptnQdCcmYC4cacUD+0YdWLp6alqD?=
 =?us-ascii?Q?kfPzsRE04jjKLgdLTLCs8skn5+EuJJk39FFhOEe0rPtsVSVNsxoJ4bJyYqHh?=
 =?us-ascii?Q?o9aNBCvBBdJbnkV9zuku7YdACnXS/Fqt9XbhjSMZhb8JZ6CPOv8m8OJ5qNx4?=
 =?us-ascii?Q?eGyixio0mxsGNQvIwRua1NfxOSClSZgW4XfQhEHW6EYmJ4BPQPFIX1OfVPDJ?=
 =?us-ascii?Q?gmctKUGbwNL7umkFY2f25bjP3f0rq1rGHybwPJJf54ZbudA37GfvQ5k16O+N?=
 =?us-ascii?Q?tf0cTaw/XzEtUnJNR68ZheyWoiqJb7AuKI0HugQkyhMr4SRcN7oBF78/NYws?=
 =?us-ascii?Q?tv0ogMwavbawkL+Vp04rGKzFp0+liErDrc18dz+E1JF0GrBcWofUE/15Fygm?=
 =?us-ascii?Q?LCHOourLgoeEF+H60IU7AOVZnB22JX4J5qvpB50q+ZdJqqfzvpatPVM2hrL0?=
 =?us-ascii?Q?Uzx0jkstcX9PK8iFd3x1DsR9MbS3U611A37SOuozP4PElDr2q+lrnhUBWNlw?=
 =?us-ascii?Q?5VkIDljb8f4E/JwqNakXkl0xWjEeqHmuubDoqKM6goxcXlEbxC8Xew/t5bH0?=
 =?us-ascii?Q?Q0gkn8/MKigBR89c0/mU0A4fj2CAE8OHdsFLzpM+Pe1Y93bydSVAPC7U4UIi?=
 =?us-ascii?Q?MPG7AAmxuIkBY52dagD6r5J9/hX4vMsUm5EuC2sRyMFOQdXio9AKcqxhJ0zV?=
 =?us-ascii?Q?VAYCkVLuK8ACGGsBUP642+oB69p+OUHnmb4HzSJ5szXz/wn0hJ0eecSrRh2k?=
 =?us-ascii?Q?1yitKOQxprL1R73eD8rW6KsTyrSjZclVEIRq+sJCqcEHA/KIXngWdapIQrIa?=
 =?us-ascii?Q?ohSjAXYts7E0vzBI9YwJc27iMZqS7AzuomcPhGjc5cLlbqu7iq9gCbfUdwu2?=
 =?us-ascii?Q?1kZb6wJ+urOaOVF1YtmBZENveRR+6Or31dny5r0pqFSF+uo+gIvjQc9qy0gz?=
 =?us-ascii?Q?BoU9KZi9l3RyPAt3wN9jR8bHYf6Ji7twe9qDaMobexDueBOspDGGqJMnWHWx?=
 =?us-ascii?Q?lw+FiEaDTkj0MmflJbOEk4bpD7dbwLHq9y2dvaykCGcHXoeKHIeFk5HVTHe0?=
 =?us-ascii?Q?FOrjMxDdpNkal2B6lsPtRfN1FeXCvZ+uGrNT5sN3tT7H28+ZKfiASnaTGz1P?=
 =?us-ascii?Q?lbccO1XVE0Dx3JZkdk0ftW6q2MWDCC+hF9VtEMuBQcre/2+d6OZZbYxltG/3?=
 =?us-ascii?Q?49BR1I+UaX4xGe759ZM0efmoxK0myQi7tnQWGczE2MWl4oQw9dd8+BMiyhdf?=
 =?us-ascii?Q?gt+NWQ9ev3aGUeAu0vZxmE2z0k6BQ8vMM0zY1RBkO9nX/DgCf449U+TrcLJi?=
 =?us-ascii?Q?4F8DIs4PcO/fW4LgO1J6/P7tnnZQDGRhcVxOFjzKGdTFq+7Bg1zYyl0vY4f8?=
 =?us-ascii?Q?l+25TmSIDvep1X516EF+w+lGMh9ilcutfp7gyNTbmT6cXCBTlFaUaGfuQ7V4?=
 =?us-ascii?Q?AYvXBxoMMVRNGuKhHeuk93tTjWIr+w4jFWVcQmvjy2RpL5kC6fGQAgXzaHCI?=
 =?us-ascii?Q?SXEI2hLx8wUAsOyMG/AMijxO6ykfeo+DybGFzXGF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74157f7d-0ca1-4a26-e1a2-08ddd6577e86
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:42:23.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4PlB/9f3kuMtneqOQv1JjL4dN8VG3mA6oxBHkgkXSjkybmxoOaX31iZ/skvnOYGvOXk1NAz5OjYmFv9WtWL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5608

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index cd7d11b0eb08..7c326ec2e8a8 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -10,7 +10,7 @@
  * Copyright 2006 Hewlett-Packard Development Company, L.P.
  *
  * Copyright (C) 2009 Eric Paris <Red Hat Inc>
- * inotify was largely rewriten to make use of the fsnotify infrastructure
+ * inotify was largely rewritten to make use of the fsnotify infrastructure
  */
 
 #include <linux/dcache.h> /* d_unlinked */
-- 
2.34.1


