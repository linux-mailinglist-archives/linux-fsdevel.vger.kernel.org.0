Return-Path: <linux-fsdevel+bounces-56007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C04FB116D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 05:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916C17AF685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F53207DE2;
	Fri, 25 Jul 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YymTIyNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FDEEAB;
	Fri, 25 Jul 2025 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412666; cv=fail; b=ADfGukYQSG0AK4wlLSyMW97LzHm/akpFkTEy+sPbDaxHzLsRDorgJCXJYJQ4cFtYcvCgGu7kPyrCdznEhgGEGFta1xGI2d9f21DnEGOF5Nn8JLJEYAi9O28HpJlQJ/eogFCJYB7MKL4wmypUrdC6IpyXjnDun8bHpp923KaMaNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412666; c=relaxed/simple;
	bh=GGNTFiv58cwjFA9VzAhw6unR89MIBkWs3Z/6rPGabDo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oQ3wSsqXqLo2OotxIpPjxMk71H8akvHz2pTJdoiLxo3uzPoDGblHS8KP+oomDqHjv0MHQbErJYUU1OZ9RYKXUEMz6E5p4bRjfFE8x3p54wXLyHoFi9hufHAKynvuhjNLCNTJnZ5h2f9fsp1Z8uLHZoQ2KzKRemmsrAB3NLBFTUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YymTIyNx; arc=fail smtp.client-ip=52.101.126.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlZxmdKOg1cDAquaeCia7QHai90UQmzpxWWle/Pkd6Vk3vwoNDoki2Pvi1OmeI0JX/dJLOUb6WaQu+CSB0+hFhqSM+ml/mdEUFwS95aeLwSU6UbFbtrW7NTTnIjQROawSWU5ws0n3YyQExYPNwl9cz4aV5e5LGm7ByD6FV/kPQsAIjQY156Q688F+zLskVjkovN/qqqRlYkEFhUYO4/wpRI+8Z8Po8RacBkiwrdPK9+0klgLEF1AhFnOZdhuMYV+sK9V5uSR37QIUGQdHhlNlJsMi9tYN3zT1IiY/UaJV6BsHnRHkcpoJc1yXA40hS3Y8RslrV5cc51RBuwXAgEE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk7nmm+Zc66IbwvX3a2xyZLYmjBAyQpclBPHL9mP6zU=;
 b=qJbmgRrbg4xwmU6rpGtYEbsmIsUuKbi2NZIAtj72u75E0OePVErlu95utldHdmcT5KTGC3x0+68FOpISAWC1+wkKejMTmFgyv930FSqY2H9Br+l6P2t6lJ7O1qa2cFOhBoGmp2DAlxtFkdZMk6AuQAfdnZ+ZAY/f4oBO+XhRn9KppMGMBpOOKtDJH1brXatuB+sU8FJZdf+D4fmGfPHXFsiTiSVZYjTv1YdPsRZ5fjjtmw/qyuEhevDEYBuAZLcuTarxLtBPVUfU6KOi9WHmn6yX5uBOuR48HuKoD2B0/SRe3eZifC3BNh4sA9ooAsfEaqxwBu9/Y37WX0zMQHmCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk7nmm+Zc66IbwvX3a2xyZLYmjBAyQpclBPHL9mP6zU=;
 b=YymTIyNxHxkPvjRfc8DNTQ5h0QzUp9L47C1Xo35e7B8ToVE96Id7K9rYv8c6gTltA4Rmt4CDMH5wZl2dRkVvAp9d9XLw2IbKc9zAweA5brpsNncFS0jZc4D0mnJwFBIzaS0DRUh1KsMzA3aPToieaS3SBZzmhwc9/QL3TztCzT02ppl5jq0w0YngW0XGh+yw9DoCzs2pcBu1pUgokMrD34Y4bJkIeE64MVlDyIITu7eT8C0/Y/hMA4RdgZHmryfItBpOW5EpsCAQrp5x5d9kLdqIc8svBexZp+IqTUkt1G9p4Daevhtz6HwW1uR6uUI12KUTxahmGSjzRVOYcvt3bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by PS1PPF58B68ED36.apcprd06.prod.outlook.com (2603:1096:308::250) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 03:04:17 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%6]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 03:04:17 +0000
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
	junbing dai <daijunbing@vivo.com>
Subject: [PATCH v1] fs: Prevent spurious wakeups with TASK_FREEZABLE
Date: Fri, 25 Jul 2025 11:03:39 +0800
Message-Id: <20250725030341.520-1-daijunbing@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|PS1PPF58B68ED36:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3dcc24-df71-4fe0-3a32-08ddcb27f15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQYyKj4QWrv43zL/h959xebbYUpJG+90yJjlLUGQ9a0TR56ZAnxklh8+tt9D?=
 =?us-ascii?Q?hmGqX8D5cIDUXOVsVHOHCks61dveg2YBKr5T4L1ye/GtOR6RZ+bfglqnts2Y?=
 =?us-ascii?Q?ISTxnRSDsgFzLUF6Wcg5rK43+8vMeWeTJ02lEGjUY12XCqq/hP0DYBc+Qhvn?=
 =?us-ascii?Q?8XX5nljbabMZekLjaaWWuoRB0JBaUrs7AJSKxj9Dvx9KgNQ3q9XUE+ODfYIL?=
 =?us-ascii?Q?m9h7ZrKbdgUzhn62FyMSnw0jvKYI0pVFnFggoCFgysdg+DzFR0jPbqTqazSi?=
 =?us-ascii?Q?W3tMA5Bg+QrLc5cH2uoa1IFyAK2SRx/qTCguDgv1ELGrRyNzeU3uLbeuMiFy?=
 =?us-ascii?Q?IpB+k6bO4muAbPg1YLUMdKkQcwtVoleNwA55YmF6ItUywAGHCAjohob3FMRo?=
 =?us-ascii?Q?QzyCRR6l7Eu4yVsMtUUTYKJvC2PsQjmxX3ihEuecD75jrhFUzuK7Kr5z1WOW?=
 =?us-ascii?Q?IwxXb0fWYTXVa0fmxOs4uyKI7D+bQS1/g+YKS0xtFA9O1y9GEjp7N8jLeN0Z?=
 =?us-ascii?Q?UjW1z7S9RrstSYdJgFX145fBKsgVjS4+/DLEmS7wf+MB2cx7itQsQvpeM1+q?=
 =?us-ascii?Q?nBerRQpFZ8Roigc1FBgG3usPRSfFGOWNWdAa/+5jxpJtlhTGqPFFNsOZzG1A?=
 =?us-ascii?Q?S0IvHgWvPcUfzEMV1d4uMCZAWa9POtri0IHE70Ks4vbQLt3LSv8jdJmmcPCT?=
 =?us-ascii?Q?XiKI8KmKgoTMqYYoLROg8bSs7/67a85pUCQkje/KMln5CBD2MYNpIuU2zsW5?=
 =?us-ascii?Q?+eDXVyExue17Wyg6Sji7lnTdeGba5H3V5AA9ljVcjCvTMA2+AaXG6LUqlBTw?=
 =?us-ascii?Q?HUbsfTfyIqgkQvMvWGWSUfhjIeOdkWdabPUjbKiCEDBunZ55TNw8cXJH3tgA?=
 =?us-ascii?Q?CJxIB0x0XeARLDVNPDniGKkc/EYF+mFaEnufwr4SgEXhfKDj6HNTPbf37Qh8?=
 =?us-ascii?Q?KZCxwKgAs/yrBjg+utZHP8WBViE1ORBbvXexarzhF7mmhbA21vf8mYTbz0vQ?=
 =?us-ascii?Q?KyGJ5i0AminQODJbSS83UvpawLqncd3WF2UPz6tLDkbbseV2V8nmQNCoR60j?=
 =?us-ascii?Q?EWj/T93JqWrr+N+f1IAOBGh66/6MkS1v5YAxqN4bFBAhLqD4T+JopLdANhz4?=
 =?us-ascii?Q?OD7Ohj1grP5aID8nxsw907rxiAVXa8uk3s/eZiRQEzWT7sNrYHmWPzDKqj76?=
 =?us-ascii?Q?SlfeqLV//ltBL3rHMi66ygJb4qx5YzpSlkRIyoulZBfUtC+bjAWLnCfL4JIf?=
 =?us-ascii?Q?eHUJey0puVgYo4A8Wqw6Rn/QpFhijHl2fLWaSwu4bq5HOaNqWo/fx7ydgauz?=
 =?us-ascii?Q?rtpeYi1pc4pe7o6VsyRqurGmmEmCdNDLAivWdfEPfZVkLe6Ae1GpvZzXVqH3?=
 =?us-ascii?Q?w+TU/35CZCXrc0TEd0OUll7jlbJ7Ujv00MShqjBUXooSCuwi23AvTa47ags7?=
 =?us-ascii?Q?RxwSoUl3FjHTfwsyw693otoiEoKwhbLBFFVxqd/hRcjhGSP5/wX2hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q800SUXOogHz3sOEFh45iqEf1/3wiglt/h9bTTWHEdRAR96MZaKCERLMGS+I?=
 =?us-ascii?Q?dYTn+/+REciRBTdsMD/fRyy1cRQzsxyhx9oh4szZjBICS5DgrqU5T3wyOMNF?=
 =?us-ascii?Q?18SkOVlQ8FQfZAY7/JzIyLAYor4nlyGYi75c9t4Q2jlvGpBY7/HsNtCZczri?=
 =?us-ascii?Q?X78CvYyDe+ninxIFUAMCKk8zuNCJZ9zLfkfwE9IhsPi1qfKZnVR2dPK4fRQd?=
 =?us-ascii?Q?iZ5KP/CAttrad14KyQL9tYKTs2A9fRnfDJiZ402xJLZbSvHv0koW08vKckdq?=
 =?us-ascii?Q?33eL6YxzneEqy5FOVPM/vIQzLthy+tIgXiQ7tJpQyeO1SKxbvPRgm6vLO/gH?=
 =?us-ascii?Q?L6koiNn7l9GgrfihYAVkCFWr6wG956Wo3hNaij1QB9tBhnzqCA4EpI+I3+qG?=
 =?us-ascii?Q?E49ac2j/z6KNETBF5YQ/2T735Qu/BhAMTJu930LjCYJc7LxM6dLgLwafzurw?=
 =?us-ascii?Q?U3NnDDs0CXbwIwjMZbcFAmwfscGBunTqoq+af4qS1tOI3ruBcs24aA8fYcu9?=
 =?us-ascii?Q?LLSAPDdIva7oS0jgQpjcdpZvcifgCiHVXttJ1kJQ6MNSK3MW3NZa2zr6/H6r?=
 =?us-ascii?Q?YWtDnc6y57rV9j3qGDdrpLOOpeUK7ATYhTz4X4WPaIniDQNaLGBH/ZJyKoAm?=
 =?us-ascii?Q?7JcChaT6C6/Qz+L1Qf3cvpSJbDQvIE5PNxsnMfW4lMSq6RdccSo6aEyXcTtf?=
 =?us-ascii?Q?R4o0DupZNUWDNz+QvweN32CbGwysI8r1TS61lRuB9EGQJpP0w2pvt24zqJRF?=
 =?us-ascii?Q?K1Hl8ocYANHkHBTeLJq4WA3d7BIAjKwBscJLVD7fvLLWqD+Sn7e6QdlUkI8D?=
 =?us-ascii?Q?9Z5jAOaSImMCn6v/JfJu6phQeUCGG1+qS7sKlvPsWw/nCeX2lXHUOAGbkuq3?=
 =?us-ascii?Q?pFizF1kv2QciNuFUA0L3mzLGYLwj1GImJi7519lIi5jdN2V+dq78tGKDLzQm?=
 =?us-ascii?Q?RCezBCYZeZ+Tl0mXbsooPk1LKLyAvoAEfTX26+iENHF4ZsHn5KK/oD85AuJ1?=
 =?us-ascii?Q?H4aCXPRCFO78xnzzi91hgaInzzMAG3w1D+JURw6u5PZkRCAUgrDPzEAyDbok?=
 =?us-ascii?Q?8llOsTp4d0FD3xvH7H95HHuK08p/+n6LY8lpGIhfNWr5SG4pZvdLD0NxWfT4?=
 =?us-ascii?Q?XqzdaQVe2OF3fn7/SYEAAaa9A1Ka6PE+8A6iUGw9hrg/kUrP8f6pse/hXyoS?=
 =?us-ascii?Q?5SLC+1r3QsQb0/AnM8GHWOjGYS00kk4MBWrvJoFsbTSMCTIb2huCo4D63AAt?=
 =?us-ascii?Q?cUv51Prb57p2dtdLm567Qs7xhqzetAstIWGEjqNUha5Fq52j/0t1kZZD/tu5?=
 =?us-ascii?Q?s5hTezjyYAHjxlMFa1Q2gBanEjxg4wEqjbRXzpBuvye1LWh94/RelPy2aNzb?=
 =?us-ascii?Q?e0zfkUik+Rvm1d29H9P/M1CIcv2vZisYTpzA8OUXDiiCQUS6lZdZsYvgwH0C?=
 =?us-ascii?Q?SICmkkUjw5Ex5HfHS6s4JaBxdZy11Nwr9smY2DHNm4/wW+NIJiyGZjhV9puR?=
 =?us-ascii?Q?WwPi2nwRKRb4s6XJMFcRSwTeP+rrAlM7MmGolSrJp+jMoCBVL2foCEqIZnDC?=
 =?us-ascii?Q?pQ5GMstiJ8rAcJ46M0zi7bSq8ynTMvCdfcwHAilW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3dcc24-df71-4fe0-3a32-08ddcb27f15e
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 03:04:17.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1TJbscf2Pjst9IsP6TsfV37dkP+YEHwujaJVImfzYf+4RmKlgXz2wZt32FDM0G8+ExPrUtrkkVEwIZY83HhIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF58B68ED36

From: junbing dai <daijunbing@vivo.com>

During system suspend, processes in TASK_INTERRUPTIBLE state get
forcibly awakened. By applying TASK_FREEZABLE flag, we prevent these
unnecessary wakeups and reduce suspend/resume overhead

Signed-off-by: junbing dai <daijunbing@vivo.com>
---
 fs/eventpoll.c    | 2 +-
 fs/fuse/dev.c     | 2 +-
 fs/jbd2/journal.c | 2 +-
 fs/pipe.c         | 4 ++--
 fs/select.c       | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0fbf5dfedb24..6020575bdbab 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2094,7 +2094,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..b3dbd113e2e2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1418,7 +1418,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
-		err = wait_event_interruptible_exclusive(fiq->waitq,
+		err = wait_event_freezable_exclusive(fiq->waitq,
 				!fiq->connected || request_pending(fiq));
 		if (err)
 			return err;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..a6ca1468ccfe 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -222,7 +222,7 @@ static int kjournald2(void *arg)
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(&journal->j_wait_commit, &wait,
-				TASK_INTERRUPTIBLE);
+				TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		transaction = journal->j_running_transaction;
 		if (transaction == NULL ||
 		    time_before(jiffies, transaction->t_expires)) {
diff --git a/fs/pipe.c b/fs/pipe.c
index 45077c37bad1..a0e624fc734c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -385,7 +385,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * since we've done any required wakeups and there's no need
 		 * to mark anything accessed. And we've dropped the lock.
 		 */
-		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
+		if (wait_event_freezable_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
 		wake_next_reader = true;
@@ -1098,7 +1098,7 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 	int cur = *cnt;
 
 	while (cur == *cnt) {
-		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		pipe_unlock(pipe);
 		schedule();
 		finish_wait(&pipe->rd_wait, &rdwait);
diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..0903a08b8067 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
 					   to, slack))
 			timed_out = 1;
 	}
@@ -955,7 +955,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
+		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE, to, slack))
 			timed_out = 1;
 	}
 	return count;
-- 
2.25.1


