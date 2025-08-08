Return-Path: <linux-fsdevel+bounces-57034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D19B1E2F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5914B17686E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C622C339;
	Fri,  8 Aug 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QQtk0hgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012009.outbound.protection.outlook.com [52.101.126.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DB2367B2;
	Fri,  8 Aug 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637321; cv=fail; b=Yn+pl5OFz5bjxzwuCganEeMoDQstkTLyN8RQmL//nNUgcTp3mKW7AmVR5SzHbLzoRFOS8JaqlnXNXU/xXFXCdPGHry7AR9aCLsGegH3RO0hhjs8ckTapDNLIzItimxS6p803pvWpuHdQMEHQn4E5D3aES220LF43mZTAol8NPQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637321; c=relaxed/simple;
	bh=Q1xDVcw2WeY3qudsEDcQDGI5tFxpdAtQWW/9ZAL15Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdKLSOfoi8V36dsCizRZZfaEB+tlJaoGE3hkK9fhH5M1preSXddk6GWv4AG0hyHaoDmuRwW1cTfcjDFi78H4Fdx2r+Wd1mIxwDldKxKd81l/eljjWra7lEwQU9Xjjaz+fa6EuKXOIZ1i3Cmaw16fxZt0DZgYcmb0ETxvuMjjOHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QQtk0hgm; arc=fail smtp.client-ip=52.101.126.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVGH9qIRzPhuCB715HnNvbFBuwrcJ2A15xqiNEVfAKuB6jqFonLgcxhDRnnt3lG7sHcUBA4+B6YlHOJSdUehY1Hi1Lifpiizs4IzpuXkpETAgxtS4MFpt+BgIUn8p/8ynZ1ASC/VWgife07sHB4GkR7GKO29Oqg/vU8kb5Jnfc5fsy6gPgSphPijsItWtZ/64T7u7RmO1xZVBtOzkHaSR55DfyBlA7F7E78/ngFi25uDwMYUqWCRW/4asLYD65xWesKRH/HAju1pX0oMuGtRfW8uV1sKiDKCR6tuVRMVx8zYVmkSdWL7Z2ONP6wdU47AAy4PCrba7n9y5Xh6urYlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY4C/TXlNxromm2FmCHowIbRV3cuIDnz/Xc5omIFpBQ=;
 b=gFINzd1kT6qpGp0YEEyKCA7//9rxgZOv/SWGWFKMmIXASASY77d3fJe6U+Vmev7zXWch3IRGcKQXJR9v1WJVjKrTYAVQ0sorucW7MEEZ58Ng82U51X2OS7oiyJugGpqnnCrzYf2pUSQSOmqE35sgqcuaJ+KdqNxjYh+/bjBD1U4xHeDQzuuh9HoNllEtLbhLysj1uF+rA8+pyM+8AYvMQT2pi1L2paidn6kkR0nKSvK2tT2HsOuKFR031Nt+pP1Jx//R15D2fySDFBOQBdmycAjuU+GqrcvnvXjGk3igIC1d8KudoZ21Kdgd8fK2KAXoDgRpSx7aQLZZBXqMKfFU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY4C/TXlNxromm2FmCHowIbRV3cuIDnz/Xc5omIFpBQ=;
 b=QQtk0hgm4S2P97FoFk2WmbVXb/1pr38kd96NIX/YQGzuFEJE0Gs2b2Eh4gxUZ5+dhiaFxjJwzEJKRUAPkligzbBNquOCi9SKdFoHq+R2hJlc8zkVIGykyv3O893Y/cQ+hgcOZyHsQsK7Pvtz0E3WxvPrm1PhZpvypv2BrhHz7aeblOoeHhyS/ISGQFiOMc6px4tccVrQGzAqVmNBgwQwgidhC/JL1MASSvM/N2yfOm+Mwzr5UJWAGfiX0b4FwurL9/GJBY7oQM88HFAopDB3QpskEYjFuTf5+g40ty0wDGPSqyI6KQyzwe+xzWYoDIqFzc6VvHf6nISRkEIswNxRkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6463.apcprd06.prod.outlook.com (2603:1096:400:464::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:15:13 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:15:13 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org (open list:INOTIFY),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 3/6] fsnotify: fix "rewriten"->"rewritten"
Date: Fri,  8 Aug 2025 15:14:55 +0800
Message-Id: <20250808071459.174087-4-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808071459.174087-1-zhao.xichao@vivo.com>
References: <20250808071459.174087-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec9d17f-bd0f-40e0-a408-08ddd64b5178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SvCT5xb9UtalzWtVxOwDF2BcslHF+0mHyCI9LK1CCEepSOwBDTcLQITDVgF9?=
 =?us-ascii?Q?9q2fBosPOB0z23k5MzunM2C1R9hkgqt6I4dMGNHJAOk4MA+dJlNyAS4TFCOQ?=
 =?us-ascii?Q?iMlepK4piZrGJK9X5kLRiXwW2Cv/AdQGm0ZIg2vzbYjovBpFSAC82lBB0k9F?=
 =?us-ascii?Q?HvfSKeQM8IDxecCyJxw6lha7+1Xq+EHdzh1Dyrr1VlCMUrSMEC25xBb0wls+?=
 =?us-ascii?Q?7WnGBOb5UhhHGhfZf9oQg8hjZ1GOco8AzB/3qQ1NhOrB6MjzqJeNdczyJ+qS?=
 =?us-ascii?Q?eKQD0u0o1ridAbDMur7GyWSS3zWaWB8iH7BL0S5mE6tu5UHkZPvrCIKpAivZ?=
 =?us-ascii?Q?/2EHOZbaW3nakJaZC9ndIvrop3zDLV2U7WWVz2jpr87stN9yi9um0KyaJtN5?=
 =?us-ascii?Q?D48L0O9HBH5fiHfgWPMtfR2y8EGN8NCV+dIioCK1GO48MTnu9uA4x1iRMVsT?=
 =?us-ascii?Q?CPyUPy0XNZ59fC7iQ7XVGE76YYJVdlyhBslCVEcZN55Mumu56JOTk4GmUUTa?=
 =?us-ascii?Q?Hu9L4tWCu1Az6bPaFjik8dmdlF9+T+W7nDK66zPYQp30GL6uphxzy4sP3kL7?=
 =?us-ascii?Q?cv6MfauMtD04wa6VKtA6+bWeuXXmFvDWhzjbuLvgfemgfuQN2lXkduan7sRg?=
 =?us-ascii?Q?eOeo76Bxn/y+K78uCdw7wbEnh7X3J6Nspss0VunfCzeNcvpaP1rUseELt08Q?=
 =?us-ascii?Q?DNwhKNODh1zfcLvQE1jXIRwdpfIpQaQzBs3DEh8GzeTBlIBSuTeSpg8E3pRB?=
 =?us-ascii?Q?m3q5Ej7m2Igcya1pnihtpuOwXTbXRUNaxw1cvbSxJjHZw5Lioxqv9q2Br+0H?=
 =?us-ascii?Q?E6H9vKhZsYLgz3QHMjeGvBPIZO6qE8n31C2AIOZxWH9hdPS2OYNjtuMOJe7/?=
 =?us-ascii?Q?al+tq/WM/iqXrz+NZdWQZmw872PScOXLr8xzx16ls3RFP7rJZHgT4aTcaxzp?=
 =?us-ascii?Q?A68XQPyx/Jh9Utve69N6TXswtLnyRswDsuxrQWbperA83YS6K4aQ47mgmIoo?=
 =?us-ascii?Q?hAc07AJOtLtKxJm5GJAAH3c0DTjOGsIvUyPeDQ/DHEDpOtpFtl/gcX6K45vM?=
 =?us-ascii?Q?PGB9kpeeOECyLQwW1+W8tBjHcVFD4V0JczDEgfMVdtBV0o8Wa7QldCOg1/W/?=
 =?us-ascii?Q?5lzjiAuBFGGDEtZQAoQ58c21h2wNAnpnEUQqrxQ1ndek7LkzO0F2XU5Y8VkJ?=
 =?us-ascii?Q?BUNff6RIlT5GvPbKwlIsW9oq17ZX7W4aViWKuJRcXvhcl1sw5PWVdhjLUwiD?=
 =?us-ascii?Q?UFwCnzKv9JGAASCjt1RtJHatAor0U9uCbSRqg9yRV1qzFhbX5LdjMMP3SKlu?=
 =?us-ascii?Q?pONCK1xuUuAmQ2lcJD2MPdviI5qCnBwdeeSHJHNxrOW+OPWkW2Lglewqi6Lu?=
 =?us-ascii?Q?lF346qMmFdnHGZyS9E5ouVqXf+I/Lfi0tFBrCAHA0tkj7QYEI+u2WyqT4+K2?=
 =?us-ascii?Q?6sX6dzd0bSbT6ZvBA/Ma6UOQsjNVqannBbeyx4OJE127x9u7YnFWwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jv21zXLRL10PKSlxDYNSX5Rrz3keCzcSeGQjzcvpEXU94FyXDLhDZkRr/WYz?=
 =?us-ascii?Q?QZeEHnf46LGE/hnuzEEeMZKDDWP2WuhDJZDXHaTfKboOpfWnZlRpiW6I7T7z?=
 =?us-ascii?Q?UjE44jbHJtS2L/vBGKS13O+GgKLExJcaLc5Arj7cr2OWB45owYuP3Ayb0zl7?=
 =?us-ascii?Q?tZS8pSEuckQLszViqYZjiSLeINDvOzbd2E0/n/tspELTY6PvrklZeh3Pa8Sz?=
 =?us-ascii?Q?JOJ4MYYwLrwm3G5qNFMrDo6EqLcpTyilblA+b9Hs3BO9So0rvUCXcR4mLj1S?=
 =?us-ascii?Q?+/g9HLeb9oYbrmpJo+PUsNdP94mF8w+Dpy5u0yfS5ZXtaPcXsrBEa+ysMt04?=
 =?us-ascii?Q?TGOVYVORJf31A+BVH7LJ5eV2vMfHXg1pLTpT3ixnWz/2NIML6Ui1W+Fr+mAI?=
 =?us-ascii?Q?dJGhD/FyHkcoXXz5+Z1LSqaISWVd8GR9elSfaFZXVG2kthMLNCkmf/ny+bPe?=
 =?us-ascii?Q?8JelwcjX9Pch9RKn2nK4aW1ROXV/x1Z5mtW9ZjCoQS53ZDR5k34dhgaABEq0?=
 =?us-ascii?Q?cnI66EvF7gK1Ebyu4fPY17MBZLMleJ72cge1zryb56F1iDHGQk1PXowmRV2L?=
 =?us-ascii?Q?EJrUG55V9nF1DSilqX8nN+60lihOI/ADcu7bSLSmhrthXzlBJlDWBjvjygHV?=
 =?us-ascii?Q?Vf7lL1SbrRV6efR6JD7XBCQF1BiAhu0169V7z42ewLqc7bxAWGHp/n6v05UU?=
 =?us-ascii?Q?VzwtKIBYoYF2AHgLkNoajLFep5grT32BM6umQaLD7EB7+nUuhpYa+H4ZsVqM?=
 =?us-ascii?Q?1C++sohUKaTIS5IX9tupMmMj/MWWv1tIhPh3hTWAhJTrhkK5/JYXcwIDtl90?=
 =?us-ascii?Q?jw0hsBUz35FiCDzixlo6nkDNYTnQo7ismo20/aykq8AFQwlbfHr2Yl0eyfGu?=
 =?us-ascii?Q?9KiIzKsSjqrOcpNpqIuJ3UrQD2gbH/HJkBXvxi99t4lmJiUd54ZKpVxULmAu?=
 =?us-ascii?Q?p+Ux3bYKqv+f5AsW70ZNUYGK3sdx5Wb97Ii5VVOUdoZI+j8QiI+QnVfpW8tk?=
 =?us-ascii?Q?Ve5mx+1SKOcK/R7hHVlqdicWtINwBUc2voPsbjeEVzrpV2dpjfQNOLVdUhRK?=
 =?us-ascii?Q?RFY/W/5jh2TfmzhKvhwO603A1mKZ5uIlf0/idwCdch/UgcxPf+OKx7wxru8B?=
 =?us-ascii?Q?+OAoc6wah7Jr8rIN/ZddWhJBh4rV3FqMSiqriGC07PtIEd5WZ1j8jekr+PK6?=
 =?us-ascii?Q?SO39Zgbd+WrlbeEdvgVJ5b0/p3i+j5o4qUUMi3pnE7UtshR4i1QWiDOYSBN/?=
 =?us-ascii?Q?/BqbqwOBO5QB94dRg7MHnwJLUcjpV65VM0O4QRGXu9i3PiBJW6o4B0u7sSz+?=
 =?us-ascii?Q?F5sr+FtaE5u8pMCQxb978r97pO2/Fci4NhaUpKBIsb2/guXYV6hkacE+RdWc?=
 =?us-ascii?Q?9tNHU89jh+0hAihEeRpg8vEonoCONwQ1lFeCfEQE3mNnxhmFZPGhw4A8q/Fw?=
 =?us-ascii?Q?k7C28pFOpKoEUxxWdJr67s6p/FQUW4m09HxE/7ZnbSNtKir9Getmr+gsn6uU?=
 =?us-ascii?Q?o0xCXtxDSanZLMpeeLQBG4xQGqNbcMX+uF8NsY+gK09zaAiV5gj1NNKfnDwj?=
 =?us-ascii?Q?G80s4Z1bwQ2ee3mq9NOpegM/zN8wcNCw6OVZELah?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec9d17f-bd0f-40e0-a408-08ddd64b5178
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:15:13.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: necZAgYul1FPoVe5CHyDRS/hoK65l4v5jujruGc2uP6ullGUPOWkcvgeXq0NRBoAOF/ptVpgUe0DwaLcZzeuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6463

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


