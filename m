Return-Path: <linux-fsdevel+bounces-56306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006FB15715
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5144416BE61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075201B6D08;
	Wed, 30 Jul 2025 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cbiPTLSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09084D02;
	Wed, 30 Jul 2025 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840227; cv=fail; b=SIYB4HaVsgl6s/Mvxe/UMi/IX3BnC2lHyOOifVJ1yOgEaFduzL2qNKaDXMPS/Goh7haQfLGRjcjqBoISRsksfocxKZTJUN/ZpZwx8ES3Y0hdcUDtLnAvAsMy3Vba9EgmvcoBWodu5A4Dn9kMZ7dlQJmBacJ4vGf5grbH1BLWfDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840227; c=relaxed/simple;
	bh=ShRHkYAnt8RsjLcJMLCIy5Q7Q9wPMsUPqEBzKzTYb9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JY/32fITZa+jMbAP2s4PSfg6qtm0GdbuG0t539cLumtJcHlF1UfHf7mrck7kPGJB/6porkw3M24KiMZPkc16ttBZuknU6Vg/cykf3SHTl5hsiJFZfuy+tWdhlYfZ4AzhyupNlbdNUB/Dvz4Yy396eP0axN8aHrrylFLf8X6W2t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cbiPTLSp; arc=fail smtp.client-ip=52.101.127.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeI23Vn0B2PkdjU2RgiH7brsASGk/TA17cJ9/LhWNg479WNIBs7s+6GUoOBFFk5OjeCRQfN48ri+kR/3n82AKQ2RISO3UlzcLsCXoGZVtPTrecpiCqdLgRB+oGCFtK9cIkkbzn44qHic2x9D4Rs79W9H3LW2HkqWQc5jdzF0lRSJ44yEN8dKAWio5nDSKkysJdQPqF7qiDGl4+1zkrdP8Dhgb07ZOgop9L65+L49CMp4XzRPtKghuqADcIL+4BsBJ9MqsmK8Bh3zJstRGmXLSvIoRv/T1ww3EcyvkqThQVsnTp7q98dwZj78pbENunxwTFBASH6dacHmBx8Yp/Oysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2ocQdS7jI96UgkaXOZZDpm6dOXPu/CrxsdxE1FEKPA=;
 b=ffwLqk+2bzrzMy9TxlLmxeb+zU8OTPAMWiq1Gyo5M5xn7KEjD6KifDNeG30y72bhMdV3KjVrPCgR4b8bxx5KS77iRlEi+Y0nmEm4dKRfcgE5XN2ekHuAx9dhtbArNC7XMUxTkQeQO/Kf3zsXf0VfL7WYHGKlkyq+xqzSN4A0Hj0x8qSNJfQ2KB9sr3PBXujMYYDnnUgrOKP+diyQwf45vV4e1ewdpbl0Kz4CDc5SPm90K70h1PfatGc4gb4ZUo6UCZY9+E8Pa/ZfGj+MOlJeXLzghc2P8W9zs/reLB6gg9cR5SYUVydcBUkp8qzAQH/PzrnUNJf/YigO+PK8obr01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2ocQdS7jI96UgkaXOZZDpm6dOXPu/CrxsdxE1FEKPA=;
 b=cbiPTLSp9UF3TFZlOSGw+t5+1PQysliE+/RmYTkG92hE//ZPvm5azX68ka2NdAHBAEiWA8zIAGhsFMQHguoXoO33Etxx13ck5ncm+lA5oAh/4Vj8UIhYGir7USJEBHR3gJnJRV+7rqhjmBxoQ88zlQuFneK1nHGH4MmjWwoJgtc6EsA/zEdg/HuAsCJX2NSXCk/obSjN6kiNtp4obMcruoFDsQ7E3VafiUijkmpCbJwQEAPXmKuBbmxLgMBWjU/KGLiDgjFP0z1dNiI0WqLSkCQ9KBNP3h/oGTtme9Zv4lx1kRVcmIHPVlEbIrlIXs/LinJpAQxRutEJViUf7Howuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:50:22 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:50:22 +0000
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
Subject: [PATCH v1 2/5] select/poll: Make sleep freezable
Date: Wed, 30 Jul 2025 09:47:03 +0800
Message-Id: <20250730014708.1516-3-daijunbing@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYSPR06MB6921:EE_|SG2PR06MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e9557f-a56b-469b-f2c7-08ddcf0b7215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJx1fNHy2uQU12J/Ykt3qoZHpa71+7sb3tKeAfIHrHgeNEI2VT0GEJS5CXpi?=
 =?us-ascii?Q?Afmakv1PVrioOlUdgHStDCBs8Rqe2jivp7scdel9CIwUv0aw6IpoZ293TOjd?=
 =?us-ascii?Q?BdyFkA5E4irzKSCneLQFiNJfUrcTxWeXhu1BpxnHUMx+EKzi25z7TGon/di0?=
 =?us-ascii?Q?8MSTEJZToAO/ta7RpxXaA2ZdAANxCfx9QbtAmD+VrPcXf9n0cHfYCdwNt+lv?=
 =?us-ascii?Q?EWvCRLTlzAKHGAX6SLB1AvKNG2FtdLl7jx4vXPihEyS2XHkcIQ9CqFahe+wQ?=
 =?us-ascii?Q?OkSgF46p/7dOq5V1VLzRAW2oFwy/yDufEzAg44pHrzEBMT8HnX7OtXH2PFIA?=
 =?us-ascii?Q?XA/Gw/kb6rKfmXhM72SEXhnUz1Ww2PxYIjNDBye0ft5+VUpcwzThngYX46yN?=
 =?us-ascii?Q?Fl4eqUEv4nHzSUYCfbyXQHaZrrNGFSTePOW/zpH5uU4gKv1svoLllH560AJK?=
 =?us-ascii?Q?v768mr2pDPVO+Yo+CwsK5c7+Q28xG5rKItPZU8FFGUlevCOPeyUa/8f/MpzE?=
 =?us-ascii?Q?4iv1VLYv0vnrpenp3ng2YwgNI6SeFvPa42jb9BIOU+Uhux7lnC9IYOLqcOCr?=
 =?us-ascii?Q?Kym633+PVzp+I+q66E+GYQHPoCPs4rAOwAZ0aY9wuPRzOnH//SacDDHrqQ+C?=
 =?us-ascii?Q?9QmMTL2m21JTTChPryLGWJaDpzFzuwci2ynMl0QPMbXw/LUN/shskNQkVRF6?=
 =?us-ascii?Q?tUkLWmCHCMAmNI6BR0bTzo8FtymOv6jQv1lPLDepVnkHSTj5SOoegKpbB6kg?=
 =?us-ascii?Q?UlDYx+iQEGXlNRT5/yo/JyKpvZmCzZ0nOC4zKZXeNJHpSv1tVMERRSIBlpOt?=
 =?us-ascii?Q?9LIz7nPvutRt9TlBe5d1d/NRo5D/EZKZRDeMgWuvez+fabPHZkSeg3y6kZZ7?=
 =?us-ascii?Q?56me+saaVXtULagwfOLoGtpHS1YewY3MEvL4a2KgySRaQhjOYxcL0i3yYjfL?=
 =?us-ascii?Q?nAIhbpdG6RwzdLAIglPmdVAHGTpgeptHvwi96p8WDyvCIzm/WYDL3pmNcy4D?=
 =?us-ascii?Q?SP/Buzg+ZORQR8OAzxnAi9leHwfHS5qXv77IJe4cB3KVymgdN74bS7NpFSTv?=
 =?us-ascii?Q?LchtaBZ2a/VEtQSIbRLTURz2IV9NxxCwfQyJPt/KQZu6ZOpeaapINOr5SgGo?=
 =?us-ascii?Q?4LUFb9nmK/ct+EMnOcQbOzqtC8OoKVeUu59d0pO8fqAkRvuPJoZHUJp5b+6T?=
 =?us-ascii?Q?w8i+XwbQEFh5pvyF66n8gVB18vjt2GrIdZi7z3TbYgKH+yMVw/+2dj/lQEoy?=
 =?us-ascii?Q?KBitZjd4jkK0Iwb5en9tShStrwWdpHnG52gdznF5ZhNhIdwQb9IKED+iR5Pn?=
 =?us-ascii?Q?FFAzUmjICvgOf6FI102U3W5e6s1N+8sKFqXE6wV/zUd6Cx9QAndge09FWUoO?=
 =?us-ascii?Q?Xt8JsBesbSdd2Btw/5QEk1IK8arHnVBqOSSrSzTzxhxeL6sW5kY9u8q3ILOx?=
 =?us-ascii?Q?O7dnN3xeqHOgzdHUXsZExy2ohPVg8r0CduFh7wsbGoRr/nXfGI7ycA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxlccfPZKurY52izbmxzCfc4NmNENP0l7QdlDP4YTfJAnOUvhR1Z7nkUS4HL?=
 =?us-ascii?Q?soMpsD01gpdkXA8dvkmDwo1KPC8BP2NR/AztE+SR5AB09LSfFwoIqbEVpa4/?=
 =?us-ascii?Q?vbrUhgLxdMb3bAnuVhDqdo8beb3ytj8s1Gd2dRDGU2L4uuD4mKwNG5ypizie?=
 =?us-ascii?Q?aouID9KraE9HV5z75MtzlB4+Pn1rGzdwOhdwfAw1ALl5w2OjzCudlzGEJv1s?=
 =?us-ascii?Q?cSBh9ixcD2TbU4nlx4A/V95akwNMePjZUHDqDMstVk500hvp2wB2VcQLESAd?=
 =?us-ascii?Q?F65lL/+PcYSbC8Ek5Ms+24eg+o+//nxVTnQVrvPYPz/Vbox0Ai6DUlrP99kh?=
 =?us-ascii?Q?tzwC3SfBTdTuw7DmS6aW8D+EiKbUpD2iLO6f73eXaZvymQkspnRWxm40QuQa?=
 =?us-ascii?Q?Oalwz9F+KiHlyXq9EAV1+2XBw8M+vYLbf2llsHIYBl9WMxUIZkKQKn/7C5iK?=
 =?us-ascii?Q?UiqAz7eT/Mj3kfUi6iEuFOvDmJhqbkpBtL4nxzcyHggpchu8sfSSEQiJ66k5?=
 =?us-ascii?Q?ajocVlHC5OYJ1GR79EcSKln+3I+xT5pApdMNFsux9KsdSpxIUAK46cI1TDtk?=
 =?us-ascii?Q?kevjBzr3AOXf7lQqK5tjNNX35+l0KrjpfQ+GlH2u456m7+MprVZB/n57X5ZK?=
 =?us-ascii?Q?2ipunMjHOFf6vrfxDx4E/kToxJbNjQWk7KN+Dd1FaLcurP2UhiMnjJKWbQCb?=
 =?us-ascii?Q?VdW3WYTsvBHbyWaAgFuDZhGW7jU83ZoCC9LZBh75Vfxzo9QExzfORUfxb3QW?=
 =?us-ascii?Q?R+eeO68DQzM5q8AZUPf9ABFA9RnJOmn7PSPHul9ioVwSM4rI/yzbrST1XCPh?=
 =?us-ascii?Q?FELQ6bUo5ZoZuBQEsMp4DBn9KOXKdIYITBNhBXbZP4Ca+ax5yV6LOQs4SXjT?=
 =?us-ascii?Q?YhwdNYZ4d5bQjB/Q4WYropkspy8XXyN+wLwygHRCT8CObV6xWtejnP/Q91Ch?=
 =?us-ascii?Q?jj27+U5BOpGag5muLM64rkiF2by4oE4tdz/qWO/2Gff6fI8FNlctq9kPlICg?=
 =?us-ascii?Q?zJDdTrYZDE+mde4B8Co26PuwomHu8pSbLkEolk0GzbhAViAx+4ZG//tlG9Ri?=
 =?us-ascii?Q?Q77BeZyd1/ggjsKWeahFwPYFXQT1pZsuGexulSS2Mmuw9m85H6yhI7q/Iqe1?=
 =?us-ascii?Q?4KSrDw/6nwJaqTThyUNfay74F2KgBNY9MRpEI4NVNBp4sXsY783ei2W0Aifg?=
 =?us-ascii?Q?mkhFMd5wyPFKxkCAFHTsFRQa2yo2mUMYBJ4cMDnar46lmIDiPvdv5lhkMr7P?=
 =?us-ascii?Q?IKAmnj4VgWC+Zyi9KymB0EfY3skQvck/l5oPhFNrBaK29itU4B9AzJ9UW2Np?=
 =?us-ascii?Q?4N9df5FefzmChLsGWaKxXOeV+Te0T7lBYoDWyjrF48j9YFYupv7sgQJhhBqe?=
 =?us-ascii?Q?g5o+gWRmKxa4Or2fo9TauI0rLsbfNYRgmzcnJ3br3mgB6s61ia6B+OK5nMtc?=
 =?us-ascii?Q?7DsXOL5HE5XtHQZVrGOqw+hRak9Kv3V2jsIUsJkY1ti31ZEhmvubXoj5Ci6Y?=
 =?us-ascii?Q?oCqTKHuwv33lAT63daVTm3sSzlPve+Nwn09GT67oFbM2qd93lnmGWDo9Ulzp?=
 =?us-ascii?Q?RaY+dsuTYxFJ57EnGMWMj3eXhcMaSAIw0yUSTWD/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e9557f-a56b-469b-f2c7-08ddcf0b7215
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:50:22.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKFcNTwrUbARjesG4e14dZLf1DCNy4bchj3nJ6cN59NqpnBSgtpKFsJX1nKxVla/NtRWvhe8UrdE41CAKac+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

When processes sleep in TASK_INTERRUPTIBLE state during select(2)
or poll(2) system calls, add the TASK_FREEZABLE flag. This prevents
them from being prematurely awakened during system suspend/resume
operations, avoiding unnecessary wakeup overhead.

The functions do_select() and do_poll() are exclusively used within
their respective system call paths. During sleep in these paths, no
kernel locks are held. Therefore, adding TASK_FREEZABLE is safe.

Signed-off-by: Dai Junbing <daijunbing@vivo.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..8a1e9fe12650 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
 					   to, slack))
 			timed_out = 1;
 	}
@@ -955,7 +955,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
+		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
 			timed_out = 1;
 	}
 	return count;
-- 
2.25.1


