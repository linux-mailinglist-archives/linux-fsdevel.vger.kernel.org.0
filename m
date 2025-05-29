Return-Path: <linux-fsdevel+bounces-50026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFBAC787C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62E416EFF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6624BD00;
	Thu, 29 May 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jvjUCRzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013070.outbound.protection.outlook.com [52.101.127.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D521FF46;
	Thu, 29 May 2025 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498264; cv=fail; b=sOIvkfSjV17wMJTuGYvQSzIgW0Ha7ugvuAnODVnwPKX+Mt3l5uikOGUKDT9cB8yh303JSECRy0pMV4Z5hCQisgefuiAzMfNF9FHWdminv90zejCn0rIJ5DXc+N8PRuZkPVCEaK2XZ80vaQL89LlnsjrbvK6HPF0Hzxf74EsDtoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498264; c=relaxed/simple;
	bh=BDL1m/hb33HK/0w11ZjcnZ9/ARfEHKBiYjkk8ArwBpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BABGIlmkvTYqkxu7/tNKwzx5MjPftvPW8PveBKhZBPxdhEvHT3G/F63FNtrI2wQRF3ayfnZtwK3FQ0u8hIE4mC3nKHYsk7mkdA7eoK6Ob38lCkqvic8/9GPTnq9GJUYqb1jsdOaekybFgU4M5Lij1BBUf5ixySq9+jxlVQDTUG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jvjUCRzH; arc=fail smtp.client-ip=52.101.127.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k45/xS/wh0jFTTaGQlIAISNaiQhXluIy5brj+3bjT1KBgjL6B6s/QNdeuOOQG4Lmq4ocYIsk7YmLIrl1bGD79btBFoHw9EDUwjIynYWZMgQ4JyCBl2XJVIzGIM2RrDdJxJ5v7ldxXwwM2rXjcklu8l4esbGxqsWMe8PUUZihJIzBs0sTsCzZ4avFTQzoG7QnX3Ryvhv5EP9kGyTPvWnVynCk2l/Tne0w0mF75GMpzq6kxzhUY5+mI9GNS1HbhujhFV+3RW8/LguKGqhZ+OYhZdCXF0NJslCdhnqNPyn0tCDbeZCFMupo0sBLf7zZW+AmZEBySlto/beQG9qX5j2YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqu/0NM1cqI5BOK13LvISxwNqdEhj/CeeYtZ9T5hHDc=;
 b=Qg4SDCVdtYieoWCY4JDomBTqGkuS7E33axGOxocI0mC1aRqZetAiXd91PSKgIX+NH3VP+mAwpyTjdAHWJIyTjDX9U2BNtkWkDiz2Och/pdm3USn0V3iek9gKBmQREH8cIXY3KuhSaeJckRqiYHpIudLE9Rdk6h4D468/wyF0m3NnaEfm0Kina04dt9qbdgHxCeLIBAN/yC7Azv5E9AmGUB/qMMElA5cpyWIHMpquOYdJPZQ5Xy7zGpudiHGrRR8PuP/EelaUPA73zjgPSEr4WbHWlBvytXG34zCodd+ZYSAcOzURnRcWVOG6YKpNmePS0Rkh6xIQv/xvUjRFKkuprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqu/0NM1cqI5BOK13LvISxwNqdEhj/CeeYtZ9T5hHDc=;
 b=jvjUCRzH8QaUMsXjUeSFk2HCnVEJuIad0/LiWqp2uJD9KScyA5tl3CzQwZaSbJCu6vg/RgAmIj0CrmjgBiBm4fn7SvIzx86MjitM37dG67XFpScfLcWHpT0GlwrI99KPIPpp8IbtD+cf1ti5NEMr+HtvbLhAyBKGkio9J5Mr6MhcyMmkjnNB0miJHLnz3fCkUTSWdvJGW1F4/90YbiBnDb8FnPFtXKxPn8VXbPLZppkHvEADM06T64EUzHF9fmniFkAyYoad5c0AB4nqMjOwXLItsEu4kGjBLrBMvXQKTiNdlvw0S8Zv7PZ+KHzSAEnxlulhnDZvnoclSyXVrphn0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5599.apcprd06.prod.outlook.com (2603:1096:820:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 05:57:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 05:57:36 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: remove mutex_lock check in hfsplus_free_extents
Date: Thu, 29 May 2025 00:18:06 -0600
Message-Id: <20250529061807.2213498-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f80ec90-dfdb-46e2-ca0e-08dd9e75b625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W/HNc+RxK3BuT2Q5n4IClbU8UXNDyqi71Iw8g83+Te7GsOZeE4VwX0d2o5vu?=
 =?us-ascii?Q?N1lxlxXSj+8B3ZzFXQH5KNsqcAM+ktxh626Ca2f1ccbH3qwzC2fVJGg4VG9g?=
 =?us-ascii?Q?dy3PCzoXS0DZbKs7Ny3GXuVDg/0wvGZlKZEegr2dJwPeezYepTh09dzh19XB?=
 =?us-ascii?Q?PtwpcMV0EfwBIdshw9sJ+KnFFf1ncfoEtD8EhDVznPlQfO3Xbijz60e4iv5r?=
 =?us-ascii?Q?vqk/XRAWOTCN/4iIGwaCkt6r3y5tqKz1VPglJ4OJ6a0oUK/KBSajlCWrjNtV?=
 =?us-ascii?Q?2ewmq4d2D40o5KJ229qCff83IIJd9A1b3zFQEXp5/ksK2B7PA77Ph7Mi5DlV?=
 =?us-ascii?Q?vm5iQE4sc7EaILSmo9Qs2Lg6+vRCKjfAa1ngeiRJeC4EC8VlmJsAPrJNmD5c?=
 =?us-ascii?Q?R+d/NhpXuBAbEt6pr8WdVI+N+jAqcUsesD+gQT+CmVi8DcAg/7/j2r1vMMgD?=
 =?us-ascii?Q?ONQFB3MnhwJnmLsJ+shdYWepz8Iotf7rON8vDZD2BvvtGC+FCUp1lXxbJxlM?=
 =?us-ascii?Q?cNViCMYF3aBpkpf5toRg7EUXgtbPzWaXepK+doji28Fae/EabH9saG5AmB5+?=
 =?us-ascii?Q?S0tVkkbwGfjmP21CK/fVIiJKES0svq6AdrbqAMxTh4zaPQRNEdhbxa9HMKnv?=
 =?us-ascii?Q?tydOtE4PkWPpOMW5ZlITTGyb+x0RfkldgM8Ud74SxIv9j0GeABupDJV97dzm?=
 =?us-ascii?Q?/nuNpS4kAUgACxLmzBtDUIanWb5CO1CItRRM0AlC9USinL0hTnWfUPv9rSkG?=
 =?us-ascii?Q?WQoISjtkrR9Kg5x48pZp06qUjWNlbzeiR2sdVcAuDuuLwsQUrIGnbYLIS2lC?=
 =?us-ascii?Q?A1cJ3yfAZmeUM1f5mtVxTiuxUdKG6jqnl0UPuplje/UuffRw6MZuz2tWoWwP?=
 =?us-ascii?Q?L2KcCvlmNwWL/A0XVWo3Bx6QbKAzaIYItsjQ5sWdhE2hsYqOspueI0OMD4Qg?=
 =?us-ascii?Q?FEpomJ+8Z8M6gNbuVNr+36lYYRpbrDuGzTPgrOXJKjOCSr3jYbC+929YOqFE?=
 =?us-ascii?Q?r1fXhqeP7kb1FmccGnGAt8OQckMn/d1+2QIBSHULsIOqpZG+Dkxf3Tbv8PP9?=
 =?us-ascii?Q?51WB4LfhY5O7Hz/P0DRhTGZ50rZvs/07ufj7QI+fmdwI9EUq5hlcwg643gsX?=
 =?us-ascii?Q?qFQYmJOCsMpLTQXwT4AhQtQYnH+FJfVB1J7bKrkvpTe7E8N8IwoD43fw5TFi?=
 =?us-ascii?Q?aOrYxJ6SkmsAk4ZZPpqYfDHsQ80nuKfGRPmeN71KGH7/oFkq+2G1wXr1gO/2?=
 =?us-ascii?Q?kqF6yVDYze4y0gIwXV1BAlY+FDCwuhOpYVaky9ZN9V3XbPz6OiIZevItO/Y9?=
 =?us-ascii?Q?9kzAgen+ii1jXEkurKqLRyUx4DWKCu0dY50lPFk/t0LDMaGd88YPUja0k/Sl?=
 =?us-ascii?Q?FkbuY7bcvzmYF9FkEk+JbZABvG3mMBMQwdUc0Ojbb+bXDPc3L2yVR43tPNeR?=
 =?us-ascii?Q?99AQ6627UNa1ZR1FA14DQMqEoAzxrjZd3GO7f5dre+0oLRnKqbPbLwgioe3u?=
 =?us-ascii?Q?jyzw/BXWOmf4w28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UmuHDWVwCzp31JTl328y2r6Q8m0qAtK2QeUk6i53fKj+/ONgzwaIt/1j78G1?=
 =?us-ascii?Q?oXTEafWTBOKk5kSfEBb39m9T8ycSceAqYZldv19pYvUGV82yhfCy3/L4isYE?=
 =?us-ascii?Q?lhP3qllSsY8dBIb3M9AODSta38aDQld9mB6tv04dsIOpZj2E1BipEfcWbs6m?=
 =?us-ascii?Q?J9Rt6Gh9jblOxbM1tl3fgaHgNyONeHRnuSAWh9gYx56hVIN/DVFFxOgS61QS?=
 =?us-ascii?Q?mrzu3sAIUk7LDhJWUpANommML8yO0GaBCNrcpraJWH+njFRDyqLz1bS+r2ZL?=
 =?us-ascii?Q?JLyUKELP7COkmz6tKCfqm4gtM2NjEKhheTZlomoKKTRN8B9pCrbxm5rpL4ZS?=
 =?us-ascii?Q?dfUY1BZOJJG7O6Jw7soPJ/UK9K3FC2tJQWyHiiyfyYodgcPXdQM6Ud7FOZUj?=
 =?us-ascii?Q?b2TOx+H1N1M3ToqekoevRRknDK11kc3OV5bkbU9N/4QtaYC1LytI8ncklEUq?=
 =?us-ascii?Q?betKPM2q4TKRwEUacZTERbu4s51FetMrlsbLt62NT0si6KowV5HAiBTaG7Yt?=
 =?us-ascii?Q?LBpi/BeKqz1wYNu3tpF2h9EInnXr4xvMkM1S7czU3KKhy2pufkS5AWrbTfGO?=
 =?us-ascii?Q?8g+Ek6v60nHUUHODBIjSNu+2km1J/x2nkUMonCciHpETZpfbFFuUNMaq4VaF?=
 =?us-ascii?Q?R3i4TpcZ5NSKf5G+2fEfOMJ2rm7VZRqT/xx15M6mELKmcvOkaGLyA2dAuAdg?=
 =?us-ascii?Q?S717sW4nK25ilCsWpRhYZaano2wwZnauQ0EvMJmsjUh2wCRdIQYIdg2vZl0s?=
 =?us-ascii?Q?kqGMbDRbikW8tY771L5VhniYtYmKvJs0WRbO5wX285BIQ04IEXRgz/aC+sYu?=
 =?us-ascii?Q?uh2/zAhmgga9Y7A/FQSLL6bH6lLiJWamcR/NFyiR4P+JhEAwxjuGj/lXqi02?=
 =?us-ascii?Q?YUyhOujlKqxdei6wUkDW9E3SDoho8XPQHZjjlFI7WcgO5Ar2KE2aGsGnlNLN?=
 =?us-ascii?Q?xwQQmOWu9KF2lzS6rsB0VL/BBizZwLaIU6gyrb8j1MjDT/Zv8F0W1v6mz2E6?=
 =?us-ascii?Q?RBYtRpQ5m8yQJ6ZVmkSCiKgmrH9Az62yGvPW9azsrWFExp3RrqjA44Zg44Oi?=
 =?us-ascii?Q?IaPGl8uA6Fi7Hz1/zdfpg8Ga/BKvSSNoz0gpYP58UGTotaliXXmLYeeZY+7R?=
 =?us-ascii?Q?GyFLH7+VeffKntPcvoi+NM7ODbSxE3h1TocsGpzJUrOL9bFwbxF5VzIFKLxX?=
 =?us-ascii?Q?iwtY3Rn3TKRXXDDTMZ5d34rxPQQNdYA78TSv7vHDGgSFhWbt/Y312Ly8vroq?=
 =?us-ascii?Q?YVMyNLGf/pRe6OU7bpUbzw2b+sCVwszq/ut3EPKPieO7n5r4xK00leUaErez?=
 =?us-ascii?Q?n8SWKTZsed9TQAnX68EzrbKCL3giEXA4z0j45HCWnU+trE1uqflomsRQvXiZ?=
 =?us-ascii?Q?qzbsKBrlnz0jhRcnxoKP6OA0M2y1aExEemlySqWibhpDqCrdmtav8LpOCV54?=
 =?us-ascii?Q?0xfUNWUFArRJVk5qkCpE6Isv1NiMrX6whj/m4CYfg4388Lj9T8bdoEgree3e?=
 =?us-ascii?Q?bkqquvzvklH7KE4WquI2jFPNiEw+Ee3nLkyLJ9baeiZYe/ketVEVvo5BRIHX?=
 =?us-ascii?Q?oqEaHY9uT3kLl//uo+t/dEaJd14pvj2SMLv3exfS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f80ec90-dfdb-46e2-ca0e-08dd9e75b625
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:57:36.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO3n9w1W21NhrjL8OuAhEW/0QMiiw/THbp1EGwOUZxoZnVMSK5XP9pw+/OsuYuGDUhZ0buUbTUOhKxu8t/sMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5599

Syzbot reported an issue in hfsplus filesystem:

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
hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
concurrently in different files, it is very likely to trigger the
WARN_ON, which will lead syzbot and xfstest to consider it as an
abnormality.

The comment above this warning also describes one of the easy
triggering situations, which can easily trigger and cause
xfstest&syzbot to report errors.

[task A]			[task B]
->hfsplus_file_release
  ->hfsplus_file_truncate
    ->hfs_find_init
      ->mutex_lock
    ->mutex_unlock
				->hfsplus_write_begin
				  ->hfsplus_get_block
				    ->hfsplus_file_extend
				      ->hfsplus_ext_read_extent
				        ->hfs_find_init
					  ->mutex_lock
    ->hfsplus_free_extents
      WARN_ON(mutex_is_locked) !!!

Several threads could try to lock the shared extents tree.
And warning can be triggered in one thread when another thread
has locked the tree. This is the wrong behavior of the code and
we need to remove the warning.

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


