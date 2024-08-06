Return-Path: <linux-fsdevel+bounces-25064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FA948808
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F361F21DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63DA1B9B56;
	Tue,  6 Aug 2024 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UhShV0xS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091117C203;
	Tue,  6 Aug 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916078; cv=fail; b=dH9MmLnpVXYP+csP67a4WwCL84VGZfcyaBaRvDqcUZgXkeSI2ckgQWzjqJao7EyCBLQ2wMU0dezRdLTNSHR6Ze4/ooqO5I2txRJQDyr+YTh661Zofl5USUk9vCVygbXJzWSDtQo+/m1njAw0zJk5Wmwfi8PZR5vZNzDZ3UoNUxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916078; c=relaxed/simple;
	bh=4e7/2OeHgmKlcfV3N/r0gft3/1w4wrx8LlCFriaga7k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gcc5eITdk9yWB/A54oqHo+b4P0dUlb27hugUu0PSaI0+KF9FPHWASuLMqU2T85gMcejZ/5MDKpU3gRT1/4jo4Um1q9VTjOHAS39M0FFJ4gfaO39nhi0W4DSsE4cBvSW6Yk2XZ5dMnerwwnNklcJhlENqOqseb8B12BI3KENf60A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UhShV0xS; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjV0VSHTN72+SAHdV/zNwAJ2Mbp46g8mJOEcnrPLcFw97n5tjDURdJGZaDLGlPubejOIoLSXksyKg0FCzTREZ0iDAtgmSiTpkNApdtrnpBZnZRabCB/0bR8L2Zv8zdHY+FujcJ+hDmwgaiNNOlMuPqfpmxzr1SzZHN2Nag8OyN2GL0QqtOoq1bDuibIAzASUO26t2BP0S51feBe37ZOomWbtHHO6esXB1VR3CgmgNUg/hTCWhHiVKmjzodxFTxxwe5tLGMDX4t8WiMZaVRdtxakKiutiUJt8W8vQ00G0gEOG6oeAtPKsAzoUdQzwKjdwHVjom4cTaqr857nQjMHnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdGJyTsw3IqWKt4LeyDAfojLrmRmKhKTcEScuIhDY3U=;
 b=aqGYj+XM9JofyuYJP4ARadOkfMFcwlHLcKab2a1kdDxLCgLOxbhLHU8JQHw5gkLZ8lp1TDIcXZD9MTEy1S+AxmXJ85j1exvEfrq6dd271/cBNZsnTd7wW7cEXRXpWQ6dEoCjBNDXM3V+BlmUa/HEJXDuZ5O8gPFwm/5Lx6bVmSjBUtjPblEC1p4XcYfIxW8zO3ZVLgHF//4VqXe7j1NUll++NVIcRUNKjehWPu7Kp4xQvOZnQ4pnfLP+ECdTI4f5rS1RKLqI2WWqk32UJEuXpN2qwqogLwj4okIdaPeU9jd+F5WEy5i3jZp+bSbSJGrNlnRjtgleAjLnYiS6496t/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdGJyTsw3IqWKt4LeyDAfojLrmRmKhKTcEScuIhDY3U=;
 b=UhShV0xSalbCDQRsoAwf2EJUAQBbyjnr4Dg0s39evaNjz9hLvpNYcoamV8rUHp1zLarVxr6BLB/MuRP3yTsIf9O9eGcgKzKZWspO57W8T9wdDHJr7SHc/ippSzlbzEM/npMfvk8MA2RQnLe+xha5YfvNuqhlnJmD0aC3wPKvjnfnibOtbWkOeGFykXdkVJ9PEglWrJsbqtqV8KQ6vcCrtMC715aVDijA2cOEkOs9NTLJLQLCQOAbqFf9NjDGv/WpiIWbzYt+mmzIhLLIBvHn54lcNL7EOm9Ors52pWZQskz4AESjo2ZCB7AyfTtCBmIWctyERxcsjC37mX+9hp8uSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by KL1PR06MB6427.apcprd06.prod.outlook.com (2603:1096:820:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 03:47:53 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 03:47:53 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH] fs/namespace.c: Fix typo in comment
Date: Tue,  6 Aug 2024 11:47:10 +0800
Message-Id: <20240806034710.2807788-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|KL1PR06MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eeafcd-8b8a-430e-2283-08dcb5ca8cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPJGZEVGQlTwEhPRjlRYcxK3Iay3qxIqeDFt5D8m/p+1JYHSW/RgtZL6CEbR?=
 =?us-ascii?Q?UGmrGwWWnvPa4/hvKAMtc68vLDSi+A5nMNo8X3gHA5KfmN48pvR72rS8tW1G?=
 =?us-ascii?Q?KKdfka6WLN0DmwJKz/WO4SJ85GJnzw5FzW9j1tMHEoD6y0XoyyZWEAQN89dz?=
 =?us-ascii?Q?J129fhtg/rtzXTO7TSYCr4beUCYR8ZlTg6iAhEqSvOgjxQhA37NSz3RbMx5J?=
 =?us-ascii?Q?HRMptDK0v3cJZtN8x0feWZz9riWdJup1dY5aJoTsOrMj/MNdtY80pr0tJrDN?=
 =?us-ascii?Q?as+m2O5oSk0ccj/L2DJn0qn/w3I/ECOMZQvz0HX0rZ8eZdFtOzbIxoqQQhhu?=
 =?us-ascii?Q?r/pIogzvZI4+JHeVsp7mUBhvWiFBMzs8W3Vb2N3iAjKkPAIWvlHASJalHEWa?=
 =?us-ascii?Q?98hShU0rHTYRJTLuMKqiHHYu4NfgvCt2z3C5I/ylb2zkNnK158XChtwcvz9L?=
 =?us-ascii?Q?R/bPVLR9Xwz4x/kLax1KL/oLZwGcosOLBIsj2jmoJztgJJSPkDujMkpdGGpK?=
 =?us-ascii?Q?GgAn+uRClnxv338Is1Flwt4gYePRZv84R7GGmWRp9v8HMYx93shdul1atZEF?=
 =?us-ascii?Q?X/WYeo8a1ZaJRN6v8A2+v7PtuLTlPWd8XtE6c+z3bboyeJ62rs6YvfYN7WOb?=
 =?us-ascii?Q?hkp9FSq3VHGKd2FNYm2HUGl9i6h2F1rJQrrHtnDqjgMWtREqxUngPAU8warQ?=
 =?us-ascii?Q?4eHYxSjuGb6p8+JA7w5Jg8Txu7Kjj/UaYQWxxYP83sfj2UkqIDD+5DPjD+7t?=
 =?us-ascii?Q?TT2UZo3rfjLd7YSb31qmYrxy2Pw8AI6VQgh2BcPDG+UH4HOBNtfLC6m4MQyl?=
 =?us-ascii?Q?1+gBNvK7USPTaEKnPRkZ3Mhq9mWGey2BHlvKMS20TVvagWCEysD/sOOB/K6w?=
 =?us-ascii?Q?VItv8fOtehcMmV7zuEnwplFEIHR3LZ7RsGU8zpZQYkGtQhYACsia2fMI4rqv?=
 =?us-ascii?Q?fi0sD7lkkjZbY4wtrllRCkLVnkGqYxSBOM88IZu/BkthEThIQGx9WfRFpeLR?=
 =?us-ascii?Q?Jh2/DNzQi5maZyTHLGYVEc1dqgEWw5ylFol3RE14c2OoGyMPTZXxMhF3Bo29?=
 =?us-ascii?Q?IptMvbxk2XOQYCexXyByvnvARqtfSjG/6ni2e94c+i3DRVY/N6uYgEnw4fOY?=
 =?us-ascii?Q?T6ukRiT7PPerISfb4Fb7WJiE55p/MjJoV/a4nZafZZoHKInWGC2DKxPqSacw?=
 =?us-ascii?Q?wnciV+kSYkvwKnB1farQk70bKu0TFH7c/BSvDzHyUdfzwqs6ceKgf+SolouE?=
 =?us-ascii?Q?vXDRN4JEJztkL9egEZaq1UjeaHk/XbYiVF5qdPqm1VFxWLREH5W5kaz4VKbz?=
 =?us-ascii?Q?t031LeyDfaBtBc42f5pyYiDSwqz9EbwNN72v59Lxmwg4WgE+HqZj7faOjMEb?=
 =?us-ascii?Q?ARB6z8dL2Bbg5N/GJY0dg/zm6qZOhP1QZfDiUp4GA2XVQuUBxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4mPUZw2Jot8v2rbGbqNn1qAEC8HStT7uZHeIHvZu+JCbakcKjrrVLtYDXGCW?=
 =?us-ascii?Q?VsKZJxCJYf6pqubBo4lk5tnW8hP1VbC6f0fSGYMV5184wjnBuhQPo3VVA6KD?=
 =?us-ascii?Q?BW5Q9rxJzLnvOJ7Y7hG+yKvsdxSPl69dObTrrV5cAbcmGBGXHUhB9WTreWlu?=
 =?us-ascii?Q?k9pA3B5LEt0SmZTN8nN1JzuWz78htq57JTqGmhuH2nIyWhqB1sh1EuZgYvyA?=
 =?us-ascii?Q?OGES5WhrzrYAMJdQTgqdFEwQYSU9xT0RDXTpIUnrpZKhsxuaTNPgkzz2b0Hn?=
 =?us-ascii?Q?uwSZRqQNG34uYfqxVx1yUo9azN/4F4ovkjfXllbQTazqCtILIwY5A0r7eoVy?=
 =?us-ascii?Q?Bn6qYsK3481D9N7lCu0hQOmY0v28bOyRC8/XfyWqORSYAEhN5PniUTdZw2zk?=
 =?us-ascii?Q?QfYkx0cKVsYFdKTEbWr5hI7OjGfuh2jGvrOwYX0lDg5Fm6nsyxdmLGd3VSk4?=
 =?us-ascii?Q?zU4O9Lz58YydYMoLhHNH21Al8svOAkBhUgrKCZh8DhmjG+wARPiJSklSf8R4?=
 =?us-ascii?Q?NQvP5RFV0Sqch2iEl7HapONaZVnfgH/Mu6CodEG2/xL4jplab7ifD3uofdxl?=
 =?us-ascii?Q?OC9F0GAOmIN6PxkiFZU5VfGBPUEsOmU7TSqZ6ekT++vKVQcKxKyqjhpM9oKX?=
 =?us-ascii?Q?0Wxw6TQmuk5rX76C7UoZ5xSqJlhUGEuDeoeitkd/nY1RtsiuWXZ8FCmM86vC?=
 =?us-ascii?Q?fhwva/JIEI3IwmKiOSuuXV24fYkjn9FPgtzHBJ5SivwjvwPVSB5jsm+JCPuH?=
 =?us-ascii?Q?Aw8rtnMco0hgHuUBZAPEHiP43s5FGWXCJyNie+/YhgAM8vvQmfL2FnoS4tUp?=
 =?us-ascii?Q?fu5hwQ93l3S0WO83/ewrmTZNakQMyzIZxozloM3zgreZv7ikdbsD2yuAs7hc?=
 =?us-ascii?Q?+ucCh2WnxEcb3KeOS3+Coj+45QiWIt6LEJ6z4XqZ8iBFiqCPrqzhJN4+CiPr?=
 =?us-ascii?Q?xRvjPkQ9j4WiNGlRG4F+hP3SJxI4kTd31e/wgK9LI78M7NFCwNnDtHFohVq4?=
 =?us-ascii?Q?gFh5E2RcBYJrAGuSf6zSsTKNx+vAKBR3SKjnwHGNpFVsEWyBC98MX9R/KbHg?=
 =?us-ascii?Q?ns0vmylSuRRt+CqsEhip5h+DnDEhttAUSTh5pjrAeEI/7b6O79QwO650dEw7?=
 =?us-ascii?Q?TZneUZr5xhidM3s/nZG3nW5TM+5ZW5ErlOLbj/agtq60Z0z1hJAaciwjAe1r?=
 =?us-ascii?Q?gaOKFHdRCR2MEegASNcVUJ2ymC4cqEbw32QtLEgiLV96C3YVYc3GyfNT3BNg?=
 =?us-ascii?Q?Ct9Z//1nJAQSRe3diat5vrYqv0rycRS7nhxj2N/mu6nBpbLVXa09SEP+i717?=
 =?us-ascii?Q?Jb2KGWXfFtHCKX7s6kk6aAY4MFBqRl/S50FWWTABuHTOl2USZvLAxf8XgCOs?=
 =?us-ascii?Q?XP7hCmeAUZWQI9fdGlVFAXzhArlsXrUxmSU7ZmVfZ9wDgsR12Vmue0E3NDkR?=
 =?us-ascii?Q?k62xUDyL1WADMHxp1PujoJpv6F9EFzmMpgwnbx3h3JbXLlXwNmRmliD9ZNxv?=
 =?us-ascii?Q?hkgcLxg7cyAxXhPKetl8EIeuQJ5WCqMulhxd9wgFcuu652pjvLYvk4LeYCcb?=
 =?us-ascii?Q?Mf3/yt4wz+rbxBDkeEhU9AGZt1XSGsTPRc3c+0KE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eeafcd-8b8a-430e-2283-08dcb5ca8cc6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 03:47:53.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JabqHisr8ZpligbK4Vr7Ioi1yGFdRSu9/35Cn7mc2PdwoSPJSe4cuajFsY4Mfz3Bw46+JLsvyPVjOKEEZA4uGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6427

replace 'permanetly' with 'permanently' in the comment &
replace 'propogated' with 'propagated' in the comment

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e81962bb7d5e..e71e4564987b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1774,7 +1774,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		list_del_init(&p->mnt_child);
 	}
 
-	/* Add propogated mounts to the tmp_list */
+	/* Add propagated mounts to the tmp_list */
 	if (how & UMOUNT_PROPAGATE)
 		propagate_umount(&tmp_list);
 
@@ -5665,7 +5665,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 			/* Only worry about locked mounts */
 			if (!(child->mnt.mnt_flags & MNT_LOCKED))
 				continue;
-			/* Is the directory permanetly empty? */
+			/* Is the directory permanently empty? */
 			if (!is_empty_dir_inode(inode))
 				goto next;
 		}
-- 
2.34.1


