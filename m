Return-Path: <linux-fsdevel+bounces-56256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329AFB15052
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2814418A4BEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F972951C9;
	Tue, 29 Jul 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bO6rvdrT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA62949F1;
	Tue, 29 Jul 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803619; cv=fail; b=nAvOgtqQGkqVgKagKMoRmCBWH5++xQJAGRQEeP0kI/G/AL3WukZ4wqvTJMJrWfKh1BgpTKIpDWJq9iyiAvW9U2LXgA3F3UfPfD90DpjcDIehYeJf+5IcezfwYeSsYSyzPyGTbFUPxheN/+GcVn3yajvhhF8+d1e+1+gpWwjwJ7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803619; c=relaxed/simple;
	bh=qCBupzkXABqNQd3dtciCKSUNEpxW4N0/moeGoWduVDc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UkOVKYaEE/+1AUDO80veqwlbSrMvc2PJWznAD83sUCzHkxU0yyjETqUV2LZ74B1eMdjPA5RHQA5aVZghv8UF72JGRtsDArKrCUoqu5Qc6yRB4WkjoQWAjurT2E1xB3PfIYj/ze+o6+bveyfu4jV+vXCAJNZw2UsEakQc7kzMBL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bO6rvdrT; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtECmYi3sG5hJOehw7Zz1dT8p8XRApqnFAW3rxMLeFADv5LpXbO8vluC3eB46dX8sYwp82HPQNpaYGrAOLXYRM0K0OVSj71e5D2SapxfhMSEArMv8y+aK4gGtGYGykzoC1lJSxTGr+e4Fu9UYOi4W/7JV4Lz8rLuYtAhHDGvuKRmxU1TojQx5oXGXHxnVhcMZOxE1/wpkwmhkawjXMrUYAPbme90RSDS7Xhlbeyp9frCepz+ee38AXzWTud36zJ/6UNhF9WYs5T0QahX74t7PlO7aHZqrLyfSDnvubVGOKGfUsjcEBqlJQg8ACRdHdt62HHGFnl9qZlV2ElWDOyzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A72/fBY4dDVug/JiChPaXwJBqlUWWmawd3f/G5UJZi8=;
 b=DD+8dv/rKA4D9ZGVXqGUQSihK2CuHH1e+jY79cIaLcq5K9m1CP+63iPaWNUUj6rW/GjGNwpsK5qy9KZvPIgpzwU86hKhiVRaK+DltNGt0eEtOp41gnQjlmOit/GzTC7vjEwBih8zkZwHmR4/PYVAJy//Hp/Q8SaO0Ng+LioEBjkwYWOGlEmxF4p+PjiDUKrlbmaRN65tmjPvK3QYde323MNkA7urZnqpLVF29nV6mHzCUL0gQj2qM4Q7JVo1LNBCGPXTN067vCN8clylO2/Z3L9iXavom3iVIixyPB7FZE1exd4HxViCUHyhKRK/i7A0U1rXhv8DXn1jTEYxGG0T0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A72/fBY4dDVug/JiChPaXwJBqlUWWmawd3f/G5UJZi8=;
 b=bO6rvdrTX0iQ8malBHs14HsV/r7TUQYGSr+hRvHJp3pqIToRjloSgT4S66Gmgt0Q962gz/XVgECgRgAwW5TEpwy9GGcPPwvpY6UVh+J8jHwFC75hZdNLdT8yRRuQJ4j3qt+rsucSUkmgtJK8wc2qv+lb3XNiZELcNXirRvQ86L7Ojd4WfWDZl5Y93QU9SGF6nRL1XKmK29U6V5jod8reqzh4xF5c0F2KGKGXVKRT7yNRJhR5VAK5YTalmC4xZNYNaGJeO1nZeTfUwk8Imyd7wKw2VTEEUgkh7KK0CszCSWiFT+Wimc6io0c3zrWeaCDZyfLDS6lfpzZzQNHD/OwboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6203.apcprd06.prod.outlook.com (2603:1096:101:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:40:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 15:40:10 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] MAINTAINERS: update location of hfs&hfsplus trees
Date: Tue, 29 Jul 2025 10:01:57 -0600
Message-Id: <20250729160158.2157843-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4819ecfe-ca5c-46d7-42c5-08ddceb633b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uXs0wGVcp2sImM/MzA3TWMraKD8HB8+qbUeRHUvcuvJ0E/GhS6r9/K7U+la/?=
 =?us-ascii?Q?5iswI5o5+9XhJckbm0ut+mJWRN8I0eX2LoEh+59J5TBGsgXuaDkkWt4swkGa?=
 =?us-ascii?Q?l3FQTeCn0LR6Nt9XdljOn9STN3sUB090hEADQYMsYXns6VFaqiwoYzdHuBRY?=
 =?us-ascii?Q?lMi+uXNbjmLcL15kfqWbt8PhEzX01YxG+0b6GQQLKwsZmalWbTESF20vxcEY?=
 =?us-ascii?Q?0eOMgC5FrcadY0JWtdGTsTB/K8uh0wRXvb3XwjzcAmo2smxXDjI4Pmg8TdVY?=
 =?us-ascii?Q?/yShp6GV0P89/UAEzq8+sBaBhxxu6jWjaXJGLWvLDmfdrvDvXzp++Ekknxvs?=
 =?us-ascii?Q?e4DeYwhpwSe+F278QryVEq3TZekdmSVWegGZGbMH6X35MEil/FHZRRmfGErN?=
 =?us-ascii?Q?HrcOwMjf8XraIr0CeC3eAWCONitWln3q4Ey7VoD8uFkF0NyHEyB6j/RI0SbZ?=
 =?us-ascii?Q?raSz/oLlPWyiXF2C+t1HAqvtIS0PGH8tah/MR/JTZ2gMPGuLZ6M4ru/LBuw5?=
 =?us-ascii?Q?kJlTIa0KleLJpXg141LByfgRrILz+eEZChxQ37LRuKtyabqSlCXPVxHNVwGp?=
 =?us-ascii?Q?AHZeaWZqiJC5HvuHIYxKIXD3+F0azQSkUJiD2Q556lvQ+VOSDyZ/e39HuTUL?=
 =?us-ascii?Q?5nRpz4SmoQpdxQy5XDUKq1LxO0iygoy8n+F38YgMMksmNSbnaMOnO4qdLORa?=
 =?us-ascii?Q?6B8rYVUjV8FZsXClMwfT7Wb1mtfTm/skIuk+QL4GoRXeP9gbLaCJZNTHtAK5?=
 =?us-ascii?Q?vgXGr3XmVF9qY2RlhI5XShd19oxWOAFrWztzPzWqZA7jDumKQb29QQL4znFn?=
 =?us-ascii?Q?xbc0tiKm34qmvH/eLxYriJlDTPWx0hi/DNufCZWoD1I15rtKWRjBiugyPHzt?=
 =?us-ascii?Q?ANVwItggHqrZjUbDg7g2Aj2MBV69Lr0yL6iBHP7RtUvtdc3Q0jDKKghLbX7b?=
 =?us-ascii?Q?m23AM6gM5yB86BAaopGtTyXuD80KNAje2LDCeEj0Z7QyyzEmvYCqKF6n9Q/i?=
 =?us-ascii?Q?RFz0XA+u/Epu51sQ2nPvzLnj4ss7Rulh801p322EficKUC/WLzWFbgxzG2sm?=
 =?us-ascii?Q?0HpV5MLLWQv2C21vIOzkmr2eNHfLhT4KqpMqY/StwICU9hR6siyzPDvvXei/?=
 =?us-ascii?Q?J+IwU8vV3mzDMQwEx/qZMGyMddMnqoezCrGULvRai6r+RLszwQvRZ7OgS7pE?=
 =?us-ascii?Q?ow9nXyO1qdBdsfdLvG3V24uOqwnpfH4jtxUvXlZh9Fk17M6vzAjMu4i9QJNQ?=
 =?us-ascii?Q?Cw3rxymqqU8Ft1zenwsFBGhGZRgRQh28fdayMvnGOUDamzWcfiQcweVHxP2U?=
 =?us-ascii?Q?VPoHJuU0lXYg9dDk0Oe8C7RVjoSVc90BYQwv1ln06m2bbwCLVEkZfqVnDEUK?=
 =?us-ascii?Q?tw1DhPUrzc5/estFDRDNBNIvwSLo2vImFd74mtH2h9WkTr1rmCOQofvF0Ql2?=
 =?us-ascii?Q?BGlNk/f6PVctbe4rrixDfCt++u7GknH7DGDr7luCw9OPnkPjuDRekg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lsV0hzKPARmMrRqoBYkJJ2YkR/yDp5yVkBBEqyydGId0E7yElyQWq1bPU9lM?=
 =?us-ascii?Q?UALlYGA7E98AhUPoYj+CsBY3cyUhp3syegFO5TuoWPdUA2415fyXZrIkoQGM?=
 =?us-ascii?Q?riqH0zKq4ReVuhoiqw5MHW4U6gLmCudhP0hU9JLlLPJ8WBAVFOqk7U/gl091?=
 =?us-ascii?Q?extHqEh7qvIHpXqXa1EJ5HdUkLE/L5Bp/YexR4VgvsCOI7Neh3SZUFapUv24?=
 =?us-ascii?Q?mXYurWcilYNG94bWdmd4IJ2JzHDadjlgcUMQq+Ux0mcudlg00hkVVdde2BFY?=
 =?us-ascii?Q?cduXECYAf/IsDYy9eNf4O3FR3ICVy9WHC5yK5T0TNp+Z6loo7TqsEIsf8AjY?=
 =?us-ascii?Q?wlUqHxe+i52DiiWhvdilkqqHLTRQgvnnbZpO/wYzGQTWPF0U/98h9HdHN7+o?=
 =?us-ascii?Q?feqy9xtPpmmhcnv2/UF7D+AqJQCBGCRu5r72JIE70TPd7D7yHKXuhBBkM7ia?=
 =?us-ascii?Q?0iPpX7obkzun/YIlgst4Kj23tkKq8z1/5pRWASIRjxcq6da4lExVy3WtCFZP?=
 =?us-ascii?Q?Wibb+utyMuadJt3U9TfLVzz+4LqOEgwY62mryJmuJx4YvpC1SnZhtIE3LBIL?=
 =?us-ascii?Q?QiX6OuEE9z5GwQsJlLBESw6Y6CiePEZCEZiBoBb9Z3pTYaRFU/MNCC5hkicA?=
 =?us-ascii?Q?J4kvqf2I48wr5mn4ohhn9f9gjDM7kcpjHA9FTrdISjXOrrvqF426BT3n/VZF?=
 =?us-ascii?Q?Qm7hmSopZxijxa5lJnrDs4y+2DQ3RIb+G9lNvXGgEzPC/ZeoEBvUGzrLXR0Q?=
 =?us-ascii?Q?MhQ/rC4Q5ammBsRQEEbb1P4k01o4yhZ1EfbTob0ep7r4yuzONlkZrv0fVbOl?=
 =?us-ascii?Q?0mG9Qs4JW+BBHI2/jccEAG+HaGaxAlP9S+WQuDEve7zwnTJvPk6aJqrWAYtG?=
 =?us-ascii?Q?pLQU9p1Cp3eynagPoSENKGeGOWwO3H2gWsrP/Rv5zDKPKB11Zt1VOADCYlVO?=
 =?us-ascii?Q?NlhpGTGFUlbIkwEWbGE/iMMNHueYx5RiDM1mMWxuiiySU6YPGCrxsJbCwLyz?=
 =?us-ascii?Q?TZPtpgYj1Gl79Aw3jVVcVn+pPNHFbgnFLFuSH648BR7R1KzrXEOA5OsGTRbQ?=
 =?us-ascii?Q?ylaVaBW4ivVaQcx3rXALDj31UBC5GeaAhbDuuTqbnzW69PMdMHCKgIEK4ahc?=
 =?us-ascii?Q?FLMk6SURSyHQRwAizkZrR3NjYbvDWrsEVmUob5CjR2gtNe5HgWBti1m1h385?=
 =?us-ascii?Q?Lh3d+GfnxfqUtiwzHPE2hLi2QM4UqnsIt765XJ9Qwh0vhAvZqIu5d+DGs6kV?=
 =?us-ascii?Q?EJPjByjZd9DdBeYxn85JXmlqmBd/Mc6Jvzt3b5q9kckXqf0YNzxloqsXjuIz?=
 =?us-ascii?Q?EUlWqTAx46haOJBQervpeGcjyj0lAyzGN9wI7P/lmaZuwUYtxkEjlqQrZRfE?=
 =?us-ascii?Q?2A1aeSDC/zPzwMuKqMWXULuUsSgyuBvoyIDXfFaw9UqrMKSg3qH7iLJ15ODS?=
 =?us-ascii?Q?LF0jZGrV6JkK4QxSmLe6/K32mIsafPvfe57oGNxQnxkd/kPn3GNWmufgAJbp?=
 =?us-ascii?Q?OqhEXOtPORsBHjGS55RzfRmuEYHCOV2ODm5TcAFDknzAnlDy+3PrnoM9oML5?=
 =?us-ascii?Q?g2xDHds/sZEuuUuB8I575PgNi+h9Q5coAz7DTlg0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4819ecfe-ca5c-46d7-42c5-08ddceb633b0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:40:10.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VucWGyZx89/68xIHgQOIjqvBeikgGqSMYDZk/57MrstPUXAs0s024qAA3LfgO+BUIjQUUSc0g7GN5p91cL+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6203

Update it at MAINTAINERS file.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a4e63bacaa4..48b25f1e2c01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10659,6 +10659,7 @@ M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 M:	Yangtao Li <frank.li@vivo.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
 F:	Documentation/filesystems/hfs.rst
 F:	fs/hfs/
 
@@ -10668,6 +10669,7 @@ M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 M:	Yangtao Li <frank.li@vivo.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
 F:	Documentation/filesystems/hfsplus.rst
 F:	fs/hfsplus/
 
-- 
2.48.1


