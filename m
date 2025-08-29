Return-Path: <linux-fsdevel+bounces-59624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD97B3B6CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FA53603BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3B2F99A8;
	Fri, 29 Aug 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L1bqwp/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013047.outbound.protection.outlook.com [52.101.127.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A762D8DAA;
	Fri, 29 Aug 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458930; cv=fail; b=fqSvgPv3ZKZDNv6/Tc+Oz6XTkNcXKGW3Z3UHpdaPbXMTxCbx2b7V9V/w2f2DUPkAySoPb3Mzqr5ZxuWxo798DcxwooqqR3ScsCKd8+Hf3j+9Y6HbqBOn/pTUdEyWxlalsxXi9Jvx+BaXMiWbO0qWaJazHFG3bU897FDpx62+r90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458930; c=relaxed/simple;
	bh=jQ8L8PzXQRTCLOk00KO35C/fxwiJWY5DZX/cYXPj17Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ObrRs8lyAQ0WMWOK9o7Rc5tP6JzjDQMlM7CFHY2LnNelf1mzrQ4CaN1rtm4a1vrsGYiCFQtGV3LBkCMMX5J4LsfDd99MIdn/KHHNH1xpmHH6JmD+9qedxZcUGDSmn9g8K4b/sT9LPH0yI3Y74YRSdW/LP0k8SRmos7Vy3qLktdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L1bqwp/2; arc=fail smtp.client-ip=52.101.127.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTxKB6PKAmz6aVhagJnULJYrobSV0hjYlbpsdQBC7oMZqcFh6Nh2cUYEo405hRaNv/UevhKGzxd3B8DZioLImblW74fehaLnCtXFBCqw8CooSVw2QgUxQN8SkiRu7JNm1BEc0dv/1qNOAxME2rgnAxb2ZioK5xY7H8/eLTAfCck+n41ZxiV9EugRmE9zMylUChTZi7MLOQXQjgOtRfxXgCCqJjiCewaeIyT49Bu83stHMQcdKayOLHB/lMRODvJm1an9PXe2x2OBsnlGunxEkSVFE3e6BPFGLh/IM/Ad+0snuGV4ZdARKFpxWpjApprgljjwZdF90lcOWpsfi6wFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irHYm7CmNOug+i0AYY2mf1lQgu0RpEe4nc8Esrli6aY=;
 b=yYYaOVP1fMn1JeO9hvmOfWUHh7d53P17agnubvg1X1r6CEnap6sPB2AMfvsz6nbx6PgWgOyExgbTuVD2gOMuY/nXZQDBUIlxL7xnfLLZAfdcuMYj1SSwpxFw85nR14jwvgCm/9tjhOrcraqK304HeMdoTywB7aOLM4FM7caBuIIXmbAvDh82zsT6kPoRW2TQykY+w16hfqbeRC9Jrl9dQIPvwrpNfMPMStc9kBOXEuOVVQVysFXTknjbchzV74KmKCO6eVqO0Ezgu1kxQ9H5qv2aUTOtjYi5HXqS9NZdVSd7XPhJuPaEQCEghAojt3nMYEal/zSjwN7v37vxfg8Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irHYm7CmNOug+i0AYY2mf1lQgu0RpEe4nc8Esrli6aY=;
 b=L1bqwp/2LGBxN7ZwZQESyV9z/zJREZPXW3T+TBfewhoQ7o8GkA7dezX0l2nhmVk6EmmPILRVKyYV0nhKx9dIZ4BpfRl/B9ncuHK5BbkVsa8Kx/W0ijpPAy728fB7khHFR85ZvHFB/4/hnMBNsETKtXNZE3AjTDkBcLsRIGrqEp5soX7ek3PxMWFaYslfHHujwWFbUM0KJ8RGvUcBJwkGMcxocqNU0Lb8L5tQKb0drDTIvptlRI1k4hyvAuOSKLh9Hlq5SHwvqVnffoYoKmNz9OkSb6k+HYO/gLQgmNvZbWJbUQpvJo6pnCW5UqeWhyeFh6F1E8HG6hiOyWgt9FdswQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
 by TYUPR06MB6195.apcprd06.prod.outlook.com (2603:1096:400:352::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 09:15:23 +0000
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3]) by TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 09:15:23 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mic@digikod.net
Cc: jack@suse.cz,
	gnoack@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] fs: Replace offsetof() with struct_size() in ioctl_file_dedupe_range()
Date: Fri, 29 Aug 2025 17:15:10 +0800
Message-Id: <20250829091510.597858-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7335:EE_|TYUPR06MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec4e54a-f55f-407c-0115-08dde6dc95a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3b9l4/zx/LHpx7pwNSZDMjKmcGAgiPGqHcyz65hpHYCfgWpqJFKZtMYnKCGC?=
 =?us-ascii?Q?XnbmItTAfqojPG/t/83fX/6/Obma6WklVS5PEguBRFSuNkM94GXvZoWfZHPY?=
 =?us-ascii?Q?rgYxgZwCP3iBn/bJYLTiNmdZRgB6iG1RlFFpzedGM9RpY/OWHy0FV+k6WSW9?=
 =?us-ascii?Q?6Z5f2pWWWxeJn07nw+Xs7FvQMpOupbk4wwILkxP/bO9sKxN1oVNDh8tSxLHm?=
 =?us-ascii?Q?Ic485sAbn1tVLIUakZy3v15ehm+6FC/mqoIm7NcdXZNk9KKvRi5A5KcArvrO?=
 =?us-ascii?Q?sU5yFDEvT3gcRZtaaly5BNuZTQAN63Gm5fYD93eVS4ukUFD2Pp7dQbjlHq5v?=
 =?us-ascii?Q?+A46QlTQuIE65dY/If7yvSWlQlS4LTDmzDlVPhIc6tWtVPHpUVnRXQFX7gpg?=
 =?us-ascii?Q?09qhGY5Vs/xSG0NiO/7n4/5Y83WIRJS2DSX5mzBUrmjkiW+6YnTEbh/bO7h2?=
 =?us-ascii?Q?2v7YEziGc+CUDBUVZERNFPHwZiVADe/smlYhFBCk9B0A+ciYVgprTARhXwj1?=
 =?us-ascii?Q?ZqwlmJFf0qMYxZn/ndfvC5dDhZ3zPrU+eR/KoUHuMEpgHZHXFG+nv4fueifN?=
 =?us-ascii?Q?ewFtyCWMTRt36MQblQyxjxX+4BPeT/wBuSgX8uoh3/NlG261MXPbOK2tn/Uu?=
 =?us-ascii?Q?NznUSevhnY2sCCNCTy3iRfEuIo0wS5pFTqxvfXmeFVNlH98X7IHDEPPX5kYN?=
 =?us-ascii?Q?DCGz9TNs+6L+tNrZIT4089Xxg+dF0VeOn5bDhgSRSZENszxSpA/DUqjSc8B/?=
 =?us-ascii?Q?0/jyNWA11XHXaA0yktlSDABskcacgzapEVwjM4dOiSwEhXZuGYhUBeP4xOOB?=
 =?us-ascii?Q?XN1LV3qTa4ZZInjTzz7aGkFu8mLnMqnM1xhDR0knIDCDyZYBzXk/5N8p3tG0?=
 =?us-ascii?Q?sQyhmlrXfvb26/zlGwyUZ3Uh3gdrblG3PW9naOCdCH54IwG5Vz4VhVGvk1pp?=
 =?us-ascii?Q?DPXju0EdBTFMX/Y6+LCtghwipTqKprg5q+qIuaOHz59Jy4wGtGSm01pVi7c6?=
 =?us-ascii?Q?eYCnSwzBY1ffQLOuR+NWCCgA9SH0eFotPsD3qoWQfjznMCt5K5hNMQ9+/n6E?=
 =?us-ascii?Q?y76ZG2C2ObbJjoP1mLPXaQ3JpLwOrgvcrJsLxg0Wk7F0q0YD6B5Fvw7Ii5II?=
 =?us-ascii?Q?kd+0OtSa/lwCErm5kzo4pxp6tMyBI6o3uOY3zifcv4pTqMKFm1DD5vFaW7K9?=
 =?us-ascii?Q?z7xYA1IoatApgT2QWJlafkvW8Lw0z3RSi/U7KEj/qpnbsvPNZal70TuSh11a?=
 =?us-ascii?Q?KNrckW6rmVGQ2cPcVuzeJ7tkbmZJaVpEURUSTaj9YMgMG/u+vEf/lhFV8Stw?=
 =?us-ascii?Q?hOuL21nKRTM8UCStMHdqww4jcFpg3om30bdJFFUPEl9tNzGthfQWUUD/xYcY?=
 =?us-ascii?Q?kUsROyGydn3c4bDKf46z/sX4pk2cJs/aQg5c8QCjutBrNhLN55o2C4ZJHS0v?=
 =?us-ascii?Q?9yOCsgk+4sVm8d93gPOKqlq+weEyAeUSESb4lSz/36Tdrdzuk/40Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7335.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7T87rj8eKvE6UyTWb5ZYOtj7jeTdA/KEQYZm2F+DrJQ4/64ffLvcXAwrJKs+?=
 =?us-ascii?Q?VD0fKWWMNuh2mRPxudmEpkwnXPn09GaUPpDje0U1eOv8HwYwRuQTRgykdyOo?=
 =?us-ascii?Q?TW7pdHSxfAjLBGGAAtRrCMqpDlMHgcAKZk/OgXRRZSkOIm1JtRVHjtESxn0O?=
 =?us-ascii?Q?o1uO5Yv9iM/OBGDy/Inc5ojfPF0gucgS1UfpKCtw1GagkL2W9js62mDdlj0t?=
 =?us-ascii?Q?CGu8LoUMJVxzTkNW4Mcnd05ti9aQhAF5DCoKWtk6qnk5zE8fOBCeVxOBRZQ5?=
 =?us-ascii?Q?ibyz6r2mzvSKtx4euY5M5YzKYGMovH/fvUIjEGhoCuVZKtFmdhklY8lE+Bhg?=
 =?us-ascii?Q?Ry1QkRzBFbgmNnFujnsXTfOcZYVrbKcyK6Q/pyZfcyTYHHubTSBSKH5Sarqh?=
 =?us-ascii?Q?xY0+IsdebEisA51kEzk1cnB2lj+YoY9N41t6UcT4tZiKYKcOqb9IGktCmlEE?=
 =?us-ascii?Q?lNIU0lOsdpnsOLh18QvhuVnLSrKombLz7EJ2ILir+QUNX9KXDTxNyT/Q0KvO?=
 =?us-ascii?Q?6GioH4bv667lhmSSIeBG4Shs82dQQPKgwHNbR4qQ7VnqUPDjz46s18eGhLxr?=
 =?us-ascii?Q?WFKxSsO97ZSo3zZyaHcE5PF2SQVFnWkbBkfh3okLs3dkQXyxrzeAeXNARxWG?=
 =?us-ascii?Q?UtuEuZvmKSYmOe0hExi8U5HFBZ7iSVqB6QXOGBZGCEmfXdCI9xWb3AOQPMK5?=
 =?us-ascii?Q?5o/e8PGLal4XqofP7p91XaUAjY9HBeeEiN+ArbkPn903ao+GfMj1Se5p31hI?=
 =?us-ascii?Q?wwy+UGFadfV63ifS+ydsdWp9okKWXrFiSee5/jB2I7fVFpGnJbkMgQGGk4z8?=
 =?us-ascii?Q?h0oDc1akMUngR184LuX6xKhLdRGtTBxmSSipvN8Io2+DPJGY2iiTF5Fu7MkK?=
 =?us-ascii?Q?6K/6kmabp7rfLXkZGiD3CuS+yLgQyn5hG4fKBUxOyAAmkga+LOCpJDjrIvYY?=
 =?us-ascii?Q?Tndm1H5Tng6NcZ9cSy8AS+N3uOPATgPsNb0NyVLvmOfqaQrmkIKsPx0ChTO1?=
 =?us-ascii?Q?6yCZl3MAAe8w3KQ9ttOrmOJI6wV4QOg5pUp9tUQiu1oojdBe44MZJ/tvXXqe?=
 =?us-ascii?Q?Ld/VeXHasSFvkpntXUoLFl91I0GOmqz6gax8dQOlL6C5bl8LZmdzmfnJKSCj?=
 =?us-ascii?Q?aBqfXAvEBvIngVDxveGHd/qWieSMkU8BvBPXE0VhsIJZJk7bbBS2NMEYgrLk?=
 =?us-ascii?Q?8VFWSYpx+VdhqQBf2AZbEL0ejq98Ya7sYeNlATd5MLw1/pK73+3zOs5mMCvd?=
 =?us-ascii?Q?VsZwTRA9Tdce+/tmvqmyWqJ0bKjadOKoZf1iR5JHxoSPFo2vSsSwt6KIkXVN?=
 =?us-ascii?Q?R37w9oT+peIhTIVIh/Vix49J3Oq2+BcDNd6WfBQjrIj+eqaIWGrtjuEKYCKA?=
 =?us-ascii?Q?kT1PS1iKn0agaxRlDCQq5PIasa0iK8nfDRU2N1xHt+edUixoBLYshci2vSU7?=
 =?us-ascii?Q?VSow8tyIU4WQHCSlTZjph/IQKK2C+V1W0eDbKZUvSCcsfY+AwhEArXBDj7dj?=
 =?us-ascii?Q?NTiodSRMRKtKdelWZp23HCJtT5kJR2CnX7uCUqQnnj0vBxA+fjogxYgj/ndn?=
 =?us-ascii?Q?caNRq97RRXBpaqWsfIRAGg8ElgNwbZldfKU+l2C/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec4e54a-f55f-407c-0115-08dde6dc95a8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7335.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:15:23.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg6H93bt30P7I39ZJOTD3DCRKNNr3hXQvuBL/2dfP5qrRej63gKvps7mzev6w1SakRTdNos4T6pTQL1jaG7YGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6195

When dealing with structures containing flexible arrays, struct_size()
provides additional compile-time checks compared to offsetof(). This
enhances code robustness and reduces the risk of potential errors.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 0248cb8db2d3..83d07218b6cd 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -426,7 +426,7 @@ static int ioctl_file_dedupe_range(struct file *file,
 		goto out;
 	}
 
-	size = offsetof(struct file_dedupe_range, info[count]);
+	size = struct_size(same, info, count);
 	if (size > PAGE_SIZE) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.34.1


