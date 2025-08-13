Return-Path: <linux-fsdevel+bounces-57685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9023B248D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D751E1892896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10142FABF6;
	Wed, 13 Aug 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UGPErZjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67A2F49E4;
	Wed, 13 Aug 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085877; cv=fail; b=qlyDA5kLv95L6U5vwi8G3DwUgV0IuBvhfx0BTWQZ/M0psvajepLDX1WC2JMafmkpAkJXLCdyRdsL/tM8PuPwBo1D4K+1a5u9WICoQgxHGPgvsro8Ck5klIYg81g4KfwuSTG9nd/dmXJL/HUit/F8sBeEsgmoV29TBgiET3+6gcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085877; c=relaxed/simple;
	bh=LlmBgLbTA+mZrJAYWNgpGSXHHzGtNSz4pbupX+p4Pzg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JUPU/1WGUQIyUO97psWY+kGohXnW5NHX6j5PlV68H1yF3dy6VeXbtN6k6kaeytChEvZKVPCKpzyO2S5LNsvGNxE6ENMC+j/ZwIXt7okrZy2cny3IfhAUdjKP2hgO8oVTrbDG3WUkGbBtjxqTvDsqQdX+G+2bFnYleLFpC3I2dAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UGPErZjh; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFaMYFQ7N9CmQxt8eCaCJlfpp86LxLzuFcxJv+E5rTHN+07Zca7eCbCCI58htsa/wEjLgzBFk+uL+m6sDjHD/KzLN46WcdngvERR8TFUTryxh9cBLi9ZGLMhpIYaAFXpxb/CZu51wiZorkOqGrp5dHeu2lxs1N3KcZrPO/9IwcvhfDxqAgHrADY5ZQRr2OKmkXHxNxLm8zDIZeCAKJaO75TDCtcAnClkOKyMpAa5vjm5cfpZ9ifolgCjzo5Z4+y737fi+FO7AaZTATZIbWNOudnPaGm5wcZja6jheZRGlnOYVzh7gFkiXBLK4jzK/3uLysB6Bs4iYoQFGzpx7zlPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXIxnLXmalRIbtxH5pDWaa0rBKxiewMWEWUDQzsrgsQ=;
 b=btFWj5IhUOYm6WHCWBKiUIXL2BU70Qw/1/gCqJTrqtyZkyezSmj7zlT9miX9Yj6lnEd7O2SJQZooA0VxuUkAdOCxLJ9qtDW5R3Wc4nQDW9ztfV7Ynv9ShHEnvasBW7nq05K4T6rI7Z+hlmrYFBRuIxUK1XwtqyS1QgkIfDi2INt8cyp4Qvysav9CUQ7RDYs5HSgzu8KVdGvmmAfj2BG6tzqhKfwjOZqQv5aq+PG5VVokz+NGKwOK98AD+5Zfo9sBOhNhqNhIfWsjko8qvvZzimV/yxXuBLRFzEW1lz2uK+6Jw7gL1jMOhIC5e3Wl8SslRV42mCi/96yALVJowUgjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXIxnLXmalRIbtxH5pDWaa0rBKxiewMWEWUDQzsrgsQ=;
 b=UGPErZjhP4wiU3u4fMKyq2W5kAQzhsyt0F+3d66J8rPtIDO5oB4Tbgv2J2yJ88pjxILVuQvy0vbySTrwwGRfyJnoy8397t1kgLJ4p5QpBpEci4rOWpIPdFZSY0m6pdVNk9vY9e+ypscMtiUZsoSU69Y5UZaQ/KmOA+3WkrU/pGJbATQuvdypDIL0pI0Jm8H/6wy8k2jHoka0gU+22fK8EsxJO0o5U3Thxjedwn+KxkyG3tdMOWl+UVxDs6sHtAV9TMMvhSFx4BJ4alSB3e+pCdsr1AZeh3GLwbIGmlJlSlYhAHbDb8VXQYfFR+fGfCyuBWMHs8vXPUOsEnOLI3JxAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SI2PR06MB5195.apcprd06.prod.outlook.com (2603:1096:4:1bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 11:51:11 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 11:51:11 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] binfmt_elf: Replace offsetof() with struct_size() in fill_note_info()
Date: Wed, 13 Aug 2025 19:50:58 +0800
Message-Id: <20250813115058.635742-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::22) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SI2PR06MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: c55d695b-46f7-45eb-3334-08ddda5fb296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Zo0IbHVcUoUHbJ/iNn+YUbWXLWy0frbrZF8UwZRyM5o9k/Kg0lWTmyLuLNL?=
 =?us-ascii?Q?Z+t1qA2QkkKwPBpVh6PyB61/9IvU1jN3nZvnoEugCYoGZmcAQiuNfnOsVTC+?=
 =?us-ascii?Q?ANPBVFnzwxUyI5tjHM35XulNA1iwwUxvr5vyXu7qf6NAWGRh7isF8jEyr6ma?=
 =?us-ascii?Q?wGqkoUJ8aYztBFK1eOwp8BhWv/D2MtICvYMIM5asMrANRLgZq6LfWrOqtpZD?=
 =?us-ascii?Q?xtaw5LwDIO1+2A6X5SIcc2JcPS6zbsZB70aqkzclG6TqjjzEtlI5B7zbqqn3?=
 =?us-ascii?Q?Ot0UVHDegxQUsLkwZ5wZsUfNauJrYozf/A+HsHLNXbyYIugn23K0bcVY7IQ1?=
 =?us-ascii?Q?jLVX+wNjgKV5laa2RoMDVFBMdfRN9BYnoFJjsmXZR6UIHwsp5+WcxLDe/oGv?=
 =?us-ascii?Q?Pmrsnkk8aAmBZYPZgMXE+7nmPiTX8NNQrJKnFkGIhyP73Baa6fVyebTlLoSJ?=
 =?us-ascii?Q?ZKabMShwfGH71aMXrr4o5YOU+s1UzACddkXIFGBQ9MER4reizhtABnod8a1x?=
 =?us-ascii?Q?w8cZGtCH0YqYKzh1ebhemEy9Req/njmEBjDV+5gzqy70oPlT1gdWWw+ilScu?=
 =?us-ascii?Q?ZohsJRkBIc9dETUt5a/TYuQnScqPdMyllutQ9xcuN+xQ8e2NQF24u/RH0IdJ?=
 =?us-ascii?Q?s1mK095+sKXFIBuJNfqE6RoCwW6nFgRxW1kQSFlk/6bd44Ny5EwjcjrIiQoT?=
 =?us-ascii?Q?4xvpqJ4f/WILmmwW+sL1fu6aFjB7Y33KPF2IG26rxHq/3Kq6GOr0e4XlsY15?=
 =?us-ascii?Q?/js+9tCNpSYeKtzKRTBt3DfMsFhxIv4SERZyba/3UPyNAqPN08Xe4KhtHyz8?=
 =?us-ascii?Q?GxWHWQdPs+qxDfRdZyBv/fw4oEfXfC228WpUgOzzQJGC26eHXaohuWoJVMIj?=
 =?us-ascii?Q?6JbuBTQQQeso3JstWUsWrNgu9j+p0qpRHz76gUpIBA2E+Tb5iQPxt6UKiVGk?=
 =?us-ascii?Q?sg3BJfGpsrbdoaDf9I+xwYHHURwmG/AWf2hSNDG+/KPBfAjaBSmSA4y3w08z?=
 =?us-ascii?Q?4G/ZP+uti+xLYOWo/ibDZ0TGfIL+vF7j/xf9QJnx1uxmagMDr48g1ggvVrwl?=
 =?us-ascii?Q?ombApp7v7MuV0r7p1KLZ/gguqhOoWBK7FfNVKqrQhFQ+qFLXzDN0ZlCXl9PF?=
 =?us-ascii?Q?gCEuqVadvFeptJQ9qf8pEvfk6ML/fMQe4op8HHDIBTq/nq9df65oi1VP0dw1?=
 =?us-ascii?Q?78qDBgC3aB7r3SGcCesvv6O/4HmW5sw6QbLRDMQEf33iR3TvbGdeR9LMHuA7?=
 =?us-ascii?Q?T93N6KsLohKpNEpRJ2wN9t1YWFFqhphUy3yzEvwcBdyEltULMaTv7xwm84Ld?=
 =?us-ascii?Q?QS1bBIhhwNi0todfLJ2RVyalMUT7bGn+EXlyZ5YCXPicC3bSyMDgyI3RGSaY?=
 =?us-ascii?Q?urjlG2FyQjduBig8y+Cm8bTJfwzyMA5NbGMp8iaUCuv0T8KfoMOXVZkzweQl?=
 =?us-ascii?Q?rSKkD6fJi72ypusF0amDlEDP1UR2eMOJ3vVfRjtgAeDrzhUt9DJBIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zu0ihQA52HzCpF5n3lr11sGmsrsNh80dATjpIbNJKJAS/1ViYtvc4Q/jaCdZ?=
 =?us-ascii?Q?IUbvNYoNXqaXZHGLNaxs4AHBbpthrBuV2lk1LYBdlIeMKrrakyuV6nBKbipX?=
 =?us-ascii?Q?kykjYyysaVL+dlKlDvjxRl7ems/ksx0FzmiE/Lh5TJhaUxDmMIo8/3huRmRy?=
 =?us-ascii?Q?c9qxVUN3UIjnL3qVo/mEX40x9SJgFVdbVhTHs4UeBePnImZvnK8CtPhPALyj?=
 =?us-ascii?Q?uFB415FO/sWUGsSJGJLzkZup41DnWS58y29Ckg6qmwOy9aNR720Nl0YejMoV?=
 =?us-ascii?Q?I+1whunmEwESRxxv1/Gf5UHYGZ99/+qOL+XV9lJPM6Djm5UhEIgxHAbjwChn?=
 =?us-ascii?Q?TY1L7sKBr7IbUruClFzvnyMsGyn1vuftP2HRQy3GW1NI16fFj9POsBDyOVbx?=
 =?us-ascii?Q?FMq1+Prxz1+6Qw7maPLl3bbWaUiKc0cNMTX9mI5Ex/SS7LcOtzsDsnfEdtrZ?=
 =?us-ascii?Q?89fQd5ILQmcq9VYRWfTe/9xPAu2o09eT2GfC2Pqi/Y4gze+ZXT+WJZNBmsYr?=
 =?us-ascii?Q?GxCn+E6/ROoKn1OdBo3TldW4iWlzxEPdaQqYySGTLKRQYFn9INqd4t2IKk62?=
 =?us-ascii?Q?4jJZLT/K+3cI9VT6nDP3tjLkQvu+f10CYAd6vJdrR1CJX3goaUXGyt/Y1W1/?=
 =?us-ascii?Q?Q6sylQXQGyVfQv/JpoeA36r/Pqw4qswdvInYoylxct0CcKKNAbie6lJ+W8l7?=
 =?us-ascii?Q?s7XJm/cDedKh2lY5QtNy997XiSM6lY67ni01+WgtOKzwryMtuGR+nNp8Ajt4?=
 =?us-ascii?Q?EGqcUE2BoznNuYhN1IiikARVaUnGySVJYFX88/YrfhnTy58yIgq0xxE6DtS/?=
 =?us-ascii?Q?mZJn349paf2o+2GZmNoZ7AM5VuP2c9qEz2f4FbBFBkr+7llvXlpQMN503wVX?=
 =?us-ascii?Q?1RhhLyaR3WUGbBF2Rz3n5QrJOrEvCVRQPzw5Akh5vMTYKVPtoY03hJo1CiGG?=
 =?us-ascii?Q?EHtURI70PROMKnj+RxtObHL8UrvbwIHclgwsuUCGB/kzauFlnuzs82dpCFgg?=
 =?us-ascii?Q?lv3qX2REyDeXEGGLQKRdhPPEZxWeNa0g1LR6Uqq45L4oNy6vVvB/pJcPeBQX?=
 =?us-ascii?Q?g8oVxkoobAq+rQYhQ7Qg49Rp5YFEIAl4nEQ6JNs8dsMNotp3uEyqKRhe4hri?=
 =?us-ascii?Q?Vd95vLUsEzRHn0ootvHGJQnGWX/Q9LqAKDNP5vIak6PRxrh5SaL+DargkVV2?=
 =?us-ascii?Q?NDGabC3FTpGGcayzQB64GeYoyADd4h2Z9HMAVLms8BBUZSASeCAn6O0ZUL9m?=
 =?us-ascii?Q?TKJ9SvB7xfqypxAr1Pk3payTwKZcs+3a8EMoXhk+O1JBSeIQBHILIyXGgbOD?=
 =?us-ascii?Q?TTZNFu9HaQEhv3w6euoROLtoxu9yfMxA5soj1SXdkLc7BT9F1tVfpcPP0+wG?=
 =?us-ascii?Q?twuiy4rRE3jCsDYeJxmoNnL/N74TGQualz2RVquAxvEDpU1lSYZD7Rbu3z4d?=
 =?us-ascii?Q?N+BzSj4fPO6cQT8LJp9utG/O+TZNDbtOgsiNKfY7Tqs88HBjw1He5AmUr2/Y?=
 =?us-ascii?Q?wPNmJ3FKBelXuHtU9tCUi4rQ/vbAJNqOtIr8/3zHlkIbgvSbpVE35nQbs3Ag?=
 =?us-ascii?Q?XG1JqFfeugTOA9f8/ohMX2veAdbRADz7VNWChQ/C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55d695b-46f7-45eb-3334-08ddda5fb296
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:51:11.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+ddUJ4L3CGe87P8c8QvZ8ZbOfblJ4KIYiqfWF2VtT+cJCkcmLXQ/I8NjzGLAhTEMddW9PuLJWzGwikp+ld7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5195

When dealing with structures containing flexible arrays, struct_size()
provides additional compile-time checks compared to offsetof(). This
enhances code robustness and reduces the risk of potential errors.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/binfmt_elf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 264fba0d44bd..4aacf9c9cc2d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1845,16 +1845,14 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	/*
 	 * Allocate a structure for each thread.
 	 */
-	info->thread = kzalloc(offsetof(struct elf_thread_core_info,
-				     notes[info->thread_notes]),
-			    GFP_KERNEL);
+	info->thread = kzalloc(struct_size(info->thread, notes, info->thread_notes),
+			       GFP_KERNEL);
 	if (unlikely(!info->thread))
 		return 0;
 
 	info->thread->task = dump_task;
 	for (ct = dump_task->signal->core_state->dumper.next; ct; ct = ct->next) {
-		t = kzalloc(offsetof(struct elf_thread_core_info,
-				     notes[info->thread_notes]),
+		t = kzalloc(struct_size(t, notes, info->thread_notes),
 			    GFP_KERNEL);
 		if (unlikely(!t))
 			return 0;
-- 
2.34.1


