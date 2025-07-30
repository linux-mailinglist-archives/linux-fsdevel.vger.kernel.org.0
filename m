Return-Path: <linux-fsdevel+bounces-56307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58895B15718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8407C18A6B93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EE1D2F42;
	Wed, 30 Jul 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L1qexgsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7D1A5B92;
	Wed, 30 Jul 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840237; cv=fail; b=A/juChUXawheQEBm1wE8LsTJ48F20gM2RJbgd55H2aP51ojpOOaarSkTEcuzch31sHkdL4yN6boh/Tp2XuIcxM3QyimmGn5ziEuhie+6xF2PoZYY1oMXpTVGC9AAO8AinJF8lUMbItW+enq1Nxzx3C+QEtuIwIwGOEAeXasH05Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840237; c=relaxed/simple;
	bh=GJAJvS99e/gzexYed/Z5MKdNXQBf32IkBafkX58LP2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhTMESX6G1Tl2CzrqUCvlvLiqQZqf/Vvjj9Bt0E8qkh+mLsgFHUVWZJuNW7Plj5vKsswV9hyqr2UM2bt17N5KyHMlFNI6KsryP9Cr3Si2yPLN1PZNujBUMOFXk6R+/AwcGAzGRKjIbpriP9T8vFpB63O2DTySWDYRCb6uCunY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L1qexgsA; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MagwLV6GVRwfYV/CbqhbTbkihGKn3KUl32shxb8cFdhRN86AtPnokHaA7SqE4+JIwA+n9XbvnrT6VOqYxLH2ReNWfZ0MC+Nay/+pLcrf/ncwXXV42fDOjRPDF4ngRSHAhxdONdbX4rcVrqQe3WNw+fbHAO9omJ42Jc/VRear7KhNDBWh0n5kMrsL1NUk7n146imwsKr3lo5nbLefOTnOVZg9jV7ed7sh33mZZ1crJf1hhx8eijTZJISHdbxFkw6+dgRsXCx/gzBolgRGASu6ZDIxPxiSoGV6wAYZG23YXMg1gFdRiNbewM5zNUBbAX/M1a8uaouez6X8aJDDg9PS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaNiXDIyvwh0DgiTo3pc/dSe33kJbTFQAQC4fen+oMQ=;
 b=zH3JezpT6q6HEMMx0c++L0oxV9Wp940iQ6aIX9XStiLeNqj+gFKpZ8D0adYEgc9QWSrTTiXxwjwZGagkuStP4WUQ45Hpbf+3XHtP99Ju172jy9jTm2283t9t85HhNuiJJXgujAtxdZSrubWPNZJHEvdkxHEcVcG9Ss9/H2AIFvV1Y8EWVC4BlZCoXD558qZwfadCXJ2cXl7aLZYELyuqGp29wWriZt8baNfSUr85zeD6d3MbLKzbbcRp94VakNTIlkmTHAa5mbj5jSOl1IrrJMxSMDQTP14+3pjWw/I/X2WZhKHVU0k4CUD3JLb9gtvzb7qj18sLE74LNm4JAgrYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaNiXDIyvwh0DgiTo3pc/dSe33kJbTFQAQC4fen+oMQ=;
 b=L1qexgsAGQOTHR6wCGj/34vPO5k/OO3Isq+WUrmMq4gmDpGnXII70iFeY+mhIBgL6zwdBdYbQ27Ft9hAxjJ2b/JySgRMy1WRGAdG7932zvpohWYTIgW7AEiHgsOl4Bj/8xUcgBhbvSsTwThlL1jZ5K8wAh7lti0jAp1+0PkNAps3BnhFG+oE0ddoRZ/DFnCAoEj4mVCRDA/fdRTj3juuP+HnekEZxo3WynFvNEJ7QdSdXaMzCJ+nDZZVMIqc2eTsAGGumQN+1YmZGL3rN1ic32Z3EVoOqN2OvvwDpC/7BIlCIBTzyZOb15zdXLGxkQJfUZF3r4Xp7GXV4b41mxyigg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:50:32 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:50:32 +0000
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
Subject: [PATCH v1 3/5] pipe: Add TASK_FREEZABLE to read and open sleeps
Date: Wed, 30 Jul 2025 09:47:04 +0800
Message-Id: <20250730014708.1516-4-daijunbing@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4fb0aa7-12ee-4315-a69a-08ddcf0b782b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q8LeJylw/rhdgf8XuOKX+4EZHUwn9mA/xJH35JY0jatOo9M0fCnwg0IqVPaw?=
 =?us-ascii?Q?TvatFg5uN0jKPX3g6a720ovf8EjzWo0J9RNPO5t8fQm4z8pImkVXbL9qxRgQ?=
 =?us-ascii?Q?yeCIIXxBoc9KDo9OvPcewimgt/MDGfNPsWlMDkhFMbNGWH0tA0JeG5ePBaoB?=
 =?us-ascii?Q?znhkTakXMvfo84sjXDXL+9T6EPg3IavTgfIRpzWBdOTgs9R8HQM+KdsofVz+?=
 =?us-ascii?Q?F/4b+UWTJfoR6GFjncnT5MXdQGMATAv5iasrMVyn9sHF9NsIYNZzg+8t+OfB?=
 =?us-ascii?Q?jsgoAvGyf4jyMNGRcYxZFJUuW7TERdey5r6XtsLvfjkgZOHstcX4SJbVY5rR?=
 =?us-ascii?Q?ylGAKBNC1RXo5vlD3HpDmdAhwavfVVUMnd6SM9RYAOmZ09TtNL0ZCAT4v0/Z?=
 =?us-ascii?Q?jqjRhFffnHyIJSM47yvJ460MigKI2+Ff/buQVOMwSQmDbU6kLDz9TS7LBbV5?=
 =?us-ascii?Q?sXokpHXyTCKwu+Y+UzI67Ml65AaPvaoOYPPEMpjoAotTGp1HsgYpL5EVY+6b?=
 =?us-ascii?Q?TI4gal6AREdM+AmjVRxytBFUqU8mdXqC2x7lDrFqjcOgNoRk1Kl7OeMJonaV?=
 =?us-ascii?Q?A4xUP1+Jh6RtVv1CAARUmlMrh16zASS9k5yx2Vpp7GenQLoFAPFNiktBX/C+?=
 =?us-ascii?Q?HnoJzR18YsALw2qL+ZPqVLsYmmjTQdeRggkFrne1uNHK6JXZl3VQ76bw/P5a?=
 =?us-ascii?Q?WeluMDQ7jZgzqaBxeb1eVSd948F0av9gS0jGbFFNPrm3V7XkHmoZpJBR4r0W?=
 =?us-ascii?Q?i9l5P93+7WcFa1IXwqH3DRP/yYHYm/15tBDyWDxfaLz1qbiUPiqSOYzeerOf?=
 =?us-ascii?Q?gOXl9DpJUwj/b7QpCbx27sgLBM1iTxcwGw/edRvbLqQHQw8/jkDilN77FV/Q?=
 =?us-ascii?Q?g3EtJ43DEQaenW3wDDwp6juOGD+v9qM2YCmqE62fqhrllMbzjKMzyc2jtz2M?=
 =?us-ascii?Q?QlDq3wAcpOFtGn5qD6oduqHt//kjP0Q2ji8uvdBiYWSDFALwU6zgP76YMKLe?=
 =?us-ascii?Q?CV4wqvZuWxxFKpX+NhgJHtumSqjMQxaMrlDmh5ly+/EBFUXyfWYm10Cop8LQ?=
 =?us-ascii?Q?0hNAbS2ZkiRq3m4X16G+C604UIkNS1IcJ2tyHhJ3k2MRcq4Uw8Wz7sFd5Xj8?=
 =?us-ascii?Q?GUorAN84p+dQ4Nljd7hLElrQ32kjXJ9o0IIRgvmxTYSZNPlQ+y41gjgSsNJM?=
 =?us-ascii?Q?MvgDoVODxefuV1Zs3RJGBbtP3/oaOrjkrJSuAwgzxfkpG/6U8ZNmOhcTvpdZ?=
 =?us-ascii?Q?cNbfeGJAxQbC0sJq4WpzFs7SAoa9mpmZw6L8bcAJqY9D4BHFkAkMAmx05Ir9?=
 =?us-ascii?Q?NOr2I5PqmDlS7/dEue7qAiugscbAwJ+k2Rf4j60fRaSddK6KL1Kdpgv3Fwqb?=
 =?us-ascii?Q?q2sWUq5nhuDRJOC0g1PQ6nfrNjMQMe0O3qskJzes3qVjIt4PvHNvMbxn+Mrh?=
 =?us-ascii?Q?GXjIDwakOV5lGjkOocPPZwmTHPVyxTtQSU6eeJ0tF1wkeEZjaN/9lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgdmUrkfOHQpWOYmYiFKERAi8Me6bcv66+VYURNxdBkipSI2l+bdfkiFM1kt?=
 =?us-ascii?Q?Zl7l+vvfVCNEveFy8n0zQjz8ztqMMqinabn+YH+ePrCYeAcjYWN+T1muXWxd?=
 =?us-ascii?Q?v0Ejn08huzFVjOoUltvIrzgFFQAc7jKebkiT045xE+LRd0bx+DIoDzfnSSfD?=
 =?us-ascii?Q?CgiDC2dBBmIpO8otwZ2u8CA0d4vOdjUhnu2WqIqOwA0n1C8tUUN6julRUtrP?=
 =?us-ascii?Q?/fO6Xp7IShVad3rbd8VppPX/FhaQY2Ym4Ex/GfHshsZNRNtJqb6oIE4brgot?=
 =?us-ascii?Q?R1ahCAamjPb8OsyUV1ngyNL64Jj3LkKVaZW3OECUcTwqTSkeOxNpDgvjx9rJ?=
 =?us-ascii?Q?k3sM7gKzjCBcfAA2y2mE7VB/jyCYKBaWW2zEEUMMB6YVlvYXXgMbQ849ZzO0?=
 =?us-ascii?Q?09CaRau2EM60ACDwCPOHL2+crZZprzIO97/tesjkG+INyqyVE3bO/UIJFvIE?=
 =?us-ascii?Q?L98fDQwCr422sVzXpC+tepzzKrsq+DUcWQ9uIoLP3dN56cq0Nu+/qvMYegHg?=
 =?us-ascii?Q?ZMmRS4rxyyKICOPMqbh9OHKiDEr5FtdCH2G+ZLcZKGqHi1+M1jd75MOIvQIe?=
 =?us-ascii?Q?cn1v6iTNsxDoG+CsvJ9YaBNA0RW1g0RQU2p3xBI5wbLBAOUpT+Urq1CPcAGe?=
 =?us-ascii?Q?UVHHWiwdozyt3prn5NVwMnF4ztfY6VBRbf+g21u95mQsmGF/gPJhNwWLEa7z?=
 =?us-ascii?Q?ENCoKBkYk4lgQg8Ks/TvdsA4iyE/S3gHcY4NFYn/gFHpNhr8O9VDjJ1GnS4+?=
 =?us-ascii?Q?GYMMS9Gdiw75U4Obm0otrAObf9JB8iauwBtL5BMzmjpWOMhrc9jPQKwGhvhL?=
 =?us-ascii?Q?Za56r7BGDNnXTZKH6KQswq1nEHInsEQSiak/XJBFBfE31GljyhMXaYvIuoU2?=
 =?us-ascii?Q?BkHucTCqdxQPfa7Ihqx6e8GMNn+9KRJ/naURelbC5ocDzvU3YJKbAhC6dstH?=
 =?us-ascii?Q?p8uN7Ts3G8501bzUHy0UM4VWu5a6R/LKmB7+EQ7BcY8wQVsAIVALqpqVsbnh?=
 =?us-ascii?Q?jczUZx7iSSNmMHMcxdbvMnYBEY8vs79A0tJy17bUj99uhTfoSi4oDSDiSsn6?=
 =?us-ascii?Q?yoKInZmN6Apz6dLDKMcsnifeTdHqdhxs8NWGh2ga4cckSeMHUO2q3x+Nzrxr?=
 =?us-ascii?Q?UULjz4LPySyc7yo6JJj0DI8JMFNYmFIl5Z9n098JAJeXrTOFWBnpyTv/kgsd?=
 =?us-ascii?Q?VPvE4al3nwY/nQhUFCzL6zQeZT3p68zC3m7OrgmYAlpJ8WZ/aXHh1+6MjGE8?=
 =?us-ascii?Q?KoYuImPfIFPKyHfQlosILyUaDcqKxsVKBGX3/tBwxZWwoUMVKu3vS2YYoMGH?=
 =?us-ascii?Q?P5qU79alpU4/tX6yve/ppLpXkH7f6Pn5v/cTl7l7YqJnVdNneERTNKHwi4/8?=
 =?us-ascii?Q?6ZBFL5KlWOYWgDp/Htag4LBm3DEAad9v1GZL5jHIYjTAXDvqfJZ1pZhPXTrk?=
 =?us-ascii?Q?yFvvco+ijLI92aZJ0oDxxfjSjOY1FAGHV6xwGyLMpxmrWLA7R8OXNqo9lICU?=
 =?us-ascii?Q?3qCUyBjB+9653fWpZ+9mVXE3oCzqgeNnG4+36pmwT58PxmI7KTxV5Jv3/Ff7?=
 =?us-ascii?Q?i1mKjhUJrFdY6HB4lpUHn/UU6QmV3AoOjJDzm07D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fb0aa7-12ee-4315-a69a-08ddcf0b782b
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:50:32.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vhJrwVzA6OKoCtpVbwF1yZJobjbr865UIWESL74gxwLedByfwg1sgsz7snTMhMMesiQ9MWtOCvV7JknQNf4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

When a process sleeps during read on pipes or open on FIFOs,
add the TASK_FREEZABLE flag. This prevents premature wakeups during
system suspend/resume operations, avoiding unnecessary wakeup overhead.

In both the pipe read and FIFO open paths, no kernel locks are held
during sleep. Therefore, adding TASK_FREEZABLE is safe.

Signed-off-by: Dai Junbing <daijunbing@vivo.com>
---
 fs/pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 45077c37bad1..b49e382c59ba 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -385,7 +385,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * since we've done any required wakeups and there's no need
 		 * to mark anything accessed. And we've dropped the lock.
 		 */
-		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
+		if (wait_event_freezable_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
 		wake_next_reader = true;
@@ -1098,7 +1098,7 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 	int cur = *cnt;
 
 	while (cur == *cnt) {
-		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		pipe_unlock(pipe);
 		schedule();
 		finish_wait(&pipe->rd_wait, &rdwait);
-- 
2.25.1


