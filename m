Return-Path: <linux-fsdevel+bounces-56643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B2B1A26F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A18162430
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DD253B67;
	Mon,  4 Aug 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p7xxzhgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177011362;
	Mon,  4 Aug 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312432; cv=fail; b=boQXiv6URrPqqa/Kq7Pep7hd32Pd4VOhETF6NqyxviILzjJvQwqcxFQCqdZDtkxk8qygOxoTvMLvLsGhH3QlFkuhTSQXUU5RvblgKTrSe7CPt0oHpuZDrWK41sES0n8S398BuXeCBvtLg5qQqNhHSNd14twUivp8msByiqyP8Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312432; c=relaxed/simple;
	bh=oEYTotZEw+NpAzImVnaCBuSa5UV3nQBA92zDjotN+jw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r2tczYGYEHqQBnj8fsWnOV7z0gXXH/Y84YknzEKfmqM5sMFVb0wkHO03ZK+sN1r/FkQ6i3dETns1+AOhgEWrgHkx+NKmtLIqcFRAKGPATpXYci9NOf33lqWG1pKFhclznzFhneSRgsh2KmEv+ySMkCbiH8J7JEuezjlLCGXqiCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p7xxzhgp; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pabRLVUW8PN4WX1fB1O2ie3ClVhudFd+E25VGBr0RB+X/fWpzfrps8wvjixDib2L4uisX3fc7moq/c69X3apjMhzO51g2PagPUk0Di6eTpdsdM73/yiyFoDke8jKey1KNyJFS0I0bwxfkQD3StFq2kyCSLPwfVu4zb8F+OAUbsBDL1PVcNfX9cS7WD3A0LZ2qXIo7/o5yNMQpDK8gvX1FZ2hU65aMKM0IMRFCDlTSbHDj/atgkEmBeVANCNsuaswcI3dqGyA0S/dOG3u18BYa76ZkWVWfoPcKmzV+U6oMKXJdachD+K8EU5iLNJEowPGzS8ftSjC0SqVxwezyvJAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/isIDQXqth2L3lN4ebor7qSOeCpQ7n6aPlOnnGVHjO8=;
 b=i5IBrAIRRYWGQEdF/sdrYUI23SeKpcCyk3WRDwlQ0aIcYwKhPXfyI6NLkFyeEXfdEhB3tpf0X1pGv07GtZWcZlVHX9i4MTvqWmNvt3FN480BIjYwCui2Y5rtHY7yXKWqTV9l0BNxTOwPHoadgmIxRN5/t311+LS5eFIcsXLCcPy+0+mImnY7dMzyg8nYGkvgV01CNK3Z/pjlEFxREdjcBoLojIFQg7u3P23pVpH+cxsfOfavjF2i2l5/ms34VO/TbT7/S3NNnQAWv0fLYEme+6+ARexag8+yQbczSkG6eq07yEzABEDBnVo3ixDvJaMg/HbyGPJ7WrHmDolOGeYjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/isIDQXqth2L3lN4ebor7qSOeCpQ7n6aPlOnnGVHjO8=;
 b=p7xxzhgpGdv6z2ohwwneLeGpW0vabUEqbE8NTJnyvhGVUZGzJXbN4o3hjM86h4le+EHEEkqze7s6BIYDbSs4+535+evqFOuqylQ9wfAQzEdM+tABplTxN0ojmnoCjTNiKcATOIWm3YKjehvhbKrv3eUNO9SD12uEaWFnLXQiShVT18Sfxyol039BuqSc2JibV4OJeZNuu+aAnZ4DtjiXOnmD36czp75zh5Hkpreo1sMR7OEWlbp4rzh42Ag8vhEzae9+I2nWZGGVAH20/vptz7plLbXdKq30Oh8LlRY5jk+WE8mZj3vemEOj0VE3EMzIaXrQ9zCGOiUmAoHjOlpqNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR0601MB5566.apcprd06.prod.outlook.com (2603:1096:820:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 13:00:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:00:27 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] xarray: Remove redundant __GFP_NOWARN
Date: Mon,  4 Aug 2025 21:00:17 +0800
Message-Id: <20250804130018.484321-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:404::16)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR0601MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 550c65f8-9c59-41d7-1c52-08ddd356e268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQmUL3/j6tp860/UgiZtFRiJjPamRlzyt4aSZNMjT8MjnOBs3+JqPVSTn3aI?=
 =?us-ascii?Q?mhYrSNY0A0BYdD2Ig/ep1HdeiUhHlwJF/to3pGIGwJoVi/voQtJrKE2v0iEA?=
 =?us-ascii?Q?V+wrXVRpNlvzOmNkfOzosTcQ7amILu0Y2Mx4P64RGtGxPc60eNYi6alJi6kA?=
 =?us-ascii?Q?K1kURBcQGYIphK4zQNBVBWbLYOteRkyKWT3FiKlhNFfAJ+oPG9BhO2QtPJ+K?=
 =?us-ascii?Q?8tagvtdqliDHyLyMj08DXXxoI0EQJHJUljnE8tWKRaEhHL8QYvOWlOYFLNG+?=
 =?us-ascii?Q?gNtfd2jJQUB6pFf2YeNYuet3PzEtECmFbmvTBw3P4jD5TrXumo48qvboySaw?=
 =?us-ascii?Q?tnMQaPpm/aXQQVyNkkASNiFkMnGBYwyDl7T/nSDf88Wgf9HbeUU6yhHMb0ta?=
 =?us-ascii?Q?+thWu31MNufS0u9sKmEvoOEhbOHk662iTj6sNwpou0akp/SVD8oIufZWq3pv?=
 =?us-ascii?Q?CRegd+Uec+sJSRk4JwpbxNzHs3pbrjmdrCFkosVcJu/RP8PxaQyD2KbMiDNn?=
 =?us-ascii?Q?wdGv8ipygSiDJDqQkNK/WMYXPa6MBQCQC70r2TNydB4ZbxiqFD3vKHDjBYHH?=
 =?us-ascii?Q?4UlksUjda9JKSGR1dOLjVMkl32u6PebTkHjZMClzQnkigLUe9mQhoOAEvxlZ?=
 =?us-ascii?Q?sIrweoxwlh8tnbgDuA0Lt7bB7m9xw7gri+JjmQxg+i24blxCTYG3gvodYFV0?=
 =?us-ascii?Q?/13PlLyW2lMN7Z+hCSzrPRJ/oJmNNEy3xffB5h1RImwlQvvPzwcWoJAS+vkN?=
 =?us-ascii?Q?GZVACWJwgvl51AfTrE8jPO2NAocdHjwSwklQC17l5zLKsPTvkxa/BVYbqGLI?=
 =?us-ascii?Q?IfGZ5ECGLpVhgr8SRg4sGjfyEj+VkTi8BicEaP2Sk5vT0hCILN/DAeBoy9On?=
 =?us-ascii?Q?qtnv0bCDCiM/gF/69w9TCocvI05q+u0hNsxmTsUnAxY70wIcOJORc/T2FGwg?=
 =?us-ascii?Q?vbSYUiJaaLt7am/CNgGGCbnMOmk/9OrSp6bEf7evyxqG+4w3pMEKPW+1BWs9?=
 =?us-ascii?Q?fO8Uo37+WOQE64WOlQKQrh3ZGbCDx6JrSHpVuuooBWx+lt74Kp36/66RfoXr?=
 =?us-ascii?Q?u/PmoGwc4GaHtKKw4QdbkyDyFCBYJpbmk1vRv6eq+1wz+G9QWxLgH2inolEe?=
 =?us-ascii?Q?k5wNwyZ6+KlvCXx9fkEZeVhyqX/6JdUkvr0R0fHqDDcXQ2NusYH9aGPWUb/M?=
 =?us-ascii?Q?kBCfibOOP3wmRc7r5+av7T7nmo1XiQ34KuOjp7zoJa6zmTFxcEOs20OKZXqx?=
 =?us-ascii?Q?tDyss6D27t2KSequjU7a+kdSnX8yqqhbZ8flgOQZPsPO7kSVHIp1qnV+6zMK?=
 =?us-ascii?Q?sfj9sMX63T4pHwdl9OcbzF3jyziSSX+8GB8Cf+DdeUYcWxZWSS5oLeuj3X8y?=
 =?us-ascii?Q?CjviPkJItNp5UWJm0cQmiRymOzHKGGvkCVJafIcXPjtBIzcKJTs5iWJ89jJX?=
 =?us-ascii?Q?4/WkYrFPQlJgOz5dAVZBKSt39x6Yg7GgfxaTIVLzwLDte5QIJFy7OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7me5xU/DSx3xYmf+aVb4mZFgkDKrWtdoRddA+TNAAJcYlZp4oDKZGqwYA/WA?=
 =?us-ascii?Q?89yQcWOGFhLU4mGZJVxQ5as64senPQkiQ8qmWLx+jAXp5yMFTz+c+DpfnzA9?=
 =?us-ascii?Q?x5Vv0yaKTyvl7AParJe7dnMCYMwm0YXFtotf8lUSK4pH71hMeKskV6t/Vazq?=
 =?us-ascii?Q?Y5NaxmGl7sZj3PTsHzzP16l/uU0yupPCdbLIA3MPYmzyiPe5tEkMJzzgYOgb?=
 =?us-ascii?Q?wFNZOTPHyelxGMPUl96ENlU/0ntVxle9HAUtu+pEAcy4u8QZ48RHQvsl7UP7?=
 =?us-ascii?Q?qpO1w3/ig3xU9m0NcT+mmlgN3nne2BzEDSaEy1dmjenwKg6nhvB651GsvUYW?=
 =?us-ascii?Q?1U8oF7t7ES3ZioucuXEKolk0fJAT/CX6iOUm5EdTXhdCDUlGzrPJEHwwePO8?=
 =?us-ascii?Q?E0LyV9RlDtUhIepmZ21m1mmk1Hpf3rDCAdDDydciybhvWZ7nVSbfmdm8GnGm?=
 =?us-ascii?Q?77/aX6su6hjY6V6coUjaRvvJasMe0JUlPMKC4qRm9gwVPLHitMVDYDfPC1fS?=
 =?us-ascii?Q?I7nuWu6AXVFQqfHxSczDoUgH8B4TiEOoqk25APeZQNtiTwDifgNUgp+Gbz3O?=
 =?us-ascii?Q?23kKvI3Wd8eWagFsFsoL4TbLj90iSOGRIcDWxYjFfv18A/oN55pfd3VcMcNG?=
 =?us-ascii?Q?q00jPg3NO44h1baY1hj6mSTWbUOyu2Ru/f8tQKSaP7M7SNIQd8cWdWS6yjGc?=
 =?us-ascii?Q?OHV97AuwTiBQXqQD6aL7bntSeevBpO2/ENmFkbkTZMstNCQP7R0VXi0ppHq9?=
 =?us-ascii?Q?7hJ1xwmQkjwYbl0PEzPOdtfX4uwqHBma8tDby1txpWNUDLOsuBXYrn4geroC?=
 =?us-ascii?Q?5OP12bosOW8+JDL7mDJOPHMJLO5QO/MCgquAfbjiajRDTz6IQ7FVzHK3EgZg?=
 =?us-ascii?Q?Zd/PmRbY/FRRo7hlW4/l/kUwAFBiDp5nZHuRyU+bIMZ9+3K6kon05Z3u+g7e?=
 =?us-ascii?Q?IEZpxS19oTQr3citr80CSjFVQnqoBlmXJ0e9RCyrp/RD/r8B4YqGI/thltIX?=
 =?us-ascii?Q?38LPSmBKvV2bbqFsdZ4UhDxJCMFf/XvJd/dpr+j/FGGgxmiIgUWSi0kbwE/3?=
 =?us-ascii?Q?Qn933A2u1mW1iX/Ksj0JV2JQfQ20foEP2M+uRE5LN1cLVPNiN/aV0k20UArB?=
 =?us-ascii?Q?mhPoiKGlEkF0Cx90v0CEDn4hQm5ZZ5yZqEvQdZk8jHlDpeBpB9eOsVCkd8Ex?=
 =?us-ascii?Q?fjMLKqnQYXz4ZbczG9d0ChqnRsSGlFzrl2wM40w2z+74lnccOljm/h4Qmosm?=
 =?us-ascii?Q?YkOk2TfcEF+17SnFhxb3XljYBih3MnnjOb1P2KlfjHeRIjmkpAOce0S+39nh?=
 =?us-ascii?Q?sU5Ak5yB6CRyB9de+k2H7Y7P2psZmDQazJBfEoQp26ucfreT6CZnEfuSIwxF?=
 =?us-ascii?Q?axSNzQILjUGleCTuUwooBJBP3T0PnV8bKfUxF8lNTW3nNbno1ojhiojoRKDM?=
 =?us-ascii?Q?u9K2mollqSPVzq9TSt7Cxyu6n4fC+BUT3BCMFxISHeGjop6AUDVng/uvB+Df?=
 =?us-ascii?Q?nMZ0rMgxkgV/+yIdGEojMVFP2vTYhzXSiRHHXxTultOacVYdOyTFHPbnMC8o?=
 =?us-ascii?Q?eWhuwfO3rBcU1KVuAB/4IXaJ+SRT1OiEiebkW8H2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550c65f8-9c59-41d7-1c52-08ddd356e268
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:00:27.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyg7Sq4zQK5Dowih5Zn2aKiSA/56n/KTMF9jrYcQjI2sDh/lw01fPSfSLlVK3b8ZqL9cjn67uSQEtbGP0OeLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5566

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 191a02d94524..a2e543d1396c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -370,7 +370,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 	if (node) {
 		xas->xa_alloc = rcu_dereference_raw(node->parent);
 	} else {
-		gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
+		gfp_t gfp = GFP_NOWAIT;
 
 		if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
 			gfp |= __GFP_ACCOUNT;
-- 
2.34.1


