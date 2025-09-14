Return-Path: <linux-fsdevel+bounces-61250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1960B5685D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDCD3B6E92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74A25F98A;
	Sun, 14 Sep 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hnSDWiKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012030.outbound.protection.outlook.com [40.107.75.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8813BC0C;
	Sun, 14 Sep 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851889; cv=fail; b=qFNd+NXn4pS0aS4l6wJeMJfOgumWkS3hNtcKVoofQxmY1Dq4jDnG69tpzMjh1gZ0AiH727hlOfzFXmKDz5RO3NIu5WX+mKlCtMP661XJSAFeqdrgKe59zOISdgwc1X/JWTV+Wq6cJ9dK7ACX874HSqOWcZU6tXvsogn3cpICuCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851889; c=relaxed/simple;
	bh=oehI0hAnwazmxOFH7m2oRtZWhYIt3V621OGbLicYKWs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ay1SsxYbyZ+4618mjjZTf10XHatZWtq4rmvMvkGNC0EyplOYCUnj3xih8+ysDn4eZKfITr6ORtCH2AuZY+QIy48Gss/qSw/B1qY6/z+SRqP/RjneBmuNRmaYxJkGko1rH4w6MBEA84sQAkBdojI5ePbYFGirutbWP5KIdW+tQIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hnSDWiKa; arc=fail smtp.client-ip=40.107.75.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqrNJwRwO4FrJ/8Ox1qLMkv074KCCtr4UJyiLWEAplFSBb9bcRfdhx8fTCkkI5Q6DA2pH3wMgGqac8oBGVG4WnotE+cqwOJeqWl8LoJNtFt13ULuaBnwFUN9O6zaaTZHmFxHmizg4Wtx1LYztzvTrhRfhHBEpRU6SvoVdyoflhuO9yl7fhRK2h1Sz6MKhuHO0dpJDWCBBoGhNw2dOfX2rNIOczZf3NGCqhL0HkYl278RwqekGRLyJfH6yHZpWgYNPUQOkA5xoji9NAr3TKfqvXC8sIjDm9GjKGpAvi684shs0/ubk0Va7GSb5PGfbah4JEMU0wcFKVfordjOcgQ5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJHvoeLWKI4kr5hT9UPD2akmGcMqLbDUN/Iflz4OY6M=;
 b=HDOM0LsjPHBEe4M9GAaCx/tlUKyI6vI06/PbM5s6skY4GhqZcaUpC6ce0U4R1WGbmKCXVRGaXALI5PdkBr2hw1YdCR6rowijE18gLFov8lcMd9wmvQM2MKBo/6r6fvdFCbuigUX1cXoHN5YKDq7ZaKcqJGXZHa/G6YIwsV6TeGObh4S370oNoJgs82kMnx0VMtM61P4pEkPW5yvfDW4d7vEUBWUu/ddsozla68Po1R4RmctnfdhEammaHo9joIOwhcRJJRLl8d/I2hA9vBUe6Gs7AXzdKRaQUJS8Z+AZU93kDjsJaOPZFlnU1jMQH1GJdAtiRZH26VSod1GbPQOO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJHvoeLWKI4kr5hT9UPD2akmGcMqLbDUN/Iflz4OY6M=;
 b=hnSDWiKaVZP82T+QgiiYrOdKRJ8yMoIeItMFPDfSrN9w2ABwgBaChovT4u76QnRb96snWpHluLz45P1vSQShIWnVdgCNJNH13kW0Ym8DEIzNPdlARsjpBxBdhNaknjrXSc1aWQi/G7EvRhmuID0bjFjV52TDpMWy2CTfvrJYL55JKyItLPUtFM0TSvhAQ/E8oeFCJg/xnl0uMEzLw6YUNav0czj0Jz1UZkONoC7wNdrIJZI1y4AN0kfpntHUfwMkqrk9lPs1pOT2naDC9Wd9Yo0qaFh0eI2HVz9/oFRBkaZpCMXguGauCXUT3R3Ti1Ep2iuWe/mUFgZgjq3T3B6mUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9)
 by SEYPR06MB6226.apcprd06.prod.outlook.com (2603:1096:101:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 12:11:21 +0000
Received: from SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4]) by SE3PR06MB7957.apcprd06.prod.outlook.com
 ([fe80::388b:158a:e14b:79c4%4]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 12:11:21 +0000
From: wangyufei <wangyufei@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	cem@kernel.org
Cc: kundan.kumar@samsung.com,
	anuj20.g@samsung.com,
	hch@lst.de,
	bernd@bsbernd.com,
	djwong@kernel.org,
	david@fromorbit.com,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com,
	wangyufei <wangyufei@vivo.com>
Subject: [RFC 0/2] writeback: add support for filesystems to optimize parallel writeback
Date: Sun, 14 Sep 2025 20:11:07 +0800
Message-Id: <20250914121109.36403-1-wangyufei@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:3::15) To SE3PR06MB7957.apcprd06.prod.outlook.com
 (2603:1096:101:2e4::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR06MB7957:EE_|SEYPR06MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c13334-83ea-4e54-6039-08ddf387d10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oBNKoxn0QsUskXNtET8HOuRKR4rtl8V+mVuBRhXmVS7+0b4gZewg8Xo/sr1?=
 =?us-ascii?Q?drETuC1+TRnMgVf3yDko9QvuTfi1SNQ9A88x2/rn51ryessOBa1eGmsMhjyP?=
 =?us-ascii?Q?yrijtfJw5+8xaOcITRe7WrmSupjm1hEISnvTXXnSC57t6EG+KThuiYDZvMSX?=
 =?us-ascii?Q?GMTityHBoTMMsQa72f/+9JKfuZgaGQwDpYKE5ypY8D+M/xZsOVxIVlB4aLeO?=
 =?us-ascii?Q?w8drtI+NjeWwfiFVIYAecVgzUERrxrhTz12kx88exFhzjE9f6l6oHUa/38d5?=
 =?us-ascii?Q?q8Y3ErK+wTL+EQGqj36xdbwmyup78tGLAvuVBUl6PZOzKVsl/Cr2H8wiQ4Z8?=
 =?us-ascii?Q?IcepUsXpjr+c71wKG7D1geS3yW7tubrA8VGvjveXKVI8Wa4cvketjmJyuScQ?=
 =?us-ascii?Q?BzZniw5OTXEoJtV5BpcutJoZx4Ngb4rgV46sBW26a/B0KptRe7YQGwsQt+Vh?=
 =?us-ascii?Q?hiql6tAyscy5vB6IB0+mqjBXMnUcqB29XgtNHalkH2QJoDfsTsKpeXryiacC?=
 =?us-ascii?Q?ejzDrha0nqT0QzVgjZw6q6kzWMllCT94tba1vbkjUGQbfgCj+s97VvutsY3E?=
 =?us-ascii?Q?ga76FzvJVKyFB/a9LeXYS9dJ/LkAAJ5AeSsNY6APBDLSCElxfrTAFymoZuXx?=
 =?us-ascii?Q?XZgXkC/lyG7zj5i5iPojXyPeUPtb2OavcdkP1ATGCrN4LDVA8ybPtsHSctp7?=
 =?us-ascii?Q?f+nwDLyakfBMlcNB5ADEDTHBn0gDrKVxAGM00XRetMh8P68jWOtUSPFj9gp9?=
 =?us-ascii?Q?27WPVVL9SpgtptXbZGKoTpnP5FkS697bBjAX4xC8hG1JJHeWS9pVz2UoGR4X?=
 =?us-ascii?Q?NMNMt1tpDgLyFR8PwnqD/1tkJdlsfmexw8ymQ3zYT6s4jC3sZpHBrk0q+3Er?=
 =?us-ascii?Q?KvaYYtyTd8OljH2dXeiXKkwJ3ZFnxgeAvM1hPoYp5jSGvH6DAop+miO1uiVu?=
 =?us-ascii?Q?a0qnkVrBqwkO/Qq0IWslBgov4WQ1xfHcsYGkugBdQTYKuMxtvIOFvR3aOJ+s?=
 =?us-ascii?Q?EPrFo1pMgyFAYQqAnHRkjeFOa5WUCcSXLHsfeZrGyCWL4xklZlDo5ibV0mXr?=
 =?us-ascii?Q?G89U7iPksbcou7zNuiuW4XQNb2/3Lqn2sZYpGWGaORlXM4uwve3i/7BeQHEk?=
 =?us-ascii?Q?Q9Qb+vohuuA7gJL1cOkc2ZYX7lo7tF6h2LV7NcDnOgwCiBoJd7SM5TqS4XaP?=
 =?us-ascii?Q?8Kuco18WsMQnh3rJSJbydof/tICaSVc1iYi8lbbxSbw8izR686YZEWud43kh?=
 =?us-ascii?Q?St3tGkjrxjuHkwgOCrkNelmTPqvvR1p+Mkx5Jcs/TXMHhQkEbPoOdu83142n?=
 =?us-ascii?Q?S+W7BjSO9atq3jbo1U2E3DCUHZ0lH1iFwKscxBfbo5rQQBunRGzPhKzUBy9+?=
 =?us-ascii?Q?GNt/zTIizWLy0jL9qWSg+0QMFcNeIqEMb1iIjEZBwscu9eFC3HWU+YEti5ST?=
 =?us-ascii?Q?K1dt4TJoGCYYeSO9Ru+E9wngCy7mgRB0d1YakBoWDSBGRRKXlo3rF/SQJMp8?=
 =?us-ascii?Q?bSC8EuPXGwCzrrA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB7957.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcm9HFt7NMXT7lk2I0fuirnjGuDpzsBJYVn9m+6hvqAZ74MQwn1rHg4TS/ld?=
 =?us-ascii?Q?mI1gGs4p7ZD+AxgeWB/5N+xgwKRJI+IqvLOSItkCE55/hJdjZQYV7WroyQyQ?=
 =?us-ascii?Q?GTg4Mfg43uhAp4TnqYCAvPJl+dxuqlPx+VVWDwDwqXt2MfDMJ7RY5ttZyQEe?=
 =?us-ascii?Q?V2bDflCVx6JlISFeTuxDn/Dc2y8LaZ4gv9NUQAIS9i3Sslv0IzgiWwxhUvE8?=
 =?us-ascii?Q?gnxGBbTN9/jxO9XH1UnRdAMpTomekW88uIMQ2S6nnP3/SMiuLnyJVV5W6jZ+?=
 =?us-ascii?Q?aQYeQep81GzZakl7kkflNNI96qUmg1kfnf397goUoVBU0lZDThRg8/R8zg+7?=
 =?us-ascii?Q?DRcUKwQFC7IOI4sQAI6mqCpgJkNaSZALvYHelFtBs5Tye6OZ4LS+xOs1uezA?=
 =?us-ascii?Q?tfm9BwpEaZfuqnUD1tJZWCGkNul3V7yVppcaRrY/GJuzMMfea1vZ4cM1y3Rr?=
 =?us-ascii?Q?1zd2knCUKp2H1Ofc5p2TeMBAAuM7vezNyGOBDQrkZO3w3q9RWXL+tpEaiwWs?=
 =?us-ascii?Q?C2BQIsVY+KkBW8It4V3Fu+k/B7Vy7ubPbBtZLLgif5aDQNfUqFqw1TLyCVsV?=
 =?us-ascii?Q?QHhH5rf0MDUfEuy9dke31jxqcYPFqK7lSY36JhHwHKo6NjK7QXBDAFR6NspN?=
 =?us-ascii?Q?G9KIU5fbaUx2meNZ/QcNPzlzegNVSozC/omV1gozSI9rBVekG359AMHx181d?=
 =?us-ascii?Q?35WKYsEiGvvze7VmUTGJxn0+Ie1xb5cPRXPgPxmfY0VZDv1H5OlJF2Vqxi0E?=
 =?us-ascii?Q?1vGZzHsn9veNdBuxcWggCq36XmHab2e38gpeycGUqP95++8iPrvJyZwvY/At?=
 =?us-ascii?Q?pv8LZ6O9I3ADHB+udOLlL3ReNydzDYqfUxgwoAbc0ckHwGGQvcw3UXh26Bnk?=
 =?us-ascii?Q?yoEFt8omgzmALGbX4496CFski0VbQXkPXgexSnbsCNOWzvl4wkp5vpQXqwvi?=
 =?us-ascii?Q?zAnRMdbedyXKlVYcZk/pa7RYMIjyTZ3Jd1agnjXWtLKsDNqjrL14oy0l0Ha+?=
 =?us-ascii?Q?3oRic3dgkPsYVx8PfAYxntJIcwLbzaAcfC2xjBZs1f3SN9I7ecODuc4Y4Xep?=
 =?us-ascii?Q?zwsz24jtcuLuCQynBni6E70FuEZqjt3cdStnraUNp1ZU3/PRc+5+2Me4Kyw8?=
 =?us-ascii?Q?WjKBWxM0tQtqxOIXUvCit5zs8/8DZSSUVsevlHiedTlHgLbmaWHFLz/hGlfL?=
 =?us-ascii?Q?FG/98ileqVAOGvYEv+GAUhTaALz8evhIziyiBwwMgy7qI70YqvGBLkz4F0Aw?=
 =?us-ascii?Q?TeHoXy1jkeBWb0xCZlLMdu5TOv7RnPVXjPG4MgZBL9jxKICigs6zqKDJ+qF6?=
 =?us-ascii?Q?8XnuBTCGTB6amxBxeE3ymFxK47jGnU/6duGclUaB/s/yklBJH7MsHJdfDwbC?=
 =?us-ascii?Q?NPPCs1e+IwGoadsDYKGAIjykA3zZBKT51ij3uVfJiMIERiKQvtEFsRxHtTCB?=
 =?us-ascii?Q?jzojW3Iywhamh2/zcwQXSWXQdTWVMjwyEQQWCcJRN/2gY5CaO548utwTycK3?=
 =?us-ascii?Q?o3w7hPRYSgqcPc6RqP9fOgnoUy2WJhW4tVFeFH0Z8N/UbEdsU0VwXBU5FDUM?=
 =?us-ascii?Q?MlhTlIXQiHwj+SolT1Wm+XMEV8w1tnw1t2xtnab3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c13334-83ea-4e54-6039-08ddf387d10c
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB7957.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 12:11:21.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfoculwDfT6ldsrjzdA7thR7i977jtCMZiusXvTfgupaPUubzXMDBDL+xrEHm8LKha/PXYQWt9H/CQws8k1kjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6226

Based on this parallel writeback testing on XFS [1] and prior discussions,
we believe that the features and architecture of filesystems must be
considered to optimize parallel writeback performance.

We introduce a filesystem interface to control the assignment of inodes
to writeback contexts based on the following insights:
- Following Dave's earlier suggestion [2], filesystems should determine
both the number of writeback contexts and how inodes are assigned to them.
Therefore, we provide an interface for filesystems to customize their
inode assignment strategy for writeback.
- Instead of dynamically changing the number of writeback contexts during
filesystem initialization, we allow filesystems to determine how many
contexts it require, and push inodes only to those designated contexts.

To implement this, we have made the following changes:
- Introduces get_inode_wb_ctx_idx() in super_operations, called from
fetch_bdi_writeback_ctx(), allowing filesystems to provide a writeback 
context index for an inode. This generic interface can be extended to 
all filesystems.
- Implements XFS adaptation. To address contention during delayed
allocation, all inodes from the same Allocation Group bind to a unique
writeback context.

Through this testing [1], we obtained the following results. Our approach
achieves performance similar to nr_wb_ctx=4 but shows no further
improvement. After collecting perf data, the results show that lock
contention during delayed allocation remains unresolved.

System config:
Number of CPUs = 8
System RAM = 4G
For XFS number of AGs = 4
Used NVMe SSD of 20GB (emulated via QEMU)

Result:

Default:
Parallel Writeback (nr_wb_ctx = 1)    :  16.4MiB/s
Parallel Writeback (nr_wb_ctx = 2)    :  32.3MiB/s
Parallel Writeback (nr_wb_ctx = 3)    :  39.0MiB/s
Parallel Writeback (nr_wb_ctx = 4)    :  47.3MiB/s
Parallel Writeback (nr_wb_ctx = 5)    :  45.7MiB/s
Parallel Writeback (nr_wb_ctx = 6)    :  46.0MiB/s
Parallel Writeback (nr_wb_ctx = 7)    :  42.7MiB/s
Parallel Writeback (nr_wb_ctx = 8)    :  40.8MiB/s

After optimization (4 AGs utilized):
Parallel Writeback (nr_wb_ctx = 8)    :  47.1MiB/s (4 active contexts)

These results lead to the following discussions:
1. How can we design workloads that better expose the lock contention of 
delay allocation?
2. Given the lack of performance improvements, is there an oversight or 
misunderstanding of the implementation of the xfs interface, or is there 
some other performance bottleneck?

[1] 
https://lore.kernel.org/linux-fsdevel/CALYkqXpOBb1Ak2kEKWbO2Kc5NaGwb4XsX1q4eEaNWmO_4SQq9w@mail.gmail.com/
[2] 
https://lore.kernel.org/linux-fsdevel/Z5qw_1BOqiFum5Dn@dread.disaster.area/

wangyufei (2):
  writeback: add support for filesystems to affine inodes to specific
    writeback ctx
  xfs: implement get_inode_wb_ctx_idx() for per-AG parallel writeback

 fs/xfs/xfs_super.c          | 14 ++++++++++++++
 include/linux/backing-dev.h |  3 +++
 include/linux/fs.h          |  1 +
 3 files changed, 18 insertions(+)

-- 
2.34.1


