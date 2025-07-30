Return-Path: <linux-fsdevel+bounces-56309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1EB1571E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DCC5A146A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342F1E0DEA;
	Wed, 30 Jul 2025 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AUjFBxsr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013045.outbound.protection.outlook.com [40.107.44.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38E1B0414;
	Wed, 30 Jul 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840250; cv=fail; b=EH7SO1CHYpfFlXt6M0YFWmDxgx7UUl+qGaCUzb1Zx9yN4HHKVP4ssMdJIPT6HofCeA7VF7kURVQoXndVln5oL/kedC5EZ+LvfHreHh6kRKXnuZrRCtp9LAMMVn+75wNPGiZQfjANSp9XUN2FCy4M/XQ7BeTByeJsf/dPY/VmRHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840250; c=relaxed/simple;
	bh=SoSUlftAxnZGGEAx7Q6lZi8HTLGi+7eQvVs6q+P+A68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cDUBo1pm3LRmokprvkcDriBZTYMlvLKWZrzON/J1i8IxVoW/qpkQEzEaLGWCtEJgn9oG0M3a2V9+dVBHqFAYeCz0HqD7hJHdmMGnBB8J8soPUNOuUNW4rqmSUCQUH52UWPFkBV77ieRmdXZ6tFVAt0tooBYX4UGotkGih+AiJLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AUjFBxsr; arc=fail smtp.client-ip=40.107.44.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLr444lpgTO8lDWVKUqCcK5++7V/tHTBEu66nXJVboAUBghR/NoDHLqq/+S7moYYHYTkbQAKP/BQ6quwvjuGvuqI2mRe8qNz8mMCtzfRoNEWNIppeGLgDJtfokAAv7+a6YKKOzF93Peqx0x0+e3pxi1NrSOwgarIu+7u7s0tVHKuXksYPOmFQUDFvyzX/zgUkBxklKgFIwd+B2iiPCg4P6L8vKbpjvLrOtKPKni/u8dhyndZO0IWV88FpJCEZjyFSdlZymFCwr0o6noOXaem77IEu/wctOwD9HSMpe9zXDn1lq0Il3//2+v9GMYaautYtDPoXvEALuXZKJCjoONNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0fz6R6c76/McEblHuEKBzjPWv39XjNw8+g5+APIMGY=;
 b=OA3stwXa7/1epP7Sk+8ZMzkPFO9zBl4RXGeZdAC7qIIdVtSBQlVLg/2XSQRgQtCoLFLCveFZ3WfXT1p74P4ywOfZ2pRHaSkgWiuA4zcQ70y/SPq1CWKnXOPiS3Oyj6t7Ylq6x6wMqfBjTT5L7+pxWUEXNrFbO6HRFQaNZo8ldTkRl1iBd4ydccUa1LlNeVS/+4YdLJo3Wl9kYL8+WZhpEDHBqvGLjWYyvytJfRitLr7sk4kBHiKLguhrGsxLdi2sVFjkBcjGMvfXZUKaQuAFBl/ykeEEmYNTkUjima9h+9myQVJbrDxEplxSYhniw5RNwkVSBO7XQ3fgdiUcMWoyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0fz6R6c76/McEblHuEKBzjPWv39XjNw8+g5+APIMGY=;
 b=AUjFBxsrdzCQO+OmrsMYmziHKMB9CSH1AHqNClOZ4p7RSJ+0OUzaEtWUvEpNjGQaH8y1jZW8Yzyu3gDUdgmHwu+F5Eo8zfuESF4xFXaNaNwL4Hq28w9J5Ms9hR+IUjh+X1ZimryIhNPgzFLPXXTxIuE9ODgMt+xq/55kYwVuLIOD47HbeeVDbUaNh1s03pwBPiMOUIF1oj1MCKi/SdLQkSvVHqIJiDvvYCqWShUT3+NQrFNJItS9MOstJse1dRpU3BSqxjMf517xiroFF43wk9ork7zWwPEP0PGD0T1DGTmAEswcpkrUbxtWNU2c5eqpZujk7CDh8S5Z5LCcNtJ6gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by KU2PPFF77CB3BA9.apcprd06.prod.outlook.com (2603:1096:d18::4b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Wed, 30 Jul
 2025 01:50:44 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:50:43 +0000
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
Subject: [PATCH v1 5/5] jbd2: Add TASK_FREEZABLE to kjournald2 thread
Date: Wed, 30 Jul 2025 09:47:06 +0800
Message-Id: <20250730014708.1516-6-daijunbing@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|KU2PPFF77CB3BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cc6be2-e851-453b-5582-08ddcf0b7ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzxqN2WXQ0JEXq7Hj6Kc/2COGakAS6MFTZzAZEYbSzW5bOfojE5Ow5sBIJ75?=
 =?us-ascii?Q?0RHVO8BAAnknAhby8s9ga9e2jdMQl/Ns5tCSmt2a4MGSye8p4qtf2n5KgLZT?=
 =?us-ascii?Q?pUcuiDFF2d8Sf4uPjqum7BHHvfEiBbcShGc5VpFOomQ585s6nXZOVnO9DzRl?=
 =?us-ascii?Q?4mCmCKPhnbjQtMZIc7rCWpgNag7TX9QMkB2y0wTGsKCf+mmuKnM9m06LE/cU?=
 =?us-ascii?Q?rGWY7PRfEs6Zo31/GDY/Ne8CA90dwMaPHTNdMcn0rd6A/0xVW2Y4RYr25ajR?=
 =?us-ascii?Q?06gbr22s1pUXyvyycqxH9uk9XwNYg0banlMcF64y7uVnpINJHwEzaMMSKoHL?=
 =?us-ascii?Q?xRbRm0n89+ut9DoEHwW2WoYZUwW8kx/UEXuwmHYyyag/gMcoVbhfqzMlcbB+?=
 =?us-ascii?Q?z0wOTJ00oWtWe9g6w86q+uuwHn1NXUKa343xHrVb80AblrMteD7pHssD7GdC?=
 =?us-ascii?Q?Hvj7s3pi/TpSnsvCzMZ4u6s8d3wZKdlXqNi2cJL3RRpT0eiToby3So90DXl/?=
 =?us-ascii?Q?qmFYCumWz5U7wUOOoCzR2OOI9h0C/IvuMpOdNg4YjGU7rlu4I+ROIEAwJiL2?=
 =?us-ascii?Q?XuBwat4UhB+QjQHblJcl++kc7Rhjfdhebk1xjth362Eld4QKZJvSYtn1Xwkd?=
 =?us-ascii?Q?R5T4Iilj6jQXlkVeJO9mQg0AtquHlRiQiiV+B+98mnG69B1VVOBRH+nR/HeW?=
 =?us-ascii?Q?/4te3P2DvDqz/EfuX+4VdLraGFC6N8PGXF2DqKNxtyVyIBVQR0a3G2x3j9NW?=
 =?us-ascii?Q?gV8D0EJj4HxCCBDWNwDbDoiVN4vvyjcRvhPtzzYobl8nEAsDp1vAWtCcYnmm?=
 =?us-ascii?Q?Jpv3Iieb+jdP/UtXQpHp2TYVyJMK+bxnPgFAXIJcGh2p5/ji5+ff9aQMemew?=
 =?us-ascii?Q?/09giFmjjV2YY0AlxmDwA/29hzNlfyAiIbbTU1fywnaDpy8n8YR2hSFq14U7?=
 =?us-ascii?Q?ZDi736GRhNYD7RHxxnLlTwqWHP8yVSzRC8F3v5irPy58KRl8WGFJcGRmKpwr?=
 =?us-ascii?Q?rKkHFtxWBsbbsl5chvcdRyK8Zwl2PRAxZ11hGQyDFauptp27KoYhKyOVBaCC?=
 =?us-ascii?Q?cTG6qZDEhSQAQcGbuO/7y4s1cf/65VVHBM/vlTGhafSEzKywMbcal9EnwWfp?=
 =?us-ascii?Q?ttieCrCFjx5s+nqcuqrRwhK2WTYZP1/4rmDGSGIekVagUge3/wX3IMuphGzX?=
 =?us-ascii?Q?tGDFpOemIw2Qvz3fB0wJgvk+wIK56x1cbqEz8IzC2OkT74ENKvVrqTXWD+IA?=
 =?us-ascii?Q?76v5boL3qXIekN9T/vTcgcsWjGx8WK62HglA3sFv1u6DpOY7Pnpk5M5cK8ZJ?=
 =?us-ascii?Q?S/1kntfHzb+ptGI64VdDfI51cPnXx7q2TSBi06+W5IFtphiLxgtKf7Z8HMii?=
 =?us-ascii?Q?lGxKLgcKG8+uGHm7Q9Ag+3jyHW9yKamTnK5M9BY8HbHc4Jm8phlnuELjE1hj?=
 =?us-ascii?Q?z3sPtoAUR+Ko6euEwuh2fmq7xJB85Mdn1jgGcv4J9We6fWVmGestGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8/xuNfCGMMvPvaLbSA5N5g7EhIVtaHNSFlsOL1k3TwwXlmIUEbn5v1tkbpT?=
 =?us-ascii?Q?1Z1TUwMXdEbbeL6qNe5MvwzMImliCs0NluU6FjktAW38pwAJL97cBK4Vjwjv?=
 =?us-ascii?Q?qw+MdemqYxN4Gf/x7iDmcey1VlPkIACvG6abmebcxecsxsG5bfg+G5kqswdR?=
 =?us-ascii?Q?dAVIJoUktjVEaP92p2mhpNfUm8BYjrdoTQAHPvMGDA+RjKKZYZjBDypP1Wf/?=
 =?us-ascii?Q?5O4ejW7Oa6MFyYeHdu/gvF9k0bbBXwBuly0bX9S2DAH6eM9PDbA6+lC3HkBY?=
 =?us-ascii?Q?E3FvY+WN3Uf+m35O/z3orIpgY+9DOPh37DOs5fgqGpuZ6eOtqFBOh2SHQDIn?=
 =?us-ascii?Q?DmZ+vwdM22Emu0hOcG8Ub+jXQbQ+DzWOAsxswK5kfCcwwNg8fBrM1PwJH4uV?=
 =?us-ascii?Q?ZEy1VMKVZf2n6fnLVQL9icqyCMvswWRfQDtvtozLf/fOAq84FqBSpnyXCaCw?=
 =?us-ascii?Q?VMsQdGJ/1IodCiyUsbTVM6OuPMSjV7WtjD5xjPW9+kCYl6wglBJO/usR0ovC?=
 =?us-ascii?Q?ihBEI5Cfo/fCo+lstfioCyST9HhAC+qJ/z+R/1CGPLUBEvN49bUUwBjfBhOw?=
 =?us-ascii?Q?RRlq/EB6WtDvFy7Hxo7N32FWM+ErliEZopQBWMRoYEdCaYlTE8GV559HnsjF?=
 =?us-ascii?Q?qhPnYJ6SxnpbEKltzG0/7v7kcLqMswD2QJQGEgKyGMM3kdoWdrHhOiu9nfHW?=
 =?us-ascii?Q?gMd89VdD7s4t2Um06qGrmhtvEolLIcQt0YAI9zyiskh22dbWoU5Lbsna7R3O?=
 =?us-ascii?Q?8q2s/Rq0OaXEQ20jStPnApi4o75umcQwc7SvGuoVJ7wLdKttooUZ8/lcpvk8?=
 =?us-ascii?Q?71ELpcBTm/tvgUmX1EwLIjyvWq56IYRvBlmPn9RMHg3T03z8YCnJcvO0HfKV?=
 =?us-ascii?Q?axkY0BcbnweHKofFXtnwc+DJhEv/Qgn5wdftyNjbZjCJBr2X8roP6oNQJ2gU?=
 =?us-ascii?Q?m38ysbhDO5qzGfxjMwgKNaLgNzMVSb/kpDPB3/HRabMESzma3u9jnfUrpwye?=
 =?us-ascii?Q?3RyJQr7l2xzCAR4ipWy8oVTQnvH56yKjMBod+phahMpbe9xENPWP6cpapiKc?=
 =?us-ascii?Q?DE/4R0i5guT0qxq0xjIFPGuRzu0hU17FgMzJOypxccUJg/YhaNwnUIfrGIWi?=
 =?us-ascii?Q?3m5jfAYeYs6Q8pJbwDXWcdwiZcK5egsm71SaQD2/qfWavcpAmVFibdCIgb5Y?=
 =?us-ascii?Q?00sbx6L2JsW8B0Peoe064VaTugdZTHu5PR+9SiSvI8KDC405OM7g/RsETjIi?=
 =?us-ascii?Q?SKho3iwcOuOz+0/5J7C4z+bbLSnngkJsQIo2TCYdwALVQlOua/YCeUWLhgU+?=
 =?us-ascii?Q?tb3Vk/dmZ4D34I6MT31yO7z7gJBQCDF9B8TUQ7x0XeWdtQqYJpVVOS6NO4/W?=
 =?us-ascii?Q?9FXIbr5syszLN+T8lICtRKkYxQkyA/cTv4gI5bLcUaqFWoc4XyGCnuCHaEDM?=
 =?us-ascii?Q?cC5x8JY1GzJ0SQa39jzHAe3nywDilakrR4tiKqlF/zBMSfjikrEucX48mw47?=
 =?us-ascii?Q?lbKQRKIcSKCs8k3dL3ctNUYu1aQpEzmee/d+uD/o5XsDRqORRoSpGCTmIDHI?=
 =?us-ascii?Q?7fiUaLon8SKx92GiPjvwF1Ha6R4r12b0o7Wy9TgE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cc6be2-e851-453b-5582-08ddcf0b7ec7
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:50:43.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06+OcTlaVUAH+CI8V0BL2bzOhTF3jvrfXCNxfqOisLrLSA4hTAmpA4t39+Tfu/wncSN0WTBAFMI/PN0jocZynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFF77CB3BA9

Set the TASK_FREEZABLE flag when the kjournald2 kernel thread sleeps
during journal commit operations. This prevents premature wakeups
during system suspend/resume cycles, avoiding unnecessary CPU wakeups
and power consumption.

in this case, the original code:

	prepare_to_wait(&journal->j_wait_commit, &wait,
               	 TASK_INTERRUPTIBLE);
	if (journal->j_commit_sequence != journal->j_commit_request)
        	should_sleep = 0;

	transaction = journal->j_running_transaction;
	if (transaction && time_after_eq(jiffies, transaction->t_expires))
        	should_sleep = 0;
	......
	......
	if (should_sleep) {
        	write_unlock(&journal->j_state_lock);
        	schedule();
        	write_lock(&journal->j_state_lock);
	}

is functionally equivalent to the more concise:

	write_unlock(&journal->j_state_lock);
	wait_event_freezable_exclusive(&journal->j_wait_commit,
        	journal->j_commit_sequence == journal->j_commit_request ||
        	(journal->j_running_transaction &&
         	time_after_eq(jiffies, transaction->t_expires)) ||
        	(journal->j_flags & JBD2_UNMOUNT));
	write_lock(&journal->j_state_lock);

Signed-off-by: Dai Junbing <daijunbing@vivo.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..9a1def9f730b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -222,7 +222,7 @@ static int kjournald2(void *arg)
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(&journal->j_wait_commit, &wait,
-				TASK_INTERRUPTIBLE);
+				TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		transaction = journal->j_running_transaction;
 		if (transaction == NULL ||
 		    time_before(jiffies, transaction->t_expires)) {
-- 
2.25.1


