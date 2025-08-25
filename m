Return-Path: <linux-fsdevel+bounces-58960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8FB337ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5059616B35D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EA296BD0;
	Mon, 25 Aug 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E+piKSZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013026.outbound.protection.outlook.com [40.107.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B327FD5A;
	Mon, 25 Aug 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107383; cv=fail; b=Rx7kQV8oeoQeUk9PrTKQt0lpQHZSHabkhrKvs9cC1AITbFTfWzuwbT9BP6MJVOCwPKkLDY/8jhOAre1+rRjYHPP92hj1cBUzw1GxqQvR2BQocvPK4331eUzDd4bw+1XTxyw/3Xw66UU41AjSbkKvCOl9BcTWD7tTC5Pusc5xHis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107383; c=relaxed/simple;
	bh=B0PW8uUh5gI9GiOQjft3MWHcpiYARa5z/BdECAw1qWk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oZjKNAsngvasNGy8OI4Yg4R4h9JVkB1nrRpfZfwVAujD6U1l2qT1aNVBWI0kuEPI+ve8jA4Lw/3iWErJgmgxVIT6zq8xbJsaP4L7bZYEFmQyd//l2842ipqMo1ZshYp4oBpgLVr0GDnTOVZGF0QFdPB1ENPsku9CZlAit2XRg+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E+piKSZN; arc=fail smtp.client-ip=40.107.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3XZXMxgmqlfNnoZI4FyzrGWszxeBlN1p4zT68qA9sDSsMCxb4ZFglWzvxSBa0mWyEvaMdxL/bCOSzjbjNfs4cupFI00LYhxfj87O7JxAbW1U88OtFYF6HvK9Bumr3w35wHklj+z+dEVT5ThRkJY7nmR7L3D+1XXnR933K/g/HvM0NrAQr2uRkfgodhWkOWXqTTFDQUHSL7QFAoDZEFodW/rqf8yXOUG56q36689Dg5WRLc0CEuvnvW5+F7LyPshbjbVaL51Rn0/37iGDdsWR8ioaigMtvaQ/20rL9mqRdwrdCF19fFOxekqeldWH/g5i+hh+GVyInCUcGywLNU8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnNB3ovm+vT0otKaeA0KDgXPs2nV8zGo+Mbj1WP2628=;
 b=A5HyPJOfY3IrPjDZuRYuL4l9cN2/2AMld3OI2ag6VL2SzrmxftOY664a4XGt8A/j99O4qM1ROcg8xpxRYhSAEzFzXNUhr6xSA7mXyF7JXvfoDQ66CEwyxyTuWXtgqvCfNDIpoZnPnGCq2hJPUJB4xFohYilanMq3OxRIxiANDrjXmqjgZtBM7xQ3gX0ZSd7aQflcDZAT9wOD749D5Slrehmt3W5rI4KEbo0QwJOPoExZULiLKXjRgHeDrt/eVy5auMOIe7FxQytdURRg+qu2mVUtPbEHYW62UujhuoqG0UH8WsJr4abQNAz6y8UtwxlDWaQEq+Y5yexgd/c17abkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnNB3ovm+vT0otKaeA0KDgXPs2nV8zGo+Mbj1WP2628=;
 b=E+piKSZNvljW/uI0OPSBwajRcBOA/gvKMeLa6SssirGlecDvfGHofiZgiNUhq+QhY5cJxZPdk13PJbYh0B3Zqelic9y6JztH3yAtD1dsJ+/6HHF8Nb9zCbe9Bli6h/O9ffZOEbpnnFIn1c1YTNdALCLhtJw60+IGCi485PxJ7hEt9gMTPnZSIGCkbuLX3S3gn65aWCRx+CNDiqqm7Z+Q/uJ90I52c6+30ebHBN5yaBhAmgWaoGBKxUHiSXmM+9V5cO1q0t3qjRjHJC+thw3iUx5I1iINRah6sZZWZ6G3HuMdI8cW1bgf0ZGpt11TFDaXMOVxnE5XLciLXoDxpw5vzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6348.apcprd06.prod.outlook.com (2603:1096:820:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 07:36:18 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 07:36:17 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] exec: Fix incorrect type for ret
Date: Mon, 25 Aug 2025 15:36:09 +0800
Message-Id: <20250825073609.219855-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: db7ec515-72fe-4f1f-2025-08dde3aa1410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zk3dJYuk+YXgqLSHGB7gyafu7jy26qiai+VsDFoTIPPCJMkJiYvT4qa0hNHI?=
 =?us-ascii?Q?DW32chAqUHshcnzxvN87HSOfhaeeMunf9+2w4QqzsvlT2zDgxwvinmvu3H+t?=
 =?us-ascii?Q?YDd7QksB8TrWjMweQd3mEXoubVVQozTPmf1+byZCLYInGD09XtZOFHCMzOWg?=
 =?us-ascii?Q?4aCeEYZ0iRuqrVzuaxUzAhXWWQ41I6ceA4aiKnNd7AArzOJi6zDu1OCisNYR?=
 =?us-ascii?Q?Dr1ldt08AiI80FHQi8KWfkdw0e3aWC2VziSaeOlG7/FiUalAk3vYyE7OXVvX?=
 =?us-ascii?Q?GoD9CYdUP4TRJuB2IBcKIwwJKCWvj0YmuCBN57tabNI0u/N8c8S38uWFq2zH?=
 =?us-ascii?Q?MlmD6hCJL1TeS7mdthVPpSmuZ3t4UkuMpJBi9c8tBStxTb5eMd08YnQzhSD9?=
 =?us-ascii?Q?gknF1YDYYTQG1Tgc8H572XUExvqCcVo1yuH8wk/HNmxt72koO1Zy7M1tfNGv?=
 =?us-ascii?Q?i8Djv57D5yH71RO5/FQYEM9FibOG34jea84mAKhNvRO0bzSnAU+TlTtazMFx?=
 =?us-ascii?Q?2XAaRQbQOngw3rN1zL4DyYo7oMivpEqT/VbByGl0U4l3UqHB5RqIITbVPPVy?=
 =?us-ascii?Q?Fdo4X2FYLpfLwptPKgNQzd9Ya6OaRJ/Wu50MAwZXW4IOipdGhMwnrWrgDIcw?=
 =?us-ascii?Q?RfKKGnVDz4brGovoFuBqYLgI/jGtldJLS88qx2neT4uPJ2DDmjyHh7BkWj1t?=
 =?us-ascii?Q?EO9w0EeaYeZP+tepbdHt6ea2sbhDdzmpeI8ybYPZD3vTblHsT+wgt9XzSHxu?=
 =?us-ascii?Q?OMnlwYMto6JmICeNsprFCFjk9fi+noiFdFZ+CjqXCzFHwKnqljRCPBAEqayO?=
 =?us-ascii?Q?0gevbGMf71zuTigNMSYNjCzTnfD0qOXY6+c6rONl+is0mYEh8NFSZOpsOh9C?=
 =?us-ascii?Q?A8LnrLzcFJ1WkUop4QK++Agivlg8oFr8zLxZ6HYOGuJEVTUKzpHAPTGDuheO?=
 =?us-ascii?Q?qllRlcFCsXyfnssEPZ5hB0IxU8JxXOS6ik7cNdpwDmzyf3grElHvq8fYah5w?=
 =?us-ascii?Q?TaP/MpJDwtnfNbh6Z0e6ACydpAYXv5ttuE9myL2ymJS3hPM/1WXH3jSq1NRB?=
 =?us-ascii?Q?vLB3e7CG0JXY2NjnaTKx19uyL6ailHP3gD61rzk7VJRNE/RPt/S42ouKgGr6?=
 =?us-ascii?Q?+hXBIQcoTqguPT5tyNm91bjNVhcaMCxWuKagNZlPUTk52jTuwSzB5KqlHjsA?=
 =?us-ascii?Q?U6ERJF6YEGEFxkkBqMkfN1dGfsC2CJwUPsEOoWHm29Lv9cnGqesUN0lYd8OH?=
 =?us-ascii?Q?2XpxMhEwBLAvXiY3a2aRdd0GxBBVszPiFd2VZP6QwFw6p/pGmrXqnjaXLxUh?=
 =?us-ascii?Q?GKZJ1xe4eMo9MQpLOXD1g0+/zmm+3n65ixG7jU0fKC755LzDfvG59VgfNqEB?=
 =?us-ascii?Q?6ov6f78v6n8Yubc08FNSvUMMUpljXCa/6gn417+47SVHBnKOEpQ4LmB3nqEd?=
 =?us-ascii?Q?Z/Z2zkyB8/ATvyCgNjo2SIrtuHwQix+ZeouxK0O6yXqfNE1f4m4i7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cu7Z+aQvou1vx9wp6p2gmOLnVjLVmAhD8ze8jXdZYZV/1kXMMgd5M1k+X7e9?=
 =?us-ascii?Q?hCq0HvKf01ZWAX+Wo6WW2FxQzai2US5VfotiH0firUgT4YYrcyoRkp+d/D53?=
 =?us-ascii?Q?cscw0XAGFqJTlqx5jZJfwhwAlrDi1KA2Dk+msAHPZW+DvGQukjzb0pfiCYdu?=
 =?us-ascii?Q?zuK4e5c6zhUQIgeROSYYt4J+xO/ofjjtYW8R28t4av/dYILbjrfjyerfZ4ww?=
 =?us-ascii?Q?/7KGJhoWcePbdRDfnkNdwkQuCXtubtW3bw7tgH/qnEOQTlDxnitHM3qRvSD0?=
 =?us-ascii?Q?E2+f2NLIWOQLqOS+ccRNQMPzjjQykS40oZWI/aRr1bFbv5T371SSwZI2Py44?=
 =?us-ascii?Q?U3EWvtSqj5HqZgdTPW7lDYM3p7nP1VI7Ut1P1Ol7wxNfBX/saKAaM/XnUWIX?=
 =?us-ascii?Q?KEWEDr0k+h8g9CP0XDZjHAuyakYrFmfeJt2T7mGkLZ/0dB7Ds4xwp4kbWD5C?=
 =?us-ascii?Q?D3WbmFTOSPnNFia36JU877B/soAaak4Tir9C2IZo31p/pZdEI/S59VjFDISb?=
 =?us-ascii?Q?7FhjSzyR6wJ68VNQuU6fagGOiOnwo7uavIVCNoTGkHHgI8pdiIjXajPfHZ2i?=
 =?us-ascii?Q?zXutnrKSHomhUZDhXtXVET65X+rTDZFCOJE2SZ3LuHPZWLC4yO3SzSdXdfTJ?=
 =?us-ascii?Q?I2bx1Rhglwz4t9+isRYVKn3u29TABe2JnPNQNiBXybAFiVGi9A/CDbe+itOL?=
 =?us-ascii?Q?6PfOO7AzfuL78+cRp+oxzEzfkgYoTTeRzYiiKg3ZacuU5lOsEXXQ4woe6oDJ?=
 =?us-ascii?Q?cI+3MiPEfjgwsJm4/sF/tOX5F21jzLFtu3n7M46Hqu2z66R1VFLgca7TBnWT?=
 =?us-ascii?Q?U+LIWbfekPEXZX3hovEigloLGmQPvY0y/e/EDWDrucpsNU7TaUYZTjqMegar?=
 =?us-ascii?Q?uTlektEFxOO8qI4hQSWgOOKh5wxthQkeaJLHyLrZDNMaNAT82BH8hlv2b5CU?=
 =?us-ascii?Q?hx+cQwrY9xdt3vURcHKzZtYkNi0zSiqKiKWN6bgZQFfHUKy4g6ZXIFhxeqmU?=
 =?us-ascii?Q?/Itt0DTV47NiOd2fb2TMfOJrvv61xV4gES2pl0FuRkGECFLVFfoMlEaKBL+R?=
 =?us-ascii?Q?dvaAe7zNyqWrXNlPq9r6FXLNqcBFFe9vwZck0dInFS9rmK1Ff7fEmFGJT7Je?=
 =?us-ascii?Q?rHEXrDsK4W9kE+yUbTTzmL2348ahu+wj1PYWwnQNbWXRIlzXmtikSfJ89QAb?=
 =?us-ascii?Q?S94RXuoxatIZTeADS87lMjGLldro0fE/22t/qTi5s9BMpTe8KgCJmORVfIMI?=
 =?us-ascii?Q?0OhLoyRkyM5ezj0WneufGLQ1+J4GbeTkt0svThzP2l9WFKa+ta5zSdEB1AEd?=
 =?us-ascii?Q?MNtwB3is4BTV2y4Y7QEd+XGvA1LGcSnBJ1nWiW9Ie2JxtbOZxNWFqncOw79T?=
 =?us-ascii?Q?FXM16yb5r40JVDo9BAailb06d+pnNRylSf79vb6Mi2v8sr8LRy04hpD2WrK2?=
 =?us-ascii?Q?EyDpIYOVXL1N/VSc/7VIYtpWGOfbxGCUOYhN/POyynisiH2tNQqyjZHBpS/P?=
 =?us-ascii?Q?8cSxzC5P/aE1zWByxwjhKCsWdxqT93l8RDa7YIwOQTN0L2wRXot4lAlWgE4F?=
 =?us-ascii?Q?+fC0l7xFhf7PczSjMUXrDAFt2qhdSREgQh4jynPz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7ec515-72fe-4f1f-2025-08dde3aa1410
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:36:17.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfFiRNBR+bTn4qEDSpITeaky9kYK4yfmZcZcnTHN0KSOa2fxwgwa7CZLmSDhdCZ3i0f9gzvR+N1Pv3OZK17/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6348

In the setup_arg_pages(), ret is declared as an unsigned long.
The ret might take a negative value. Therefore, its type should
be changed to int.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..5d236bb87df5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-- 
2.34.1


