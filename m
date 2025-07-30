Return-Path: <linux-fsdevel+bounces-56304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85EDB1570F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 03:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C37AAB95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3F19CD13;
	Wed, 30 Jul 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XwaFHui/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013021.outbound.protection.outlook.com [40.107.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA684D02;
	Wed, 30 Jul 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840179; cv=fail; b=V5YlzlahVcDNTfHiMiExwEXEmmL05HSu2Fb6FJ+PvXCY+7mwNprZom7H+cSIr7N9xMkW5SMMwS668J5a0xMb5KNZduklKNsTV8MP9eWySJs9fZ9u4HwicfiDfbBdZV6HSqf29nVEul6pErI60pBnwvxwvHE+r8400a97he1ijCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840179; c=relaxed/simple;
	bh=7ipKeaj+dLmMXQKihpUHP7u6k86uNoOAS1ZgT81O9JU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k7fPtw2SQhEBjpL4PATgkT/1zA3zLfFxp40SX3zyp+Dm51deUcyhRNC0uNaeDtyRhyd6C1G/syP9AeJpkItsA7o9iEGbvAT1v24SRNOzXFlq7TpQPvaLNi7RswRjkCRfdGmN5D1ypE++LEvLKyUu6bh1m/4nIgUPJ7LVYGqZry8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XwaFHui/; arc=fail smtp.client-ip=40.107.44.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDAd1ECalsfmd07xkfLAN40ervcD269euPPpqxWvufc41EkzRUbeghxzJdQYbcVTl1CNNqp0lT37sSGz86lYbexPNgPFGNlfCB2K1EFjgmPvY1rOZCiSGhdS9KTUXXDmqF6M+hfbVc8jZg2UbSq+1yhcCBU/E6HY2qdBSDbL+qf3WEwbQmR3rQyVqq0DFvkoH5QINhI8PP0AHr7li8m5bKQtmlRJDMjmFs+zeAUaww2DEeRTjjeMeSYedVWOe9IrK83nOnLpVQt5MlbOz+WfSJr0Jgpi5oxAhrNdgq7pFMaXB0sY+FQDn27S6eajbjs9y9MHocHCD2n0JivUUF1UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUdgrI5qwuwSFgOhF1zJM/5RlCz/TKsCKglBsTudDhM=;
 b=FA5s9bLGwiqD6ev9dsJ5ZSWBRTKGX9Ape8WWEnr3aat8vLH20WQfr7gkxEQyedTNvHUXGlYbmhyHZZpqDV7x3f8RZd82aQEISPMlJdV1GhwdcR+2TK/SSvLAERVxKxjJDVAkFfvx8PXxZNwHSZ6ywJUkH7kcJinxGnstNXZ80UhT8dW9MX32NEkAV3eSd7sWm3usnwIi362Jh+BjATC54ioklai0RfzL/An7r+Efv5/waC8pBaATZ2vWlrTJSZw8OZ5I99yvEODuqbAS0QMO57EJqubvqcFCJ04iafdBVFp60sHDvVt89dqp6BGyjwju6QgJCPsb/XtZ57HOSkfLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUdgrI5qwuwSFgOhF1zJM/5RlCz/TKsCKglBsTudDhM=;
 b=XwaFHui/lk12wS+T00aBUXLP7Q9aGsWH9+zFepK00VnGwcstde7dVcYMoaff0rHfZRtiyJBdsKWxPBql+c40cLnTxQ6bYRdKKywLAKbFydijO6lKMK5LzEqQ/TPhzowR30WGMUTPp9vJKKmuQAGhTKBIHVZWqJ6p7X/xU2SNAFr99Mp+6sxK2EujfcAVVix2mSUCNJSGkoHjVia8cuWRJrUvuxZIjgHccBGQ8MR4X/eI20AlfIidm+CzGzOvGglon9RK+31KU+nMbN2AHKQjWCPn5D2F0IU07te3zRu8bwyJZl1ASChaLbnARfpxB0uo3AOhbdo1RM1TIRTGpGZ+4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:49:33 +0000
Received: from TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768]) by TYSPR06MB6921.apcprd06.prod.outlook.com
 ([fe80::e3e7:6807:14ca:7768%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:49:32 +0000
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
Subject: [PATCH v1 0/5]  PM: Reduce spurious wakeups
Date: Wed, 30 Jul 2025 09:47:01 +0800
Message-Id: <20250730014708.1516-1-daijunbing@vivo.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 939bf1c7-2084-49e0-c7c4-08ddcf0b548b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UZGyA23EkDC41byVerQkNShlcGDN9s8u132XNDrNUVk54KHZFlssmaDLoQO/?=
 =?us-ascii?Q?CMJ4zFD5+STkucAQE6bxamHBB+FrT2iuNUKyuu3caekFDgRW6MqXvmxxQzaW?=
 =?us-ascii?Q?1eg+j48Ir6PPfgr7hYzR1P7rHyevOxRCzItloqmWCe01u/MJPlhqAX2c/eSA?=
 =?us-ascii?Q?SBx7fFUtgltk8ev2g165IU7es7DZynLq2+WM0h5vNIGOe/mGX3RHS+LJ9OqH?=
 =?us-ascii?Q?Oo2lfY8DM+A5i94Zc5DbKB8wcojQp3Ab7JM4YXp/73/Zdxz/dp4P0AwvQ7Uz?=
 =?us-ascii?Q?Xm/VjEfK69/YTXVHtM/fwh4+UfJeyWDkvr4NaMny6RlFQ3KOs7z/I28mYHag?=
 =?us-ascii?Q?/6Q3VMHyvfiQjDGkk7OVn+dgvA+H+3hjKmEQoh5bK+t7JRj3AhvSBrtZqany?=
 =?us-ascii?Q?UeWsnRYJq3d/h0wKnPNRDkcQPYqa4WxI57AtG1WB1zqpfZH2ih1R0vq7bRgo?=
 =?us-ascii?Q?CadTW3hxYTFRGCZV/y42TCEKwByQykOLerfwaM4ea9SEsIexkDO6zXxyRE4j?=
 =?us-ascii?Q?DPTpNsy5dPPAS37sIsP6ywlpMLc3u08O33T6ClyoJ0yAfhaCGcmC0CHDpa3O?=
 =?us-ascii?Q?+RaXOhjwsqFwjHBO+/hz9AQVTNYwV8orBFD+X2ORbuUXVJ1S2CdngVebSmrt?=
 =?us-ascii?Q?OiXQB02fOC553bZZvJ9lcQhhydHvmBv9IYMjH0FjSVq/ABtPMIuM0Z/r6VRY?=
 =?us-ascii?Q?v2xi3xjaFtV3IZY1ggNbzetQsLszqicaXkOHz1r6l3wHZJaM7PCqoq8opwf1?=
 =?us-ascii?Q?Vf1UjouAjWwxlOczGXutl+dWdFYiyTFsn9yAqS7sCKomkQJM8UNAvT8b4leJ?=
 =?us-ascii?Q?ZatddeY/Rk0vgMHKkFCNrIHpY3kS2vQ6VV5gbtrGyvBLvzuDw7mJLwXVYOST?=
 =?us-ascii?Q?1GjPXKPWsCPzIu2nUMsZR748OQacgApfbTl3W0T6BZuBCTsVzg/AZ/4JbefH?=
 =?us-ascii?Q?lyRx5SvQuMc6+QD/QXLiyRU2we7/RG/1Uom1vSNFfuy6vxeA9jwxodv+2OaG?=
 =?us-ascii?Q?RY6eMf5C+wUslRzBJx5HFCrKrVFgn0NW7C5IO+9sha44M9G00+nr3XRruTHk?=
 =?us-ascii?Q?GQnVMXkU7ByyzKfya7oQ1XGeImI2QIOPvtOoFjUE4WJxcXuvBPseUMabgdhW?=
 =?us-ascii?Q?pqezTB/S+vnfCGhQDQgvehnk2FqMcWDN8/JgyGJu7CCOKmp6CmtBlH27VraV?=
 =?us-ascii?Q?6azh8F0tInGQdQfZogOe9xYBeJVU1PrzuD0x+z3R+lLj+IZ0ERUdtXyG311i?=
 =?us-ascii?Q?0Q56JBQ5Im7TasCUm+k7djShG0HBEAKb2HjlrRi7KUohknPUjphyX+Dfad5E?=
 =?us-ascii?Q?NlCTiQTTBaUlhvQ+T9K3bo4K6uxpmPDyepAHjv0N/n9ztM/kNUSwfFnwWSmv?=
 =?us-ascii?Q?yYsdBWQeZNDTByHA+g6nzuVrnS+z979oNkcTRt+/B3UF+pSd990eCHDX6UPw?=
 =?us-ascii?Q?bE0EE3MDG4AqkOWy434331iOQGmRJmap/maJ++nRvjxEKHH+zhCeRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6921.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ac2crGrPf8JCb7LjmD3x72/g4Ql68qW3YeXehV+GvGsc0Fuyeg3V6B7/Crp1?=
 =?us-ascii?Q?ossMAWnHk2f51Ra2bCwsEiDbL+6B7YR9a24S3xiW2Cs5PfkHJQPoXteu5UxJ?=
 =?us-ascii?Q?nTqew+7ckzk98WYJurGisqVmtWmDWUHHY3FQomxfQLIjk/E6MbZN71muL4s5?=
 =?us-ascii?Q?uShodBXcvKtWI+49sDn31wVjAKCIEChcjm403/7oOIByFhjE51c7Mr4ot7dR?=
 =?us-ascii?Q?mLtT2N8KTdh89JVw88DSN56oNl5+hzPorTUKQtDj5yeCuyyk12UDXLCP59pZ?=
 =?us-ascii?Q?0b4Z+37v4iD+OiaGYDG02nZ79cmz0wDtYrVIjl5vDugQipq7IhO0p90mqUBI?=
 =?us-ascii?Q?iwQ8B8yCEYVRfH8Z0qR78cGhS0bZ08BfbbgRiM5pyIWP8wxXMV4Z2Xvt4nJW?=
 =?us-ascii?Q?1HUlVQuoLiT8NTV6da9EGRyOnEn5yDAoO/xvXj2rI/R+Ro4SKDvKwme8wK2R?=
 =?us-ascii?Q?akJoM29Lin75OEUiTmeuW4xrrqeUuABahRG36HZp/NpjzxN7G0itxJrRI4Zf?=
 =?us-ascii?Q?+flY90LFdhBQtJr5ZEeR3ihQqiKsNllKSyQ07FjAn0T1PWrgEILwdafu1j0+?=
 =?us-ascii?Q?ZZzQnCRjyFtjAvGJt0QGDTLieAWljVP/bLg0hTzD+xXB8TyVcSX7VSoFQ4df?=
 =?us-ascii?Q?URoZej0l2nm9Ky7gl/HEuVQu/lnORoImMLHZ3V9gx5thl7yHYAhVaFVejsH9?=
 =?us-ascii?Q?N4Y6NgQUBDlVJl4MZDWOs6sKcrmcA33A8PtoBqtDJacIeb4yCcbovI8KeBEr?=
 =?us-ascii?Q?J8kM/qv7BaOrPF0N6bsfixLjbLk39G0HdRhfgmG6BjUrKJ40ZfTTaPFvX2sO?=
 =?us-ascii?Q?68DY8ker9WpV8fC+SFvNAoLAh4pmBIUS3PdOykgrmfpE87PI4/lcZomEKEqy?=
 =?us-ascii?Q?FtOqhMUsUHuyzML/s27aTgEyijCm7Xuzx8O/QxXdroyr2w2TZvyD1HgLg/ht?=
 =?us-ascii?Q?6lOLbSkLl5scJHyz5X57zMS/Vbip5cdF0YgINxUK69D/f0zhIj5YJtNEDihd?=
 =?us-ascii?Q?7VIyWD90obIzoYvVVU3TbGLn3w3GC1eT9oUy4+Rb1xC/peK3b1TSrkdueqR4?=
 =?us-ascii?Q?75xHcZtvmM+hwEVSMEhj15uO1fJ6szpPT94GmcDGONw6juGjjn9Vg9dlFcIA?=
 =?us-ascii?Q?4mGpHV5xYfpXByiz3EkqFaO3KMbbtqSpvUJpxzXvrmytc7xVEzhftpxn4Xbz?=
 =?us-ascii?Q?I488Yc2QYFsUtLZlWqdqmPAmD3/4IuFexdXUIfuYSwg6bgHqXFJesykmXfV2?=
 =?us-ascii?Q?frA+BfX0Ujtp2jCEK1bNSzHMlKpbopUG1S1yoYe35+YznILLi2VTQJTZZi4L?=
 =?us-ascii?Q?ilqnU+lLVBI50qMyl0KdMlq+nP3PXhEY4rQvPsMr5x/dB6lrEkFyNtN/1Ojg?=
 =?us-ascii?Q?xhgGJYASki9Wbp9ov613vUw0qXo7Vf4kFOpyBr/3h6YN7vFa2Q/890grWOF/?=
 =?us-ascii?Q?iksuGbfL2Hyvgx7Ht/wi5bquUep4gubj2o/82QKjEo41jVAKWR/mALOIsxkW?=
 =?us-ascii?Q?aHUKInIC4t98E9lMpZ4z5v1HDY5G5UgK4PEii0MmFvizjMp7jrCmN5vwpcwP?=
 =?us-ascii?Q?dvWiG/pgyXajxK1u4W2ccPENARBMbotjnnAJqYFV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939bf1c7-2084-49e0-c7c4-08ddcf0b548b
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6921.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:49:32.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydH3lgYzgZd4eTO99OZCgD83kN8alLbsIpCqEgqfVvohcqAJaF7EkJVLDwu7LUL5U1a0Ei43X/Bl3y0KpDLmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

During system suspend/resume, processes in TASK_INTERRUPTIBLE sleep may
be spuriously woken, causing measurable overhead. When many processes 
are in TASK_INTERRUPTIBLE state during frequent suspend/resume cycles, 
this overhead becomes non-trivial - observed particularly on Android 
mobile devices.
 
Power instrumentation on my Android test device revealed numerous 
processes blocked in:
- epoll_wait(2)
- select(2)
- poll(2)
These processes experienced spurious wakeups during suspend/resume,
contributing to power consumption.
 
After optimizing these wakeups (driver modifications handled outside
this patchset), measurements show 58% reduction in energy consumption
during suspend/resume cycles.

Therefore, minimizing spurious wakeups during suspend/resume transitions
is essential for mobile power efficiency. Please review this series..


Dai Junbing (5):
  epoll: Make epoll_wait sleep freezable
  select/poll: Make sleep freezable
  pipe: Add TASK_FREEZABLE to read and open sleeps
  fuse: Add TASK_FREEZABLE to device read operations
  jbd2: Add TASK_FREEZABLE to kjournald2 thread

 fs/eventpoll.c    | 2 +-
 fs/fuse/dev.c     | 2 +-
 fs/jbd2/journal.c | 2 +-
 fs/pipe.c         | 4 ++--
 fs/select.c       | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1


