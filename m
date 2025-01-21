Return-Path: <linux-fsdevel+bounces-39771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224EA17E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0194018887F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104141F2376;
	Tue, 21 Jan 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CCR8aEK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2028.outbound.protection.outlook.com [40.92.91.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2D1854;
	Tue, 21 Jan 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464466; cv=fail; b=re6kMp0EqLDAJQbwjumE/AGkNeP0ILiwj91iLHvOQvb4zCj/HvmjeOmYid10d7jH51GdIO4TmEqDNuL5xn7MTXQBh9EhJmVxFkzOt4CA33YzpEpZc8HT9r3/6aGJkevdYDSF0gmtqXDwUspZUKG0TrCPd9ZPXZcIPNn3s7149Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464466; c=relaxed/simple;
	bh=FWHCEwIM5G/f0lxre4WJgUXEeAVd5dJadZEev93eZmA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EwME4Lu23RgCB/VLkEk+/P5EwzWfEKWWQYZZbduF/YG79i+/y8Q7yk/r7/xY1IqgyfSi8SMZEt/jD81TTk2viHhxd/3HwrDWHuasJOLf8+bpiM4c2rpTCQFF5gVerlcwTjUKW08wyA8xkoHltncdTf+DPo0VW/wdcYqktcIF0LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CCR8aEK1; arc=fail smtp.client-ip=40.92.91.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gE1TKuk2EzHkaIOUsYXmCH2xDLAftpQXEx/DixQdCby+ywvL+FuvwCyEEDNz128HYLt+gU/cmKx0W9nKeJ45pg2776/oegianxGaEiOL99peYgyWnnnSJ/n8K2+W7PZO6ZGiwylinN6Ka8GT7fCjHpzXs8UBQDlN1dRrba7zfj/dM3SHyTLwt0HCuwz2V+sS2n7QhTJKXw9H3rRay6NM0t8P6BO4V24YcKNKBNVuXfdxNgbNP0WP66TWtw9KD5YzNLkbjrrg5ei9vLo384fQMgvPwozvZsUSV5JFjCVc/awwxhyZndT+wycA/0iAXUqp4sjXo8ekPfkzAEmtTvsexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2c2URC/WKyo7cSe53XMaKnX54UY9h70kq24z94n6FE=;
 b=RJVcy0f8cCtjsivItIMX1qWJEOiQ2gxoYp/9/B+iw9sCxC21s71g4JQKJ/utwS5qM/E9jCOzCb9M4xZUVneyujGXr28fqdTmTA41oYR7/rtYn2fcID+C5c/aC0WBhHsC9GbGOkDaqKJxERnshspgZNc4PZuFdW7dwH+YaJeU0OQf8ilN+Igzq+cch7xNCXNJUMCi21a5S0lZpkPYKV8veuRIGB2NrHrCv9XhdLBrrcTMp7X2C0xRZ6JEjP3InuoBntRJS7DOzA/0xMncwYGwZq+03n9w+sC95sdgYGwVxASPiA8SLEHdTc+oQ5lfsmBOUeN6BQ/UT3HkOIvwjXsLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2c2URC/WKyo7cSe53XMaKnX54UY9h70kq24z94n6FE=;
 b=CCR8aEK1ysPelhVuiOyvwOPScjyvgUEvZdNe/ZaRqGd4Ot10rLTlbmxYO7xo8Ad9FNIuQatD1OR9WL4VP8Kyul43w0C3bKDrQ000TbPZqCGbTIWEGjFslphU/3f3+Aud2g9lALrLziZg/hfmmY7vdrUKNKey0pRl7CGg/OtVzW9TXsBz4CEB5MKBTyrUr2i/oeh6IstWyu0XPmNmrErilbe5qOT5n6PNeZvsNr51k6gO51JCiUpytTuBxX7sHTu0lecdezvf3bAzDfxqPVlG7r7FNKd4fwQfkLwLmksufIIduvbDbYy3ytZpenWNeT5YJV4lhSryvMlspWNcRQf2kQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV2PR03MB9884.eurprd03.prod.outlook.com (2603:10a6:150:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:01:00 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:01:00 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com,
	brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v7 0/5] bpf: Add open-coded style process file iterator and bpf_fget_task() kfunc
Date: Tue, 21 Jan 2025 12:55:07 +0000
Message-ID:
 <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0454.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::9) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250121125507.90160-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV2PR03MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbac3d9-d604-4c10-7cb4-08dd3a1ba74d
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrATxzuLOsRLwngE0whULbNMce8SQ516678XiJCmQOSIdBzeE9JzRHz6rO7a5OzleR5N9wYM6I8+O3nhFXSCDlgENYc8MT9swBiycIOOjqgib4aRq2hoKSMPqpJjX6csTziDefXuRuwvqoLOCX5NH4mNyR4ACq49/VRbdoEywXn2G9hr8sOGmOxgcqjXd+NeSBRPsA74qVsEpCnkRYxilkTG7Pxv5W62Xw7QCY7g3yY9gp0A2j90a8VmapNvYvN7NBM6K9I6X2wwPl79pnjbzAdtWbUPnFcWc6TECszZw67e2D6gOwpn7NBm/HtvdPFuEAa9s/LP5tCKP4qeQbyhowgwDdN/ke515KzA/bTbBoMaxQkas/Hb5DdWyd4YHOk7qZgmBH8zp6ieY6v0YUwSj96pV9DibImHCWDWyr6QT7xhnhZRVzuVuvo6D817qhHMjUiTy/kqY5VBqM7t/r8O3G5a5TlcBlTBWAIYHx0ru/Yw7GcQkKaowXAoHHkea22LmysTH9Y1JjCTd1M9MMjRkjpjDHtKrCzBmADFCpV4w/WTDAuoSdAPRuLk7A/67qRMhIF3kkai0cN+5YZax+UBZDypXysQD+mlxL2erKbdigl3imLAbe7NWDgLeoWP6o4OeXXsSvSOjIsm4RryxswTkrKSkO4fPGUMVkJ42HLgwDSbBUdteiwHvxiIqrXdUSErZ/vckNAC59xEvJ48iPJKUyZaGGWcyvp8juxdSQi8oush5Q/OBiedjqFJBZtTz5SS6KMO+bB8hMVfbxNZNtBvEZfGCe1gjYph8M
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5062599005|19110799003|5072599009|461199028|10035399004|3412199025|440099028|4302099013|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vRH1yV/Fxz8ItuZMFeVWazXMEBAk5gOxFOj84UexaWoTYTAN0CTWi/0YkU58?=
 =?us-ascii?Q?HqDstBXKVhTHJCMJFsq+Xo/r/ZhmHZEFibQ1sFwKBVF5Fhqs1PtlHKMDuuAj?=
 =?us-ascii?Q?m4DAvGCZjFytfqbOLqDi1EiZXDQb7mtvvo8gPWgHMMNE89la20W0pIsyybEX?=
 =?us-ascii?Q?Aj+bgSyt7OZdEvMgLMrLZPpr+ozoqfXsUp2OBVOPw2EZNj1+OdRRT7LobXOh?=
 =?us-ascii?Q?HrcgXI9baNLEQaB6YMgeGgvapuiVL4W0KWeZc3/g2eUWo+ohSw9NQjX3fr9W?=
 =?us-ascii?Q?jXkiALplUGahOCNKS9W7Zmjs7IiwE4LDeGfgkHoRVoN5yakRi/NTTePiNXV7?=
 =?us-ascii?Q?uazeCp8wgiTwSHZnDAnKaLERPkR9OITGE0lt8aB1M4ud8RAoMsIVBZty2GxP?=
 =?us-ascii?Q?d/S7/3SZP7+SZxidk/DaYuSlS74LyULdqblHz7+3TX0t9p5eLEM3jREzBYE0?=
 =?us-ascii?Q?ZZ9bnwVDOOhRLFI+t7a0HXu8NG6yNk9jnvTKdu9nQkek0V3q+bAL/dkmXbFt?=
 =?us-ascii?Q?6am69KewjMLo+VO8ZOZlQX0QR1oO8B54hmkzxaZBFoPRUyEFziLJRCD3Rkkd?=
 =?us-ascii?Q?ytXzqrxKjMY2PB9ijmPi2804Sl91dCsclnq5jbF6giBOXXvhdEqKGJW32BkN?=
 =?us-ascii?Q?NUMxTQ56PMeCMw+J7FUGSU7YCY3MfTnIOA0JhuDBO/UII81Axmq2RO1J3ENH?=
 =?us-ascii?Q?g77TKF1O+LzyHQSZFMa4lpaqFHM3Gi93QRfobAf4h045yUfHzjGMyPwFBU+S?=
 =?us-ascii?Q?JhjSSrWIwnJhpY23nLia9EmP6N6Da3GCbkjskzCZJ2HU4iKURh6uqfsX7cha?=
 =?us-ascii?Q?ZyLsugLk3c5xGfQ2wWNhQ+V5hIQ4Z2zFkY5GVYyE8UqHkG0sQq9D8Rnmy6FG?=
 =?us-ascii?Q?XBD3fzq3+62nTIU9Z+cgtKNBjQBxtNyJxACafxfkxrZfbJxzNpoFtuAm/hcD?=
 =?us-ascii?Q?XeCe3RjCY8vOvu2Uy2IVpNxwXE/vKExhsobyo51TIHGL0k9HYhjIaIxnZArb?=
 =?us-ascii?Q?1lWYB74k3+9vW6qH9E/JD/oeogDXR+tesL9uE4BnA+AA4ZtItQYn8Hy4eUVZ?=
 =?us-ascii?Q?vHvLvLMQ5Ad2W954xAv+0ez9KCttdg6GibpU34QzerPkW1ER5YgR9HZlcWCd?=
 =?us-ascii?Q?WASNoe+ENL9ncMqGfBbnh13HCblXgh2ppTmQxbly2h2iBtqggbbjt4085ra4?=
 =?us-ascii?Q?MXNl/qFQyTycUdmXSlfpLQtEKupWcwUM4L3wTzzTB4DkwngIlN/K1rYibCg?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eMiyfE36b71NAno0Hv/GIHHJm/29LOvEUM+2TYcYQJIj1GxKfzvi8+4IDb/?=
 =?us-ascii?Q?xqGclHw13YBNkSHiH2PwY66WQvIKdpDfRjv/RpKq4d2ogd9/hcsLQ+V+lM7p?=
 =?us-ascii?Q?gCYHydw0w7wR+0RsxWfAEbiO3oyuylWXvNrlcNRUJTp9MdZ5pjBIQIPJ3piv?=
 =?us-ascii?Q?r/vJAI8yTkRdGPmd0EJHcZKwz8Q8VXxWImDlYb4Mm87x1oGoym42Mv9OL5gH?=
 =?us-ascii?Q?9rONivchb801ot68c6Lp31Kz9WJCyrMPlw98GRG8oBBrX1GmY0EgWWS3mRCm?=
 =?us-ascii?Q?9Izp669XT0Hot+/YAqoqY1EU88lBKI8OuDH3G0Lq/fIhrflSPgKJb2v1WOFD?=
 =?us-ascii?Q?S06VvTyk6m5iaqVXcdSluEUg4pJZh4VzLk3o8gliddKMEYPDgm0HMpyHyL9c?=
 =?us-ascii?Q?QOpbWLrxS6vnWCN8b2CPDAEg1fPvhuSrDGnTSL1rpZoS+StkLbxoHG5GndMA?=
 =?us-ascii?Q?yMM/DHDp9up17VdeF7CBiq6nVFmgNwUN8Isvpu+H6+ReO5gIAmeAiMvvcV08?=
 =?us-ascii?Q?EoQxHi8wwM0q9s4rlFznrnxpDVP83qRM5zFqc0wB5pSDXBe5d0AERPBsa9NC?=
 =?us-ascii?Q?xqKa0s2EHwTSQi/LT07rb9ZtNTJK2g1Vzez/sbUQPbiqYoUHeuC/CEWkisWp?=
 =?us-ascii?Q?J19jIKwTo0y6wDMOpA+wau6ShhAP3bMvaHkBdBm5/SqGESUBv8RLy0zyAEyM?=
 =?us-ascii?Q?PPBKdCs/v2srR7A6LzwoTCnUoQFmQ/Lqb0HYfF4nlR1VjL/Z1O6njGcWsgxo?=
 =?us-ascii?Q?qCJqS+cpmxyYJ7pJwPmeOq/vOYzvQdoDatM1HN0F1DrrBh34NLsvYhpHLOkq?=
 =?us-ascii?Q?t8LHgvLOjjhM5ZVgD4+Vk9MJmZz8ioBcoOus8tTcN8zqqU0xVioZTn79LGNI?=
 =?us-ascii?Q?W133MnP586WJ3fr4j8xdoPP8/hWas/LwjksQsRwoSEW2HxrptiX9ydJNVlfR?=
 =?us-ascii?Q?d4B7cCH1QBXMYyXNoyp/16nRXKe1YDHJJ0t7fsypcWM+0Vo/OIL0Y9BpYX7A?=
 =?us-ascii?Q?Fa3kqFusYf1YQrkoNNYVPPapXgw+r3apN5t3grZprUuo6WygAHF60etfgkiq?=
 =?us-ascii?Q?/g8NeN/dVHcamN1DM6wfIvXoU2G4A+0bbbFGZMX65F+MotCa2Zi4wLpGqt45?=
 =?us-ascii?Q?cu8XzTwVSHzZkTu/Bz56ndFIwfjrpQNj6zvOo9bimJGLZkK+kJU74FaZ7kEE?=
 =?us-ascii?Q?Tr58fvMx3Z3A4wTBqEqZJiHaPBtp/zCa/GpsSVkYUoS+l3fd8CXChduSz9GT?=
 =?us-ascii?Q?xm8ZGQ3yxvYARZ9zU5TG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbac3d9-d604-4c10-7cb4-08dd3a1ba74d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:00.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9884

This patch series adds open-coded style process file iterator
bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
selftests test cases.

In addition, since fs kfuncs is general and useful for scenarios
other than LSM, this patch makes fs kfuncs available for SYSCALL
program type.

(In this version I did not remove the declarations in
bpf_experimental.h as I guess these might be useful to others?)

Although iter/task_file already exists, for CRIB we still need the
open-coded iterator style process file iterator, and the same is true
for other bpf iterators such as iter/tcp, iter/udp, etc.

The traditional bpf iterator is more like a bpf version of procfs, but
similar to procfs, it is not suitable for CRIB scenarios that need to
obtain large amounts of complex, multi-level in-kernel information.

The following is from previous discussions [1].

[1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

This is because the context of bpf iterators is fixed and bpf iterators
cannot be nested. This means that a bpf iterator program can only
complete a specific small iterative dump task, and cannot dump
multi-level data.

An example, when we need to dump all the sockets of a process, we need
to iterate over all the files (sockets) of the process, and iterate over
the all packets in the queue of each socket, and iterate over all data
in each packet.

If we use bpf iterator, since the iterator can not be nested, we need to
use socket iterator program to get all the basic information of all
sockets (pass pid as filter), and then use packet iterator program to
get the basic information of all packets of a specific socket (pass pid,
fd as filter), and then use packet data iterator program to get all the
data of a specific packet (pass pid, fd, packet index as filter).

This would be complicated and require a lot of (each iteration)
bpf program startup and exit (leading to poor performance).

By comparison, open coded iterator is much more flexible, we can iterate
in any context, at any time, and iteration can be nested, so we can
achieve more flexible and more elegant dumping through open coded
iterators.

With open coded iterators, all of the above can be done in a single
bpf program, and with nested iterators, everything becomes compact
and simple.

Also, bpf iterators transmit data to user space through seq_file,
which involves a lot of open (bpf_iter_create), read, close syscalls,
context switching, memory copying, and cannot achieve the performance
of using ringbuf.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v6 -> v7:
* Fix argument index mistake

* Remove __aligned(8) at bpf_iter_task_file_kern

* Make the if statement that checks item->file closer to
  fget_task_next

* Remove the const following extern

* Keep bpf_fs_kfuncs_filter

v5 -> v6:
* Remove local variable in bpf_fget_task.

* Remove KF_RCU_PROTECTED from bpf_iter_task_file_new.

* Remove bpf_fs_kfunc_set from being available for TRACING.

* Use get_task_struct in bpf_iter_task_file_new.

* Use put_task_struct in bpf_iter_task_file_destroy.

v4 -> v5:
* Add file type checks in test cases for process file iterator
  and bpf_fget_task().

* Use fentry to synchronize tests instead of waiting in a loop.

* Remove path_d_path_kfunc_non_lsm test case.

* Replace task_lookup_next_fdget_rcu() with fget_task_next().

* Remove future merge conflict section in cover letter (resolved).

v3 -> v4:
* Make all kfuncs generic, not CRIB specific.

* Move bpf_fget_task to fs/bpf_fs_kfuncs.c.

* Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.

* Use struct bpf_iter_task_file_item * as the return value of
  bpf_iter_task_file_next.

* Change fd to unsigned int type and add next_fd.

* Add KF_RCU_PROTECTED to bpf_iter_task_file_new.

* Make fs kfuncs available to SYSCALL and TRACING program types.

* Update all relevant test cases.

* Remove the discussion section from cover letter.

v2 -> v3:
* Move task_file open-coded iterator to kernel/bpf/helpers.c.

* Fix duplicate error code 7 in test_bpf_iter_task_file().

* Add comment for case when bpf_iter_task_file_get_fd() returns -1.

* Add future plans in commit message of "Add struct file related
  CRIB kfuncs".

* Add Discussion section to cover letter.

v1 -> v2:
* Fix a type definition error in the fd parameter of
  bpf_fget_task() at crib_common.h.

Juntong Deng (5):
  bpf: Introduce task_file open-coded iterator kfuncs
  selftests/bpf: Add tests for open-coded style process file iterator
  bpf: Add bpf_fget_task() kfunc
  bpf: Make fs kfuncs available for SYSCALL program type
  selftests/bpf: Add tests for bpf_fget_task() kfunc

 fs/bpf_fs_kfuncs.c                            | 32 +++++--
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 90 ++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  | 15 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++
 .../testing/selftests/bpf/prog_tests/iters.c  | 78 ++++++++++++++++
 .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++
 .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
 .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
 .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 10 --
 11 files changed, 529 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

-- 
2.39.5


