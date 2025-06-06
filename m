Return-Path: <linux-fsdevel+bounces-50829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512ABACFFDF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679137A905A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CB286897;
	Fri,  6 Jun 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AdKi0Snm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021076.outbound.protection.outlook.com [52.101.70.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AB286413;
	Fri,  6 Jun 2025 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203899; cv=fail; b=tbdwuOXGZmzEcndDs6suOT0qEPNoqFnU78VQhVTFQirEwdXULFCLc5GBqezM7QbtidOFEVO5wY5m4rj2IkSx1n84Y0LxE7OjKtYMFzIK6RHISR2KEzOWsQb27HWKfsuiNT04tbzZtkfH6I61FLzFAyVdYnUCjPhZA3eQ2+vjT2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203899; c=relaxed/simple;
	bh=qDb2MGKSvSYXXLxiDkPGpRwC65+yg9scm4Y37SfROk4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gsEuZ/fHVU26ejonRg7YdR4EF13HNyKLym7nuT5YJ2VMkDmR2xN/hU1gHmj1izdeHGCkSCq8Dm7eK62vPzx9BZYG1tch7Up1t36ElHb/Da1lzl196OHcweurM3zkMnidIKlKDriGv9s9/f/PvWSZ5vvkTkz7QcCe4LGGaFC/Zos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=AdKi0Snm; arc=fail smtp.client-ip=52.101.70.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltoTw8GgFmcacOcZos7HWbz9/CodP8HNDsRtCqYS0zJgF2fgh49iHJpKyQve+xTSZUFeYqnX0JtQfvQNDEg7/oFxKTHM3T0lwPAeiJjdjH6rwwOgCDhvmff6sOnDzE1GzHum9nEXCCsyGca3epS6G1se26DUevvvRrcLZI1H5/cN7Plhbi6W+bU7gilmV8QoZEznDovZxxUpX03eDWakBrOz6T6Tkoj/xtzOP3MGK54OykDWs+ZkNttvKiBfvgrzMKBkFhy59wRIlaW7DvCl22h1BDnILD02R0/Ni55msGFh6XUGhajJwwEua/HSNpQ8Pb+u1BwqDh25DTItRd6nDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rle1vBZQPEBuU/UoIH8UpN6TYaXrieKpMFiH+Ow3nhU=;
 b=MmFoywnjevbn6CarYhbifkFPY0TTUodS8NRxDS4l/KYDXEvQ3wWqdZ2y0xjIAjqI4LD3V9uKdmCJSzLVcrDfQ8VtqR/Pde5XFsU71X1DoYJdZgJLBlLglB61tx99Q0890cm2/TzrQvxuAIen9m8qHUqKSla/iX5tGle3ZeBZaYiKZzv9C5Jvz4F9QgT1s0UJfosAlP+fOMLcq8qillcjQ8gs/yB7g2uG1l4NFE+k1zrZUCRm0UwRWQtn+XtW2VN0EsZYQdHnyjQE9+Cgj3jDq4HATc7/FxQgUBMP8nV9rumarQnnrC2QC2w9tRuLda5jVfykcXxdptCZVfEOEoCeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rle1vBZQPEBuU/UoIH8UpN6TYaXrieKpMFiH+Ow3nhU=;
 b=AdKi0SnmUs/VSBtJRZhOu/pGbOfWGGtf3La5V/9KL0akzvSaIXogcFtIGLJTKtcfUqt3rhW7ogegkzOSVCZTsE51T071EP539McVl36qzszVS3iHosyjpWT3Jmlko8JZkaRauheffDiB7pAv3gP902PRl1JS0SWsRcZpqCcdWVpRkugEtCtLHt+wNocInpl1BkBZ5bGvlvxLM7SS2jwJ61hrislHit6d/hmbMsCHMX/Eq0BQFp7PXhMipujFU1V8+fq7+eNMmdl9Seiyt8TcILAJlOKhK9+aZZlZ1M5syFT5chtcLPRWFr+bcV1lzgG3ynxGsE9+Xk8x/tYPsAr+KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DB8PR08MB5369.eurprd08.prod.outlook.com (2603:10a6:10:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 09:58:12 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 09:58:12 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel@openvz.org
Subject: [PATCH] locking: detect spin_lock_irq() call with disabled interrupts
Date: Fri,  6 Jun 2025 17:57:23 +0800
Message-ID: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::13) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DB8PR08MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b698bf-c988-4fc6-b3c1-08dda4e0a5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|52116014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N21KQR0y5I53ZvU0IhccFGLaGJXqK7sdwSAvkBZjZU9xTQFLOkqBqvc4Af9T?=
 =?us-ascii?Q?aIvJN2bwhXUqg3k3NvwV8jgJNyvpNmAkjWGYRdoKER0A7ahE7Qp6ns3QY+PJ?=
 =?us-ascii?Q?zbqDHFSy+1LlGa6SY788fR4PyS+e1ZG2h3D88NQnJ5zpRGxFZ2qT/xN+S6Ex?=
 =?us-ascii?Q?ak/n/mCJobZi1/XGGjQNkxaSag+SaB/CGuGf3En7drwZT5yVIDOmJxZGrhDQ?=
 =?us-ascii?Q?IcgQ1Y8pLmZUAt0rvlZNUsCIRHFdsJ88QMt2Xek0jHFy6Zr30yen+LhPR9du?=
 =?us-ascii?Q?Lorul5H+TDs3aVcgkqhSU06xtOBOebcFk+9/F/3Yw85uOHy8206Ay1Khkgyi?=
 =?us-ascii?Q?fWIeSFu+q+BMXbNDNP5kb73xT2U5o1ZsVoldLZm7MHzq2sprPnRYnJS7QxHP?=
 =?us-ascii?Q?jlK8uZOSzA+qFlGULORF2PqHfsNp7CRFVaQyKGUDkAHzvmBqC2vsRoRMaWzV?=
 =?us-ascii?Q?jE6LPlRmOyO7rJZiRrBMY1oLEAiRKM9/Hbvw89u+vCBWq/ASYFLf4YiCeH0y?=
 =?us-ascii?Q?E8nZizYQVjdH1lebP9ANkTW25Ggb2fF6ULw7SQ3/qZep1peL9LMOI+1baqn3?=
 =?us-ascii?Q?trNlDdePJoXYkmeFkBRYfGoWi+Y59O2oQB4qiGUOcxPNnqyzRWDck+d9rnWK?=
 =?us-ascii?Q?eT0eswioZbqdZvtxT4WJS1quc9+raJr6QrwoOBKUzQoRmEKzjHdU/wQwmDwI?=
 =?us-ascii?Q?0NwyTyAk89VpLfDrLsPLxMwQz8VohZ0grAbgj/TMeAr6jDgP0V+aIppQPV/e?=
 =?us-ascii?Q?t7SzdHRCHxVeaCV+oHQAqaXuoVr1f2utuwAR8rBZQ1TeMCrrzv0YhgV476SP?=
 =?us-ascii?Q?3GqjkrMOr0cwr4XFO6bIbqGwib7bkbNEafeGc9Exbc9GmgBBhCA51DuQTJIj?=
 =?us-ascii?Q?CYXTzZWzMjfjFgpkGBcBN073Q55k0BL1ExnJc3V8Zd9efEQkXvoj/u+ziBL/?=
 =?us-ascii?Q?/xHuF9bVkZCoG3k8XjLnIN5wXHdPX6IC9r2eTCSzW20wsHmfyUtTricvnA2P?=
 =?us-ascii?Q?PpZB2bLxXo/BFSFTNhwVTCSE+UxUASNIslKR+T0ib+Q/4JJ/i+JQu/t8YW6t?=
 =?us-ascii?Q?fjanZwBbSjIsRFdqUvJQeoZe9fZQxrCkpUes4mfCjmAlIe8fIPyUMmEq2Iom?=
 =?us-ascii?Q?qePQ1F01p3DQkV7dve9/nzzUI4EUoT83nzAzAkt4RgEHykwyh8IQfqXdhSN7?=
 =?us-ascii?Q?MYVBW37L5AXu0WOXspj4o4pb42b3tvJO9azrLKy+wjuuUXlN/OIhoj//XNBt?=
 =?us-ascii?Q?fAPXO+7ls1ZdvjZRxvgluaSOYS5arxfre6c2wsS/zmRR9o1Vg4pbiIU6v5ZI?=
 =?us-ascii?Q?I9A6VMRPXOUTOo5hI0v6i+fbUFccsV+x/LksPF253Hbd87iFiJts+pQ7DSAJ?=
 =?us-ascii?Q?XFbp/2U4DHJAJn2g0/lGvqI4G+xUsDXe14rSLXj7IGWmzmRUu1+VuA3Ay5eu?=
 =?us-ascii?Q?UneRLJfcAPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(52116014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89gTbvyS9ULCWwPoWcfd4NmkrkBQSoCbhybraKfuHRKHoQBScdWd/mqDLHGs?=
 =?us-ascii?Q?Xh5DsPTf6HpNurFgpApnv8phBzNl4I0gdIOR2wmFQYXKFKAIyAExm4lcmHxW?=
 =?us-ascii?Q?F4bKctlB5ZYRSQAkzcm3bghRA4/MT5JfTmQn4UhBrkaGVpraomXJSALgvvVn?=
 =?us-ascii?Q?spadU80DcBkn27ajadNwiK10vPhcVBg1auo/Hm4GQhBuPwatFuipYvlARrVL?=
 =?us-ascii?Q?a2zTNKonMRHLf99MdCRTwvHSB10UgD6JdbMC8MWUG/9O0jVeX17fiBtRpUPI?=
 =?us-ascii?Q?PjNiIMKLFUruw7ZE0+m+iQP7y8EM9GphsdgDN4PIrGWItRInNnGjuBaWqOmy?=
 =?us-ascii?Q?hBYpZow39iGDaaw1O/FGLNizXXMiLJpgu0ImuOZXxruepk27rnkY94wxsZmy?=
 =?us-ascii?Q?Akhgy7iBMuR1COR2gP3GoNksxKdknZ6zqF085pYUvz3gV+OATM9vPjjyJIJY?=
 =?us-ascii?Q?wmhenNS5pAUNhoHEhL13d8uWTiwr3NcaXsuDH/sGmwTmR6j598W+iFNJCQad?=
 =?us-ascii?Q?Q/dY6MukrAHUslfX4QJGLsC17GmZFa/y8rZ1+kVzPy1vsHuqFvYSeuHDr3KL?=
 =?us-ascii?Q?aJiOA2gPtaBmDC3YRRVKciMk0BmjaQJ2x61oNUYOWMYao6HTlwCI4HwspxHr?=
 =?us-ascii?Q?NYJGvWhEji/KoBDoi+6bZPjz8qR37Ubfp8DqL2haH48X8MzSxnRZOGLWjMmP?=
 =?us-ascii?Q?qdAXGacdpYLJeWs1ioWWfg+WBnYKSpmk8N+phBwQkB0/UfwoxH2eMGexHYOy?=
 =?us-ascii?Q?9asE6cnV/XeNRnzWzyYjOq06mH7iOnhrBrqKT4MqZBTfKNd2W1/o0blJ9ZDJ?=
 =?us-ascii?Q?bbAyHOObeyBlF4WGaH8DYHGIdV34nuTDp2mea8ir1WLGDqbNDoOyHDvMAGi+?=
 =?us-ascii?Q?9LahxvhUINm/fg1oFJd/FFhCpyOLqHevQJUiLQoN2LzcCnH9mWtJAfXCHS+R?=
 =?us-ascii?Q?jjXFJ4LEKOgqVIbha/91vgbhnnego3pDBcy2cKPiNqKOmGBZLjH/NfvemrPd?=
 =?us-ascii?Q?sQUo2SreEQ5Pd3vMebXqr8kvQgbwW+eYPBBgaY4fjalvHN9P7OGTMXZCxqBX?=
 =?us-ascii?Q?sYlaOVaLTEV2z5/xiQourOaUVH6iVIETQejhUgIPT9/choephWkWSRumk6TW?=
 =?us-ascii?Q?U6t5gLJ/nCiw6ZYR6qHLjSahprYKiYE3lvcSNsoyoxU1zHalI0qmzMgMKCzF?=
 =?us-ascii?Q?9+LFM7xMgU3cxw5YCX/JBECiX7/72mzL/LkXZRj1GSdkGAK4TSyU3ZYwZ8sD?=
 =?us-ascii?Q?vrFmdwtfGEYm+Istf8PVKwq7Jo/viIpSJkE7VKZG0NLpsoLUx1dUTKdBsngQ?=
 =?us-ascii?Q?ePLgm7ZEdXjcxayb8U7YATaspHB/eOYhsIXkCtZu/5QoGQCF5r8l5/rCd8jc?=
 =?us-ascii?Q?lXhctTuJGd66f0vHGvQp7/JeuA1zzpUHQmUWnsb3VQZE7Nr+evYwLH2na5wZ?=
 =?us-ascii?Q?+LSTk1Y+gNZIAiw/zv9abClAl6MREA2hyXk77775hprX9kJJNzfVDuBDb9S6?=
 =?us-ascii?Q?nzoRhKW4fYQxzQiuN9lbs7i+gFQlIh9L7nrEwVb+OMkFpa0Mobw1M4lPGkCf?=
 =?us-ascii?Q?kowiVvOA3vrNdIDO9rXaua3W2/EI8gMACvIxn4jZsWBBmTPIyht9A17W7nly?=
 =?us-ascii?Q?7ae7KKMJ6JidMrPbl+tJ2OklfPbJ250+L4Wh1jNniHfEcE7Fbc01s9MniBvE?=
 =?us-ascii?Q?3zU78g=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b698bf-c988-4fc6-b3c1-08dda4e0a5b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:58:11.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMrmOIuuwZCduQ/oR47hB9HGJT0aLX61mCEWwjeishCAtppG8IJS0zLRas3HeJ9384gHvi0/vqNdK/sA+mD3kLJHWMuVMxSi9zi/c7hVxxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5369

This is intended to easily detect irq spinlock self-deadlocks like:

  spin_lock_irq(A);
  spin_lock_irq(B);
  spin_unlock_irq(B);
    IRQ {
      spin_lock(A); <- deadlocks
      spin_unlock(A);
    }
  spin_unlock_irq(A);

Recently we saw this kind of deadlock on our partner's node:

PID: 408      TASK: ffff8eee0870ca00  CPU: 36   COMMAND: "kworker/36:1H"
 #0 [fffffe3861831e60] crash_nmi_callback at ffffffff97269e31
 #1 [fffffe3861831e68] nmi_handle at ffffffff972300bb
 #2 [fffffe3861831eb0] default_do_nmi at ffffffff97e9e000
 #3 [fffffe3861831ed0] exc_nmi at ffffffff97e9e211
 #4 [fffffe3861831ef0] end_repeat_nmi at ffffffff98001639
    [exception RIP: native_queued_spin_lock_slowpath+638]
    RIP: ffffffff97eb31ae  RSP: ffffb1c8cd2a4d40  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff8f2dffb34780  RCX: 0000000000940000
    RDX: 000000000000002a  RSI: 0000000000ac0000  RDI: ffff8eaed4eb81c0
    RBP: ffff8eaed4eb81c0   R8: 0000000000000000   R9: ffff8f2dffaf3438
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000000000000024  R14: 0000000000000000  R15: ffffd1c8bfb24b80
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffffb1c8cd2a4d40] native_queued_spin_lock_slowpath at ffffffff97eb31ae
 #6 [ffffb1c8cd2a4d60] _raw_spin_lock_irqsave at ffffffff97eb2730
 #7 [ffffb1c8cd2a4d70] __wake_up at ffffffff9737c02d
 #8 [ffffb1c8cd2a4da0] sbitmap_queue_wake_up at ffffffff9786c74d
 #9 [ffffb1c8cd2a4dc8] sbitmap_queue_clear at ffffffff9786cc97
--- <IRQ stack> ---
    [exception RIP: _raw_spin_unlock_irq+20]
    RIP: ffffffff97eb2e84  RSP: ffffb1c8cd90fd18  RFLAGS: 00000283
    RAX: 0000000000000001  RBX: ffff8eafb68efb40  RCX: 0000000000000001
    RDX: 0000000000000008  RSI: 0000000000000061  RDI: ffff8eafb06c3c70
    RBP: ffff8eee7af43000   R8: ffff8eaed4eb81c8   R9: ffff8eaed4eb81c8
    R10: 0000000000000008  R11: 0000000000000008  R12: 0000000000000000
    R13: ffff8eafb06c3bd0  R14: ffff8eafb06c3bc0  R15: ffff8eaed4eb81c0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

Luckily it was already fixed in mainstream by:
commit b313a8c83551 ("block: Fix lockdep warning in blk_mq_mark_tag_wait")

Currently if we are unlucky we may miss such a deadlock on our testing
system as it is racy and it depends on the specific interrupt handler
appearing at the right place and at the right time. So this patch tries
to detect the problem despite the absence of the interrupt.

If we see spin_lock_irq under interrupts already disabled we can assume
that it has paired spin_unlock_irq which would reenable interrupts where
they should not be reenabled. So we report a warning for it.

Same thing on spin_unlock_irq even if we were lucky and there was no
deadlock let's report if interrupts were enabled.

Let's make this functionality catch one problem and then be disabled, to
prevent from spamming kernel log with warnings. Also let's add sysctl
kernel.debug_spin_lock_irq_with_disabled_interrupts to reenable it if
needed. Also let's add a by default enabled configuration option
DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT, in case we will
need this on boot.

Yes Lockdep can detect that, if it sees both the interrupt stack and the
regular stack where we can get into interrupt with spinlock held. But
with this approach we can detect the problem even without ever getting
into interrupt stack. And also this functionality seems to be more
lightweight then Lockdep as it does not need to maintain lock dependency
graph.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

--
Tested with https://github.com/Snorch/spinlock-irq-test-module.
---
 include/linux/spinlock.h  | 21 +++++++++++++++++++++
 kernel/locking/spinlock.c |  6 ++++++
 kernel/sysctl.c           |  9 +++++++++
 lib/Kconfig.debug         | 12 ++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e..b8ebccaa5062 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -371,8 +371,21 @@ do {									\
 	raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock);	\
 } while (0)
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
+			 debug_spin_lock_irq_with_disabled_interrupts);
+#endif
+
 static __always_inline void spin_lock_irq(spinlock_t *lock)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
+		if (raw_irqs_disabled()) {
+			static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
+			WARN(1, "spin_lock_irq() called with irqs disabled!\n");
+		}
+	}
+#endif
 	raw_spin_lock_irq(&lock->rlock);
 }
 
@@ -398,6 +411,14 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
 
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
+		if (!raw_irqs_disabled()) {
+			static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
+			WARN(1, "spin_unlock_irq() called with irqs enabled!\n");
+		}
+	}
+#endif
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7685defd7c52..6ec4a788f53c 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -22,6 +22,12 @@
 #include <linux/debug_locks.h>
 #include <linux/export.h>
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
+			debug_spin_lock_irq_with_disabled_interrupts);
+EXPORT_SYMBOL(debug_spin_lock_irq_with_disabled_interrupts);
+#endif
+
 #ifdef CONFIG_MMIOWB
 #ifndef arch_mmiowb_state
 DEFINE_PER_CPU(struct mmiowb_state, __mmiowb_state);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b4f0cff76ea..1e3cca2e3c8f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -50,6 +50,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/mount.h>
 #include <linux/pid.h>
+#include <linux/spinlock.h>
 
 #include "../lib/kstrtox.h"
 
@@ -1758,6 +1759,14 @@ static const struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	{
+		.procname	= "debug_spin_lock_irq_with_disabled_interrupts",
+		.data		= &debug_spin_lock_irq_with_disabled_interrupts,
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
+#endif
 };
 
 int __init sysctl_init_bases(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..c4834f4c9d51 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1465,6 +1465,18 @@ config DEBUG_SPINLOCK
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT
+	bool "Detect spin_(un)lock_irq() call with disabled(enabled) interrupts"
+	depends on DEBUG_SPINLOCK
+	help
+	  Say Y here to detect spin_lock_irq() and spin_unlock_irq() calls
+	  with disabled (enabled) interrupts. This helps detecting bugs
+	  where the code is not using the right locking primitives. E.g.
+	  using spin_lock_irq() twice in a row (on different locks). And thus
+	  code can reenable interrupts where they should be disabled and lead
+	  to deadlock.
+	  Say N if you are unsure.
+
 config DEBUG_MUTEXES
 	bool "Mutex debugging: basic checks"
 	depends on DEBUG_KERNEL && !PREEMPT_RT
-- 
2.49.0


