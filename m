Return-Path: <linux-fsdevel+bounces-27333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E596055D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4600C281D84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38298199EAC;
	Tue, 27 Aug 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BlKy87EL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445416426;
	Tue, 27 Aug 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750377; cv=fail; b=b69Gs98M451+OIfuvzKQJe23KN8/O2mQbKTIxQo0zUB4dT44X4FbeAaMfs9LUhcduVObrLygeAS6kAoL8dO543IBibI1ogLxkFmnJ1l9LKTDmcpciDTqFnRWpFUciS6c/ZpOsvG/5YO03iCcKJOZHLgW5aPdNh4I2icYZGYbiuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750377; c=relaxed/simple;
	bh=uFFyyo6EwhseHxoyEYcjiK4QJRbbj3kZzK54h87IYM8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fWTpsqaO2vhSO5xBFNfX5QYXPr/jAWfiHNyVEOMZNRZlnxyD+O2DzjGzBidPa2n5mQPOnBoagL3qNOZZhHp//+Ih/FYFiI08T2xJcka6Q0B5/uVnYfbfIEcKf/pItVsIdAnbRCycFCyNsN/+724KbBJ8SMj6ek7Wq2K0SqZlABk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BlKy87EL; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys5KvMU09o8txtXGvI8Nh8RbzD8jUtSKlOkZTj2Tr2UBi6UlxaMnrVtcXHPIDlFoRvLlhBdIYiGsSI2WhT45G2G7ghRNQqCPULvKh16citIPjZ8xcP9OsEGuRRDQgnJ4WiWTI4zjl6/rNQXGI0P0j0IPwH1adiwdheTLMvbr9z9FzToIJyV3uWL4AiT5MWLvf07Rf/NBJeNisPLrxjNbkrE+fqWo5kKHfohemnRq5VgYDIWunNSe3ZtLonh0+0KDKU8z//B5Jw/tGZLIOeHX9b/gS1BN6i4fk6GFvuV9z3IKyWstgaE8+A4tPuJXLtnlpXCLbB/r6CwhYDd3H0mK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1eTylg+T996l1J3AM/BZrAKhx7OqONdPErEbHujpuM=;
 b=cPJPn/ww9Yj0e/DRz0+QoOxtKVk+p4ZTBMERKyHKSEAaVZAIUxdNWDADiNOYbGE5kFeFytcVCTHDWnN9lwaHQLXB0+EuzgQ/gTphsN/UYxR9bjf/HK88ADIC3uwkAFYRmdPBsnoxlG70cEYEUvmz9EHtOpU31CH7ixP3xtT8urqRznkAvSfoTfZUKPrCzjEQ/dlH47AgHlq95qk+Z+SRdOhiI7V9hraxcrZcIc217w+7XfPlKE8QiqgHS2/ObhlZ+t2U+rW7hfBeA0JK9mRt4k0fstqmkMYJL+QYynDikp4JMFukTnuqLrOjiDlNjY7U8yclfwzHiXiDKopk/15BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1eTylg+T996l1J3AM/BZrAKhx7OqONdPErEbHujpuM=;
 b=BlKy87ELQbVRRfRtMb3GMIrHTlWv9t6ok6d8zCkj+db6cxqaEQQ+ZlkYqh3tp1clT53yNVxbeRRq1Z10NcgLYhpNf7oiVzdrRbezDJ5mniXcTRLrxX/BeWwWYTivoXWdkDEbQGBKgpTDwhJM49Y3YWum5kUqTpCSf7JShqMV4fssi9p5Q11IzMcTolqpb8dqwdYJYGQEBclD5HLT/8sl0wpb4Kw0CcEOV3ddU97+Gt1rbRAZ2XL99OKMxJbLMXONFhfmjn5I9Fh7F6JpqzMIt/sd/4a4eJ6qdvyEXDTodXd8WJ8VrWoegipKUFj8FlLGSxg8RtcYcKS19jNltgWpfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:19:29 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:19:29 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] fuse: use min() macro
Date: Tue, 27 Aug 2024 17:19:20 +0800
Message-Id: <20240827091920.80449-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::20) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|KL1PR06MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bedc86-9723-4ee8-9039-08dcc6795a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L15gZ59TRKe0jGRqI6C7g/PjrQ93UqUlomDVQ/wj81BrON/XOByAPlgpMHry?=
 =?us-ascii?Q?2CMH+pWkkETJ0D/9H1fH/xiODiX/OuMATgcGrEG1QO8c/3nqP/jjC7MveJBn?=
 =?us-ascii?Q?AP0wWwre3gOe1s18l3TiNSAmg2JTtJnYgo4/pFmNeLlKU//BQo8EQy6nrjhr?=
 =?us-ascii?Q?Pu+cCl68Lx2YzCOFhjzs10aGp3eUPXkBq1FTyCKjDv7AHNsWUnf8I6gH8DRF?=
 =?us-ascii?Q?pCsabC3TzCLETzQTjHMkX0OxrjtBMu5golySr1JABIO+B2Tru8T2tbnmXA9d?=
 =?us-ascii?Q?oOBx3Dnppm2gPgQfYWgg+aj38uv3wqMNkR5B0XMscnl2fQQy33kdHAjxdWWf?=
 =?us-ascii?Q?1LFtuM4bQbQnFJH3Qq1E4V8uKIRraBrjrTyDycMGri/VRt6AIZ/puXwZ6HQU?=
 =?us-ascii?Q?4VCyX+PX6iHHfrXnW1eqx8mm0o9mxmQyvW20w5XRdh3LbUwLMb6KxngSAd7/?=
 =?us-ascii?Q?TY4Bzl+Q/Gh01JWzKZ27nro7hq9s2HYrRWrq+V+CzaaiHBzKtpp5P1fGb+is?=
 =?us-ascii?Q?MjlkDJS6KoKXms4ppaOaNT9UW4TGaU8vJDtaWYJQuVy6EQYwA7p1xsJV13Zq?=
 =?us-ascii?Q?TJ6BECPR6Ii+nkn6pOSKPmwOSI0Kghgv7SsaluE169dUAIdnrrrmc8u+H96R?=
 =?us-ascii?Q?jNTlM8mPWDNxO837uEvoEDIXUwVneGu1ye9WolgqeQJgJnpPQ+YSjb15KZk3?=
 =?us-ascii?Q?8OMpXfwj6DiYNJS16BX7MhuaN96YaHOQJbHpwp6WJ0xw4obw2aJwigzOB8Iw?=
 =?us-ascii?Q?+octB6pPPsVF7+sDw6If2gZj2ZozEiq63OBkdYCeRtFPrrEBCQkaWLNXbSSC?=
 =?us-ascii?Q?Jm7LBVYkODSLUTJ85q8MSe649icNf0Y0sCx+XTlds6DlRI9oYWmmdqNNR0NQ?=
 =?us-ascii?Q?q+ASVshA+1T4NK04wPpT4SqE9TJo3aDWoWpNJoA8qCh5Rhk4xgty8AnBy6iv?=
 =?us-ascii?Q?SoseL2TyHRlr+5JYc0uoLjEt34TGYyzDPbAUbS5D2sfXkv+SDQE25jfHnXYU?=
 =?us-ascii?Q?oSD63YcLpCDTrN0FkM2ahazd5s0ERNymyqe6nhZ7RrLF+b+90UI0fpZNcfXL?=
 =?us-ascii?Q?gc9UOdmxCafBfLBmsiWJAnEikqoe4fFAC1qwthMqCk2nRhN63EEGpFAfk6ZF?=
 =?us-ascii?Q?/ZqDHkEduG+EhJi1qsqGS/myYDzAi6UuStDpsHCe1p3e+CihNqvazlyoKZMy?=
 =?us-ascii?Q?IdT48KxGQzky1hB8t6oD4Kb7UY3t15/4o+vjKiwmyQXQvtqaMORdYGYRgOwJ?=
 =?us-ascii?Q?QEychMjDT7qdzpR5Xzo9TpfQa6XBPb//cFcHpPCnlPx5mSwRDcSwNeuF0w0e?=
 =?us-ascii?Q?FSlrRkBKFaLmk50MXWD7G+xzeouwKNNrySbv5QCObzMd93ljb3XF6O3pyA7i?=
 =?us-ascii?Q?g9sbpaNP/d1GZThdDs7EiqpNMvMIJr5kREG+v4L55s2NwS3R4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAW0Mpm5hj7Y4bkJ9xQ75hRRpJNuEMFhK1txC9mlx19H2/n9q9mOnCXUeU52?=
 =?us-ascii?Q?OSdcjAwIQEH4VnstRGA4dKQHktsgs+lZm9hwtbO0hAfaO0BgdJmHV1eL+qPr?=
 =?us-ascii?Q?n8eVtWRgBiZktlgh60pCRNhry5IGhZuvucoVOtuTuw6ZvubGSBTLJLuDSXzn?=
 =?us-ascii?Q?Ic5Ys+e9EQe0iTQ0d3GIwK53pDqtiTSlbktB03mHrMrheVx58qVzcoaXV4WT?=
 =?us-ascii?Q?bkCPRGtu8mt1Sc/yWf7PRlSsrSZe6Im1dl+VeHGFBugMOJY49wW3TELsfWjK?=
 =?us-ascii?Q?4vEcsaRF9MMqvIjwhgfSGZQSFN4mDNzKdeYbpuT+dcrPuI52Nr+sfIKc+63V?=
 =?us-ascii?Q?uaiR6W7g9rtl4ZPT3MPLMkgqV9MSc3zNqhQkEFrhRQUvxD8SKYeQrh7FyH5c?=
 =?us-ascii?Q?hKN7rbTtZafzQHISrGZqL7MS8+BjxVbDzc37adD/v2yJSzHDa1PiYxoNAbWn?=
 =?us-ascii?Q?kXjCaiLIcHkhs/IsHZy6sU/O9FepxDnNqTjk5HoPHUOdiEbHLYBbRBOgsDy8?=
 =?us-ascii?Q?bdMdGs3DHvwzOgWdNF+9DHnY4f//p612ooWSgd7DjurvIpHShrU5hpElBeT7?=
 =?us-ascii?Q?WErluEI33DvWNVj8Y5MIpyLDhFjPYEc0S//PGAfVvkiiyfAZP4wOSBulEdTx?=
 =?us-ascii?Q?9aTgn3wL7ooAa+BEJIYLMBz+VgLbXD6LzH9/jSjBEK38+N3uN5CoPFiYwHq7?=
 =?us-ascii?Q?uwJv0or+tipCnYr2RiuQr/+Dygikm90eBfSprPZynACxEabrT7M1mue4dEVq?=
 =?us-ascii?Q?mDB1JJBeBrTrrNXK5L75BSw0wFJPD9ZZ8dc5NZ+UKHAYRWNwgVnFdg8UT34E?=
 =?us-ascii?Q?i9++b9hfx0kzKQN4uwVu+H1lCduy3LYc7oviJxfvxBMPlQoFd4b+3jh2V7FN?=
 =?us-ascii?Q?CzJ+hXzoq81AnXRZup2NhZVbj2S6qaiRl8OjV4n+aiOcS+m7PwSFL5PpL22T?=
 =?us-ascii?Q?aQJZGvWu/WR5UVvSBJrO+UJ1xR2lbmOCBvcM3PlrXfZT1481/n4dZmuqGWIf?=
 =?us-ascii?Q?xVTMPrA3rGUfwZx4xMzp60wv90YP9F7AYBeyP/uq1es+YM/L6QK+RLElC0py?=
 =?us-ascii?Q?ToYxlN7HCpDY1WNuAzhqzvxr2+ZZEvk7cjLECyLTKpr+SzNlmz7kALusalk4?=
 =?us-ascii?Q?hwFvpTpCyURx1eqg/VilEWq1CEJgBDogpWtH3bKNt5UyOww9x+/uJFdm9Jy5?=
 =?us-ascii?Q?E7JJ/pJ5oPXfcKOnGd9X/klLavhBammy3pYm6hEFGCLpYIvK0RM8bERd6roi?=
 =?us-ascii?Q?DKjjfs0Vg6J9E9mjSg33C5TO68VQJR7d9WJBpZjaB5Ih8ibc7XApT+23Titq?=
 =?us-ascii?Q?lkjgNKENrdbD9cQWwvOnRVcTG/Wc4WlQmp9GczImpJR0B3YfbLPaBrH/ct1m?=
 =?us-ascii?Q?y+NQrgGNXHctYGMDDi4SlJCqyozcA5oBYjDeBeL+JBcwCn1AL07LmNm2AmNs?=
 =?us-ascii?Q?dDClc1wr9ZnK8i13BbuiliN7Jv3QdbXevuzkjvY5cLUECB7S9m5jgiSOb5Us?=
 =?us-ascii?Q?5L5KsxIvjfS4X10r9Iqqf721CKL8dCDtUs46rYBhF6sS/601UcLSdeOb7e6G?=
 =?us-ascii?Q?nDo8A7eM1QCEESL153t/eAzT5x+o7KBvGgUzSu3f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bedc86-9723-4ee8-9039-08dcc6795a9b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:19:29.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pLDwkMPdQW60UVX4U5t6G/9jFlAaPTODAoJGaqpNbuxVFipQOqbF+nxF4/j4i5ChrCeOoXOI6Me07OwxV0I6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6395

Use the min() macro to simplify the function and improve
its readability.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8ead93e775f4..aedeaa6014a6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -977,7 +977,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 			return;
 	} else {
 		res = fuse_simple_request(fm, &ap->args);
-		err = res < 0 ? res : 0;
+		err = min(res, 0);
 	}
 	fuse_readpages_end(fm, &ap->args, err);
 }
-- 
2.17.1


