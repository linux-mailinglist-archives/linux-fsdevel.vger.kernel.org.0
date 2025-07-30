Return-Path: <linux-fsdevel+bounces-56305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66AB15712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D43169E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040E1A0711;
	Wed, 30 Jul 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bgNv0P3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012069.outbound.protection.outlook.com [52.101.126.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC284D02;
	Wed, 30 Jul 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840219; cv=fail; b=icWgx+rkUaQtBDH8F9pPIDpfIWz20MfNvwpSvtkhdheHGu7LYVhldiy5uOnc8bS/BV2M9zleqNQ1Pw3jvlH1DoVPlAt2enT9F7J6qnNKAQfdttOOrQJbEHTrneKcmipJLFUvS2lDGMEFOEOj0tEa4WeUnsI6p6JGmEs38H8nfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840219; c=relaxed/simple;
	bh=Dy1GvklMyWmnlmnzXOQOg5sT/3D4jdR5tLCQzskhn+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzfeciFqTsbSVpI/S46scEmOED3yfELFLVFlq8Rm8LymnUYVqQNqQtKOSKVhESPM4jlO0zCwF+j4OaH/2M2g6N/OnO0mxP3kpphKIrW99cbrioRniI1ProDDrFmZAuek7uYchIh/Zasp4TvhS/9mU5axGAwbA7xK2PtPLLH4H4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bgNv0P3w; arc=fail smtp.client-ip=52.101.126.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0r1Hatc67gMS5Tmh2aJsKZhY7lYMv7vXMqJNegV40uVz8y1WOW+aGmo/QFKaiRh2R+kzGKqHtbzzr38TI++1wAP/IBF/k1wUxtkjFadtC/EOlngre6kBu4nqX30Wjvrh+l2yzZPSLwkUQ7A23SJTJahfk14mXVfVy/0wOviG1a4IAfED7C/Yzv8uZcFm/l696iukHLUyF+a3dkmIfSkoN2wyvop49AGPrwI8+HQNuyo+7h7+I8IU7YqvpLXnPeMpy5T5ePde8NluXkPrZPESyEBmmVZyu9/Izr7ldgJukCnjICevPIhpsztBuh6Pp8svJOLRnh2OkotRb12Uo/nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VuDKGTKkJN4QVnYFrfvDZADgLwBysiD4uRhYB+v9zg=;
 b=bkfhUxiHK1rcrLg5Il7RKxirt8pIijFVYjQnC07/Ll0Qystl/9vKiybq6fIUDoChJYtvGNZPuUmG3eDIVgzRHWzM549YY6+YfIUXt5Ei05oGnwJRz0EKe3XfeAeFr0KT2kbxEaokTUAx5NrrrGnIBq7ZLlqGN1WNkEAHBMi+QREHuU/hLeSv9404yZl4emP4RIUfFm6N0oiJbmFFavoFR7dHt3gOj2x6qpFelZ+PJsZ1ydACR7or4QLiVWtwpLvLFUsjCnpDVXo3BDExXA0JccRkdP43tIYc5d07StXueK0Dy76E+Mrg/EVu/Jx8MQNsVoo07HbraH2VdQhLEFGj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VuDKGTKkJN4QVnYFrfvDZADgLwBysiD4uRhYB+v9zg=;
 b=bgNv0P3wUgCU42mmpUODrMGb5bz66wJnK/xbbz/m4FIrA5VPVywpQ0d1/rln+t+8fZhZ9reu3s/2IAG3iEkkJTD7vgOlr54gMew08RYOQzVEmtfFOOumpS5D+mtZjWwQUhs2wWCDhFF7qJMgegk8uN+6l+9J7A5CuJBlX6JlwQ46qmIU6PYxS97wEyaI0ppattcUt3pjIvoKYVxXVt8psWFfxo3FGHPja5nJYdYD6uFM+VO43EjgIKimOn1yEE/QzKe67dYrySYChxxh0YrdiA6TaaUjrvC9QpYjb7nvlgrNxQpviM73/L7FeIraOKD/vt1N37NQ68jZRAnFGoZv+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:50:14 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:50:14 +0000
From: Dai Junbing <daijunbing@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Dai Junbing <daijunbing@vivo.com>
Subject: [PATCH v1 1/5] epoll: Make epoll_wait sleep freezable
Date: Wed, 30 Jul 2025 09:47:02 +0800
Message-Id: <20250730014708.1516-2-daijunbing@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730014708.1516-1-daijunbing@vivo.com>
References: <20250730014708.1516-1-daijunbing@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To TYSPR06MB6921.apcprd06.prod.outlook.com
 (2603:1096:400:468::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|SG2PR06MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c61089-bea0-4eae-a01a-08ddcf0b6d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7WGI9S91Lq1qd3lOPmwku+JfngNqNb9gTnRdXB5O/nf8ZsJzhC5AElnfFA+L?=
 =?us-ascii?Q?0b2uVrQEVBfVb9e2T/TBUhOiYGiUWetGlpymsEH6TjK48rwseoF3NbgFf/is?=
 =?us-ascii?Q?q6dE9xTp1YNOPzXy/Os6ygWPVwy19fF0OdfU20cZyG0V3sD0EkExF8YgicdN?=
 =?us-ascii?Q?G5hFfGmy1mMTkWPrxjOfC4LyUgbiug5yA+Ff426uuGV1CFYV2+Xr4MyHp+yD?=
 =?us-ascii?Q?IeoAf6C8+bj03SVpA51N0SC1ZibJNFB4uViT3nLObLumRDtlzTlEX0E0XLzn?=
 =?us-ascii?Q?2OsNcCGX8+s+RrQKPOOe+08VGJvq26Z2/Ftg+5NIUmcZb1NTInaav+soQWIx?=
 =?us-ascii?Q?uTiJhPRsagQSbUlw9Qj22vALHAI82WJXsBsrVt+KC1Z3X0at6yY/Zb127nSr?=
 =?us-ascii?Q?QQEjgR02L4Z0oMwJyvVJI6vF6NvReBWe3NvRoQwj97v7TE6oehPFL/mW5Co6?=
 =?us-ascii?Q?veYxXckdBOyabYA8oLCxgqrfs4h0dTvr+oW0S5c0Plk1M9HQk5dKAfI/PbwM?=
 =?us-ascii?Q?8vAPECjmnEnE8SbB+GzN+DtGeMUBxsLepXc7v58lIoTB/2AhAWyj77mxYaBC?=
 =?us-ascii?Q?/VA11en4agUJY/03zdDaSNvpQzRZ4t14cHUdWz8/Td3EDDJqv6DH657Jj8iP?=
 =?us-ascii?Q?g25TvqnWhQTj7K8rxr7yr7o7tnPI6aXr8kk/f+kD7RhTActG+2Z44oxIi+vA?=
 =?us-ascii?Q?CnyoqaaRIcEj8GO46++h8FSGC62hV6cVneSDILlgR8mgrfG2kS/4kWma31iI?=
 =?us-ascii?Q?F2znUHxNVuzlgc8qnXd0gxF63IRL7+uHhKOIW3PmxrhkmWL9DI3tsFlMKBGt?=
 =?us-ascii?Q?HjrhtQWq0gApNcAmtY1XgJG03hT9Lh3ZxRbe0qdmS87Q67Ssr3WkyAHKIoO4?=
 =?us-ascii?Q?STpnZlQxxWlhgLmhBKGQSTvy2QpkjOth8NznQZS3C3NjNFgqj1H3Z4DrUQLN?=
 =?us-ascii?Q?gFhxGKaZ4qBVuVtCeP8aRKQxlaGVs0Tgod0noV+jw0tnXkDVfWS83B9NopFY?=
 =?us-ascii?Q?vi9Yms6YjNR+ZKl+eHx2N17I+bL3Onm5MHvd8diTCAiXOQdmXUGp3WYN27Y+?=
 =?us-ascii?Q?us4j2Pe3Kc2+rWs7ROH71670ayni6twyTHKHLfYviBz3ZCJ+hAzwI2dlI5Nw?=
 =?us-ascii?Q?B8j0bXsVphU7A+lVxVx7Gko25LxKvdDMUtIk8PJjslND+ELvKTKKYqJvsFqZ?=
 =?us-ascii?Q?i21sFVI3JiHQnVl79ZWEIgF/sc5WPy53Gj+tWe3Ad4+VJoikOeCOkgyFsiBx?=
 =?us-ascii?Q?P3rqwe+7OAkfmYMSpIUGNAblM5Cq1W/pHJKxlRxRKre3CoOvZheBk47UMcVY?=
 =?us-ascii?Q?A8hadPRCNb1cflsEjDriTDeiRnObN85QeExxIR+SYCrao0cbNI9PGZbZC0cI?=
 =?us-ascii?Q?xET18BLAwQDrKVykW2nxR7b7wpHe75MR5XEOFly8nYaYWvX083Fku0Zdv5eg?=
 =?us-ascii?Q?dd01knNDQw0K1V4+An1F/ceSAc+iQLmF5BjHLehFPRak0zjjKR04PA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+Vq3d4GnFeJAOF4/I1BdKNpf0Fqbl72D+MmmWXNhuB8sj+DRvM2m0vZ72fx?=
 =?us-ascii?Q?HFYfErmpCEnEabeSa6ktfHV5ZTojhZDaP4WO0IukGtWB3nSzyTWFpXlVJUnT?=
 =?us-ascii?Q?vKsQZXQfUULe7BwYLZMbmU3Ua54c+HC1pohR+i+2b5y1FFmch2fLrFeCqLXt?=
 =?us-ascii?Q?U7l9Gb/hDMNY8qyMjH8BeR77u4ulOWPx/pHbVIrs4KLlcDIyWiaP35+cpGvS?=
 =?us-ascii?Q?ZtVJ9IllEqzdhJM8PSFLxFQPMGzULjeLOyOw2dopNRFUHnQmCsxfFe7XeFNA?=
 =?us-ascii?Q?l1LY8M+/gbzjWYDClEnrJEkV9W5mNhkwcHZXfobeLk+Tv/4QzNCoBV5zWjSZ?=
 =?us-ascii?Q?5GXPd2iDb5PJuYk2MMDyPbaW04XuablHYLEPMhVPnoHRITRFpstbetzBR9wK?=
 =?us-ascii?Q?Zk9dcdi3NbAXt/obHLuNZaZwJUaOTFFkhnWs5rGfmSxdPxBZMHihm04f4gC/?=
 =?us-ascii?Q?0yqdfLWjS4VMB+wjiC5yywyOY369BA3WpC8Hz0u+s2599WpfRymbKKItYOKJ?=
 =?us-ascii?Q?L3F49PNMJA2Hrc2OrnR18YDYg8OKfpTG1ppdgL88bLy2PhUdbfi1n4iRebhn?=
 =?us-ascii?Q?mqmABYQLrOb4c9EK/DuO9zAhjaGkBj/g5ykHwE02DcoSTuzhgCLlJ/G9adI2?=
 =?us-ascii?Q?4R9K6vBOzF5LYAbp69SSKLwUuwMr3ME9VY5ZvCatQkn3qsWkc7dwz8I16f6p?=
 =?us-ascii?Q?EFWMXfHFeAQ40rOYLotsbxOo0SvYGGxux6wLzP4KV8vW3KHoBmLXKTXME24K?=
 =?us-ascii?Q?3i8lN8Ix949B7ohruKdeeSXYKIN/zSpPDB6eGKPAJXB7iJR+roRFbwUO3yj/?=
 =?us-ascii?Q?8XTjOT9phLZnqr5zfT7Ex/CnHQKG9MZfpGKuB16/1g/vV5a1AUEG+WW+gu9o?=
 =?us-ascii?Q?IGfVGaFDhzsDbxQJW6KkEv34HZd1cfsjoNpGaDpLiHV312RSFnRQ0iYvAgeL?=
 =?us-ascii?Q?nB8CsP38DHHyeQJRRd1ZXz1Qrh3FXvUfBaOm7fYRyPH5UYhOpU/NCtMoM8ZJ?=
 =?us-ascii?Q?3OLR9XqthmEXD3JTNUFAOIO6Y6NGIa6BX5OSZzhLyreeCl7HlmWfLwpkhY8H?=
 =?us-ascii?Q?Htb4c+1YBFd1b3yvi503BRWMwDrh0iw1WIzZQb2N0bCI4TkSa4yn+7yioQNj?=
 =?us-ascii?Q?jH7IowVAQct6z+/Av5Shlu2PHFiNQWYcNm2rY93FjcT2dVsQSyzMyak93cLg?=
 =?us-ascii?Q?pT3taRBwhKqarRNiUYw5cCWc5uUcGVCNkmzVGnsnEc684MkAMRGAQfuM4WNL?=
 =?us-ascii?Q?P1emUEkHsSIhC2hKK9uyALzP5KPsON5iBYPLFdKNB9LQEjdCEjMWZV6e73F8?=
 =?us-ascii?Q?m5pc9wSVdoNhdzfD/+Mxh+pIgf/sx+lqMWPoCGBUE9a/NkXAIn3Vo+MkhlMy?=
 =?us-ascii?Q?LcgpA3JpyV+SNjI19EDAFMZsIgG9GzwtqVMasng+Y2bf+GogivDHVsCt0BOx?=
 =?us-ascii?Q?0nFg9i6uDejyCOGXMWYh1M2OCFRNfUSr7iy4iK7lQp7lpIzEPhHWhPlAtGvX?=
 =?us-ascii?Q?BFWN7I0/V/vXKVss0zlK46Q2wnW0h4D9AuBflFHeu+mziYG21I5rJkSs6sFg?=
 =?us-ascii?Q?CsxM2DllB5l/dtbJSbx6/bwhaE+YnSvtg00//tZD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c61089-bea0-4eae-a01a-08ddcf0b6d24
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:50:14.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5MqjVAWj9tuuIrCTKL/+55IkP/3ReL3wOARFcLc75CbyV8fiAeJH/m2jgkWkWznjqCKsCu6tIrB6CCqyZR0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

When a user process enters TASK_INTERRUPTIBLE using the epoll_wait(2)
system call and its variants, add the TASK_FREEZABLE flag to prevent the
process from being prematurely awakened during suspend/resume, thus
avoiding unnecessary wakeups and overhead.

ep_poll is only used within the paths of epoll_wait-related system
calls.
In this path, after the process enters sleep, no kernel locks are held.
Therefore, adding TASK_FREEZABLE is safe.

Signed-off-by: Dai Junbing <daijunbing@vivo.com>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0fbf5dfedb24..d52bd9838ef5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2094,7 +2094,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
-- 
2.25.1


