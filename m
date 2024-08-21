Return-Path: <linux-fsdevel+bounces-26438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56AB9594A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ECFB22DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A5170A29;
	Wed, 21 Aug 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N0tMedNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061.outbound.protection.outlook.com [40.107.117.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905841876;
	Wed, 21 Aug 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221891; cv=fail; b=UYDC52ki7RfHkIAeVXmMq8Pl4Ho9jYpxXQdUG+7GfAq9qJ9GcrBctQqTgHASX0lBKIt+MQh0MzISzRj43ExNBV5SOMvjnUcBusQBIyuG/LnFgWddW85SntbYCUfOj6JfbkrlsBb2rUoYuehxlkLVu06Dgo91NRPbkhWFeCrY3Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221891; c=relaxed/simple;
	bh=VwEOjeT2aw2+o4gr6xztVfFXeJR5Jgm5wFnifXhJvM8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F/eUyNLmP1x8XFyPoHDSOdjs2fgAgHzmRoMs6eLbc/8nrpDN7+XQCevZ6HCOuz68e/nK8CRdf2ns+oVOQ+aeiM6e1SPIuGmFsn9ceB1YsU8RBJO3kD1y79d8WwL8C9TLqqnB8gOJcX/8/2eO9+Kc8/vDuxODzSU+iiU6J3YBasY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N0tMedNO; arc=fail smtp.client-ip=40.107.117.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO5SZq3wFDkqkm50li7kS0xw4RBG6zsjHQYnZ/Li50LCPegiHXCifseEjqk6NEgJAFh9/6dGqghOXTpxNPkX4+KVZeUTqPCJa3pvjkioIvVryBVf+jR7bA1z+WhU/uxC5WBS7olCb2V2PlkjpTUVB+U3GupC/F5cjPcNzqdXYKRBcppbaEC/nC465srujEXG0YUUzI7C74RvmrOZ943ATy2BhwQLTlQsZBbLXSWOfh4y6ayN770mgSqpK6PGDOyYGq0F7I7bd9cKPrk4/6aaVR8Nr9d5xdFAwh5rj2bnwh5c3B7oDX/Wx/jdxpv7k2a2i8DAK1IgCmMYW0HUJNWyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGPtZ5KHbaI10cXw35+KH7JHE9/GgkJqiSKmSqZngB8=;
 b=si99n7+fPi0WnIXEatJvuWMKyVzlaP6v1A5J3kfeTq5igeIKRigHoWvkdRw5TWzZODoghr3n+XtAuSZ2Gxgdpfm8vY0kqpD31XmTLQAgXWpZHiwedtJHyxaSacj0OpJVPxYTh7EVn+GwYCMttvthHCEAKte3RE8R0B/JNYs2b3rSIjj7uFdx0uno+9vMEuLi/nM2rr8FRwcp0jT2uHxxK7lvWJcd6QqR6hJw5YIk8V9uk0qlTq40rxegOpV697Y8S614jXwwNaRz6XsruvSU0/UiQm8fcJ+7MreXsnpSm7rNjV3Yb2ATRcVOXPEZfPlbjROTcECJlBMI2ah4mBAihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGPtZ5KHbaI10cXw35+KH7JHE9/GgkJqiSKmSqZngB8=;
 b=N0tMedNOSXt6CAb4OOU7q1KZLI+jeTzX6m8JQ/Yip/xh0EJDY37kmQN78t2sxM6GK2aa+OSTBCs5ZJwDqxTUyCxASoVOFDO+LA3C0VXyixA/GmO0g2VFqbCxzin4fPlsevWeNW6enHEsuygzO1JJ4InFm06gopB5QaTJuit1e+gVIR4Vw/nR2c4JcpS862G05kZ6Jk/OdElvrJdFeremTp5t6yE4AvWyre2bY7cM8rHQA1F1sb0PZHxQGI1nfmkEOmcU5g7eBAJL1YBHCW9lCVqLDIJIcHYQJhNxGVJ/qQnd6oCWkFYKSZ6eQy7Mjq0OVjJdCoDvNha2untPJx8wpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by KL1PR06MB6520.apcprd06.prod.outlook.com (2603:1096:820:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Wed, 21 Aug
 2024 06:31:24 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7849.021; Wed, 21 Aug 2024
 06:31:24 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] mm:page-writeback:use folio_next_index() helper in writeback_iter()
Date: Wed, 21 Aug 2024 14:31:12 +0800
Message-Id: <20240821063112.4053157-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|KL1PR06MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3e7855-b544-4d13-0bdc-08dcc1aae0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXr7+SQTxa+N3Q3viKUp44dHaZ8IpDQAXjWw9Dw/j1VrRH6texa1murNNQKx?=
 =?us-ascii?Q?ptfBvOUABgj6WChtC+eIoEBdCetszAiZkru93j7msHCmUAMWxeViWANAPf6z?=
 =?us-ascii?Q?ZCNhX4wySgDwymGP1EswrsocsqsCLIYCqO+frH/SYjK2ewyYuAP9XSZVCEIf?=
 =?us-ascii?Q?ujYrBM+5iA/HIwX4zyvhAMPVHr7H/s5YPR+f/rzfDT1YeJdcz0JDPaokiNKe?=
 =?us-ascii?Q?UMqZyei/JTFnDiWQ+FYDCBiqTNH5iEiRqlsVTDWLZmhTJNlXHqD70ady6YZI?=
 =?us-ascii?Q?1/v9zaE8gjcksxoA1VwAbz9tNiIrletJu6GdwNKUONYb9RqzPSNYTsU9alMf?=
 =?us-ascii?Q?EjVCg45d0cthl+uxAirBWW5aJCc3Khv6ZEkGL+1vskpRosc97AFLVQvp1yni?=
 =?us-ascii?Q?UpU+/fg2SJvB/5VSeHvqOF0D5+h2mcvo70waxIdwTLBupTcqf586H62GEDa6?=
 =?us-ascii?Q?2fl31as6OFkjkdz9vpGkllv0DxzkA+5NurEqwF+egUlpk+ZrJUjeYFRgsijz?=
 =?us-ascii?Q?K5LJvebanoddOJ6pKe3RlFtGpJRHxaAjEyj3K2J9W9b4NVC/aN2tYYyusSeS?=
 =?us-ascii?Q?Zmj5t67m1KUNfcvuHqz2HZZoZKU77SG2IjG365Q3/6z/rCic+3OhLJAHTg+f?=
 =?us-ascii?Q?6QAs24Isc2wFLKySPHtNA03jEPKFr0h4RbCn/eoCXghMZQtOJZLLNinBshDD?=
 =?us-ascii?Q?5ECsQC5rru7+mflt3Gp52vcuXJK0gn1+C2p1HTCvq3GR/nqca+4sN8jgyia8?=
 =?us-ascii?Q?zUD/lSlbgIkMn7bJbCcs0MTLTYzP2+AJQUjvTJN1L2vFRrozDbOMqX2l2f2i?=
 =?us-ascii?Q?aP/okeCjK3MGNvW64pGZ+bU5qwC2cLaHqAua5QICu/bEXWs0ToH81jdPQLnM?=
 =?us-ascii?Q?c6CqsvVAX7BGPGzp33fYq3likfFb4+0wxGmX6Ax56EKEteWKSpvu18TNEXve?=
 =?us-ascii?Q?/ojV+QblgjYZ6H1LGcQsnSxU+VsG8zJ0UhbTwN/xp0v1GKgeO87ugMrIoQei?=
 =?us-ascii?Q?LQPaDeD3gYoh9Ozv+RP4L3wMYhIR+ac+MiTMyq5K75y8YTcL0YsE0HB6M6wq?=
 =?us-ascii?Q?gkj2vThwe2iCQgvIZzLjPZlyyq9al4deZNYokI/mi9+1xUSeALAYbQa3LP9P?=
 =?us-ascii?Q?q2ykYJ4yBwLp/+9RZUzDbzD9t/wbUWZuhuUcwwFHLN3rlywJuur6dWTVAcjG?=
 =?us-ascii?Q?LVD3fSCKCU+aXj6sYZO+qNRY4UuGl/oX9qynRmkgy5K1QEH/vtPz+u923KlY?=
 =?us-ascii?Q?rA9fE0MS1hph+l0y2BN1K7ksIbQJP0c4Bd8j/09mrSMV4N7kPLFnNTIr23fH?=
 =?us-ascii?Q?1mgBxcvipXjDbr7cO9QGyMusZL+D2jVX0SGcxaX8SabwVRB1QllKX+pB9dNM?=
 =?us-ascii?Q?kc8homeHB9MUApwiRdoV2idzE4Hy3RW3grggX60yyMCRlKTLfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?025YgeqA4K3IhqXPiPPCTWstlhiqwnhgRMvgkm+MH2oGqd73P/x4iJUI3t/E?=
 =?us-ascii?Q?EjeMT+5Vr0NVg3vQEOzN9d3k2ent1l+BomkyMMSyR6Ff12q0CC7BBtA6DXzG?=
 =?us-ascii?Q?ra5KfLOIU2lImlxmlLsBsYYM/wHyrTGZpsvBX6Qq69fmYQ9GX+0xBbZES1Tu?=
 =?us-ascii?Q?Nb8q1Thfw8rwsDUP+6CbdSGTW2pKyLn5CPjQKkVxN0Ai94oMtqZ8ipCvaPBh?=
 =?us-ascii?Q?527WvFy9k/i9DQXPK/RWoJpAH71sJyKMjhQddj8yIHihXAldHmncuvT0hon+?=
 =?us-ascii?Q?bXTA0qmXOsOLKdrx0tZ6J3ZdW7jGMtQFyp1M362bUXS+M6t8QqTMuGh+s7i4?=
 =?us-ascii?Q?UKmnGJ+enGIPl5zVtMQkfs7NbMRmT4ivQbvH6/nCSQ87syJXeZisQktO5eOr?=
 =?us-ascii?Q?5Gq6PZWuyiIvvZh7AYI8+ksPnMPODyeQPX01BHuBIFm2qpU0PqgFBwM3/w7a?=
 =?us-ascii?Q?J6lniXsv/rK0JO06Gso7t8QhWEmkxfZM+OxvgL+4Tnvtf/kdcGu1E6MKYqBN?=
 =?us-ascii?Q?+Il5GHT7CE8xuJpSuZTZJp5uvh596PzdjUS/YMJwnUL3zksPMOCpkiW++ba7?=
 =?us-ascii?Q?lAR065LeMA6PEihbYExk18SI/VBxySgQZLkaCyB2JVxLu4NR3Ut+i4/68Jmz?=
 =?us-ascii?Q?KO1hweknE+h8uSnplcNzekrHna/3T0QEOTKTt/GTYNBF82ebKx00xpSqAzcD?=
 =?us-ascii?Q?G6D4mJP0MvmrXVa9FOIxoFnzxq/Ikn/4nZMG9H+kQxk4dEiYiLezvV49vpMq?=
 =?us-ascii?Q?fop2lPJ0tQ0YWtNTi27nCil/ejFXQy6qqjqMnpuR4KP+R5lQMJyglNrawE8o?=
 =?us-ascii?Q?CkbpUfCuW/9H+exXaHVD0AjKPuK04WMEmTtIOfgbgcyYZSq2FM1GNTqg1ERv?=
 =?us-ascii?Q?ZPfnezw4jTW/rDnVKrCLcHsDdZLMNWfS21Wcn6mzhHMWHqUh/sgm6AtT+nk4?=
 =?us-ascii?Q?fqQORt0UOzT0COBOkQWEg7TS/HhIAdHOwf1SX6UYDUGukEtJHtRXn3OP9rW9?=
 =?us-ascii?Q?PLYrd6VxYU7rhq/xpVvNuJjjSSOXXUAOtg2fEzUihAeYcrLhMpa3YuajjVIe?=
 =?us-ascii?Q?bQk/q5gwFbXjO/wTQBXhIuGY4ZtfGqZnMrXm4i0k0ykKakqzw6Q3rAe9HVeL?=
 =?us-ascii?Q?txuAeTfsnViRRKyoM4v3yj+ifHJt9+AGucBuCETH1575rYtcJgj/QmUqa9i2?=
 =?us-ascii?Q?jmOBZ5cAkQ8HEqmVr7T+JyPkgE10n/Cofye6GbioUqJyS0FvmFspLCDV1q0M?=
 =?us-ascii?Q?1z2o706R3qLFEtbYBODuy8kLbKo3wU+hf/4yk3vwKCz+N7uh+6WCqzq9scvf?=
 =?us-ascii?Q?wz1ZWkWoa9nCuyx4b2ICykh0EY26KHLma0OE/ppJOMFinmZ+udEjE+jUKtit?=
 =?us-ascii?Q?fiwNuj9PdlqtuEE113lmZfGPEEvQyQ7t5QcQL5iR+NKc7P29+MXi2Y9pCqed?=
 =?us-ascii?Q?9OTnoECyfCzF8KiX932oXokThh51PBFoZa8Jwdkj2o+lCvLvkIschkXLwU/u?=
 =?us-ascii?Q?4OG8TAftsimCmCL/gnGEpDEjfscwcp7g5yxvvn8OvL+1/bBh8RVxmrBvjFX0?=
 =?us-ascii?Q?BohHAV/gqcuWmSx6MYkZRSZFqQf9DL7ZtrTZfFwR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3e7855-b544-4d13-0bdc-08dcc1aae0f5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:31:24.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvb3L+KwD8KlRf5gLLrXi29rnNX8A5TBeRU5EdEVU6HGVY7KxSeq0ZWthJjoaqV0gHsWiF6GDd2MJVTPGXviFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6520

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index().

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7a04cb1918fd..fcd4c1439cb9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2612,7 +2612,7 @@ struct folio *writeback_iter(struct address_space *mapping,
 
 done:
 	if (wbc->range_cyclic)
-		mapping->writeback_index = folio->index + folio_nr_pages(folio);
+		mapping->writeback_index = folio_next_index(folio);
 	folio_batch_release(&wbc->fbatch);
 	return NULL;
 }
-- 
2.34.1


