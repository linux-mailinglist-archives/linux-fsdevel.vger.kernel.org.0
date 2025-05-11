Return-Path: <linux-fsdevel+bounces-48681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A904AB27CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC73F1898C08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB581C5489;
	Sun, 11 May 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DYToFf3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011034.outbound.protection.outlook.com [52.101.129.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83B184E;
	Sun, 11 May 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746960533; cv=fail; b=EsDazM8Fdep2FFoRRYzzEfyoCJeQjzdNUWyZA5IbMzNAssI4/1lPuGakxxaTYdx5YudorJYHxJQr+2O2gH0XEgHkPPvb4DGV2YZIPsR9RDYh0RjwRS0rpN0LI4pjPLkEIRLX6Py4V/9asava1pdmm3O/zWrIVb6lBs7cg4zIVTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746960533; c=relaxed/simple;
	bh=KtwVApcn06oXTcUK0z81jDdbejx3PuSiWNfRUEeq1pw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jAWKfumUDcnV9wxuanTyPyhAPCNRMH4RuDENUSQhFrc40gae4oMGC7fP+iv9H8XpBKiArnngCKeh+XbWIzKaWaDt6aZd3MTgJlVyA2brWK45HvEMqwRYChkOcabjDmrUVDJGBWusa/i048LhyL3izX7neVJgLd/hLBjjTQpHooI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DYToFf3u; arc=fail smtp.client-ip=52.101.129.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcJ7IqcjByG/BWy4dmXIhTbgl2IZm32/SsbjrRbYMXU9qx6p0qDKN3Np7ihOMR/TDtLrutRjNqiQuxtq4BGv+A1lQ4NYwxVETOwR+w/WGE6Ep5dChLLyLb9wPk6f6p7TzrIq4zojA9lWgUZ9ZhTcxcBsU7XQumAAZIhvnC/0lGepJGHK+WlTJfHXq4QNxbidYH/lKcOU29q+keTVim0nLUWUaBc9IAHe8auoU6gZac8+W4aOKJKP4TiWj13EesV+HAUAuxHuJ047Tx1ot9OPccFtOHQZSDXgXf0tiul+By/+E1BMDoZ1NAwuahmg21K7IK7hfu1l+O8pD7wqsAYjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ2Qljz2qxF+MAxY4Rpmf1pQsCI1AIA2UOd24bhFF7Q=;
 b=kC4Eg1wdk0NFN21V3pGM83oOWtTz27WZNrEts7KdOW6oa3r6g1tjpXt1+ZSb/C01bGjGxpMUdGAfsTq7TdqXMgd4MfmIwgbYVa+uBIsF0+HDLuj+mHgIC+4l6gzO+2l6lVXztNZzxemJu5ncxheiELXs02fmzsWRURjlyale3OvbesB4GEdylAMUQwGWPho2YLXVruqZAv/725PW+DnieIPOJRMHDMON9Y4Q4jRzRS/Ug87fuVbXpHbE2wbYaHATw3dw/cek1ruJSZGMAr/IfS63wG0SR+Fzs8DKlFfLeVHE82E6pGAJjko1LWR9p3kod2jfWYvKhU2M0HnBGqW44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ2Qljz2qxF+MAxY4Rpmf1pQsCI1AIA2UOd24bhFF7Q=;
 b=DYToFf3uJayGmlnOGbcKkjc2cs/pD9v3dR9g9WlFxAJUkEJpIsZAF5lNOhjoZdeRN/3iNdb522wKvnSJ0GW3/DQT1NYYbq7P33VOyywbGW7ZUMASbqbq0PHmD0W6YcZJFnOMiZbFR41v4rWhOXDMnBTZktbZq45/hhiS03gM7d/d7eJOSzV+hYqBsxThEvvvmvyBoQ5hLmGkfQ7y7jh9co7YDC5DwHy0khgjizU5/yfMKZv6RPJveO7gPUpUGqKmTukezYzy1KZshD6szqub4KaIsvnbrse5hZIUzPJ8gZRRK4yuOIjpbiLPtT7LfFP9G9xWckOQ3Pwlz+QkS/Qzkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Sun, 11 May
 2025 10:48:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.021; Sun, 11 May 2025
 10:48:48 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: remove mutex_lock check in hfsplus_free_extents
Date: Sun, 11 May 2025 05:08:55 -0600
Message-Id: <20250511110856.543944-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 520c42b5-efd1-424f-eba9-08dd907968a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nncWiemWC7Yb5p5hyZ35b4i2ucA4A6JHw3rEJin8bkh2c1DYUbEsSd3LwPW6?=
 =?us-ascii?Q?5eVSxbo2VAPCIILtHp8l37IYuzCBtiwV1oSIRjit+vtlfq4gRYRgPTfBsdlZ?=
 =?us-ascii?Q?SNOojDLCEre7wu9xfGq1m/d6C1YKK6xOiMEYY5ggZjg5W1yKwHqDtsdRb6Dy?=
 =?us-ascii?Q?Vonjd7yVuvWjIOTddc2pFEwrKPPfs1iFhuLgGxxkAd3dv38v1ERDuAxaQWJH?=
 =?us-ascii?Q?rtfkRLwLFBpE8PeVZT4hdoKYUpVCavg1+rsKfPuQf+Rtt8B7vuFixoKGbQPP?=
 =?us-ascii?Q?QZaoVPDzlc751EJ0zHtel8XZr5SHAbbLc/Nm0OjP+9R3AJVkWzqOtBYpiWXg?=
 =?us-ascii?Q?+N02nhiQ5EkPBfAtPaZKlstxUUOiJLWvRhVtm0a6OtrpgYDmaBanGRqdCP3I?=
 =?us-ascii?Q?ir01vxhVnkCXwdaIrz9wYuTYMcrv4jovSYamq4qkSKxRkENlkWkFt9nF36WU?=
 =?us-ascii?Q?mF4LjGsd5bjOMIaBeV4Vs4TXRUwrVz9B/l+JqXKnOId3kSd8U1e5L3z80dE1?=
 =?us-ascii?Q?wQTmWQdVPWmjsmCVvDWA2+i/BGh0KVtg/eUgExeJo0jOOTmJ+qZheBrKQRNe?=
 =?us-ascii?Q?oQW6CztnuLT6lrK1KELQJkSiEhEXcVU/HotGV1GKg+iArbNE/H2F0IsjcNyT?=
 =?us-ascii?Q?mftgwDt63yaZFnN1wS1zNgr2HW1TbFwykD+kmr57rOhjZaViVwZIrrx36PBS?=
 =?us-ascii?Q?lz3GBOt8L9eNG1y+hzqcZekg1fHe78altBESekGT+W4AjLN/788pks3KYItw?=
 =?us-ascii?Q?RkW784SPkKXWvEThI3rQ+GbElbfiR5U3Y2w9WZFhPGWZjy5JzK9LklZIEhGV?=
 =?us-ascii?Q?7XYs32BpYZLMCJ0NL9grronrJmmMvcQJ+Knw8W7yz9yZZjRWhQPcCc3npWIn?=
 =?us-ascii?Q?mF5wTB0TwRBwTSB8uOKj/Ou0fd7GOnyBRCsTAK//OwlX7ibsaxkZTlIeYjME?=
 =?us-ascii?Q?eJZ3RXiRUUIaTiuxm1pTrHHWcgrlcn4s2DdkbONw19KN1YdTG1nLOOlBuXPl?=
 =?us-ascii?Q?dcm2d6KGBmeeYpCkiQUnRuPwO3ELiNSXfZ6xYh+bLy5p58mc8W1f9o/Wr2JZ?=
 =?us-ascii?Q?O/rvyC5t9xIpH85M/R7ZFcf43zeH7/Jqkdzqqs7EcV/9EfGybJCgIPnIdlq7?=
 =?us-ascii?Q?6gI0rrdBH3zA4sGj36E/3eBvmkGc/wxZMPo9RgK/EXNN6Q9OswZNhLuCznQn?=
 =?us-ascii?Q?WIiO2xf8hMp2+IHS9cq0br0+LNoAP52ZJCsJfGgAbvtu4JdWytOXngbSgntQ?=
 =?us-ascii?Q?oDK/4OByj1bue2eKrd5xM0RxAf7YVqTrNX55YN1oI4a1ZaXVmGEwBlJ1fpCS?=
 =?us-ascii?Q?F6iXqO/Nrs8K7ucLaZnLjaxNglnzaLT56UbITmRV7nTFucTzULSDDiq8p7/X?=
 =?us-ascii?Q?LY0WpMQf12inHSHhtSV/HeyFYVlUNy5/BlE7ZF8iiDHon/mJHjXfIaScoMg5?=
 =?us-ascii?Q?AP4o5iqQuxHmSOLPA+09lHnT7lTNkganQmk430HnItNCRFO4ujpTFvZXrsRw?=
 =?us-ascii?Q?O9aRfuGdmF78lLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvCNJ5TtL8akfYKBVDBNAeL4sIM+YfHdFVeLjLJlTi13UyDpx8/q/ycv2gm+?=
 =?us-ascii?Q?vCyF6lUPk/YHYrdz+I5MMjM7KTVfPccg+UsFaVyrzUKfKHa0f9hT0HyZxaVN?=
 =?us-ascii?Q?9lTR2mrWnNxaEx+jGq+W/kbyau/cuZRVTxJxyCy7UENfuUTSx5NEsR2XxQ5L?=
 =?us-ascii?Q?N3f3fSgSV40pVuCVZTNY/+XuL349L8Uo3wr0nVksY8Hcg6pS2XA9GNtSppFs?=
 =?us-ascii?Q?ElPZTBDmL/IXJR2K7/oUsTXqZ57mZO4pzKDThwMD8A3qpOM5fCeA1cz05qsm?=
 =?us-ascii?Q?56rRTkBvG3vHovjBUlmVvrLs3lUHnN3QOhi7GgzvNpwIbk/93OCHPitN0bZF?=
 =?us-ascii?Q?gVPNMAY1spyEY/if/ninlWspW0GXR4OAGGU1og5UkJ9stdmYUok8XnzCV7lc?=
 =?us-ascii?Q?4YSEfpTW4bj0RjaZLB3pT4pMYgxMuWO598v0WY9PlLIP7RdcBwRW7CHT7W4N?=
 =?us-ascii?Q?fFrsL06d9t1Hoec7w5/4s7+7VA7gk/GqHwpxI+TRMXrbOC7jzN2a9FOJJCC4?=
 =?us-ascii?Q?YzDal+v6iE0KuDwGR3sjGDodLj/tId9YCvTwCOTPW45YfBuoGd/Io1IJzUK4?=
 =?us-ascii?Q?+lDc1iDX4rZSusI+vsiONgQBeRDiP8Ov6fAnjEe0XglGGRMtFDoHuEu5//GK?=
 =?us-ascii?Q?Xm6ynIy4SgaEKOoZNig7kkbY1ecNWz0XO1Z4QWTxZKrZd3Vu+ad01jxh2E20?=
 =?us-ascii?Q?QIyskTyd/7BzDgXIG6VEEg7IyxPedQLnmkpbHV0VxP4XFaTKht6CqfFPs0g3?=
 =?us-ascii?Q?I8tsjy0IyaKPJPjjd/OaLXuf8rg0mRafLGtuAwWFbfgslPHSimYi4RsV/H7R?=
 =?us-ascii?Q?Xru6p+Rjgm5INugXJZ2xKv0Jtr0KSq202KJ1thVi6WP5g9Aq8Gx894OiJJa1?=
 =?us-ascii?Q?plg0msaoZVCxNluWNtvC7LhrP/81XgM7Kpr05XSef/0QHhX3ndTXLg+6B9u1?=
 =?us-ascii?Q?UvL/duBgk/24ypGu/NC6+GgTqFX/14pchA41RQ8aOM+vX3dn+dxd/R4a4R0l?=
 =?us-ascii?Q?IDa2HEjd7rwKlMm2tMmwx3KSRPsmECF153ZN2Lm+cekxmaXInDrP+Af+U+xW?=
 =?us-ascii?Q?2sGjKig0DZu9jChpmYlydRAENVaXp0LlYDKu0QQQSPvCgr0inulc5jeAi9Zl?=
 =?us-ascii?Q?fPpf1QXlG5LoU4JDuygofQ1TfipMUnxyoT/km9Xf2xEchJ7nfsBvoei5OEhz?=
 =?us-ascii?Q?K4rAQM6/mgQfyqAXNIaLWUdkOFmGWyCWUfZELoxMRoYvXu2iXF3GMwbMRkpZ?=
 =?us-ascii?Q?7So+Of8ERzFRmyLNQzkdi6J8WNfZSRQHmflUXo6P66P5yi5RTmeJloYvztxR?=
 =?us-ascii?Q?wve8Y/70TcBvi+3II7rGDw8CqHYnbN/7azcHiHTv8cCSV3x5QSvHcejTD5Uo?=
 =?us-ascii?Q?TYzvH+PYrFYFvniy7sFo9S7wNA3PUyMH54tPbESb6ldL40v7MELbJ7xUs4pr?=
 =?us-ascii?Q?uwiKpwMi5dn7y6poXxehY/vo5hURF3HttcICxDULjiYhgBn/9ek7EZzx7vVN?=
 =?us-ascii?Q?07un2KvaqUMnYN5T1td45N9ZmbmV0v3V2iRBN9Lpz5u969gAl8R4WYrLWgUJ?=
 =?us-ascii?Q?6acvnfVPMaHTjHE5zMy5gTnR5KZmKwDUyQupJamW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520c42b5-efd1-424f-eba9-08dd907968a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 10:48:48.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ/v7hvJ/8H5UsdJkC1A+MM5GANiz8hBRse4c66mckQ8IBB2luFJaTdpUkQTgu61O02lEA2q0mVYaguBjYygvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386

Syzbot reported an issue in hfsplus subsystem:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
	hfsplus_free_extents+0x700/0xad0
Call Trace:
<TASK>
hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
cont_expand_zero fs/buffer.c:2383 [inline]
cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
notify_change+0xe38/0x10f0 fs/attr.c:420
do_truncate+0x1fb/0x2e0 fs/open.c:65
do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
on file truncation") unlock extree before hfsplus_free_extents(),
and add check wheather extree is locked in hfsplus_free_extents().

However, when operations such as hfsplus_file_release,
hfsplus_setattr, hfsplus_unlink, and hfsplus_unlink are executed
concurrently in different files, it is very likely to trigger the
WARN_ON, which will lead syzbot and xfstest to consider it as an
abnormality.

Since we already have alloc_mutex to protect alloc file modify,
let's remove mutex_lock check.

Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.com/
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfsplus/extents.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..b1699b3c246a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
 	int i;
 	int err = 0;
 
-	/* Mapping the allocation file may lock the extent tree */
-	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
-
 	hfsplus_dump_extent(extent);
 	for (i = 0; i < 8; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
-- 
2.48.1


