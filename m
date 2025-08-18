Return-Path: <linux-fsdevel+bounces-58178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C2B2AB68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6085E1B64BBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E372A340DBD;
	Mon, 18 Aug 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iOZFTTSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013026.outbound.protection.outlook.com [40.107.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE9322745;
	Mon, 18 Aug 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526927; cv=fail; b=BtcgZ3/m4FNhecU2MjZWpNHOTNEynlXqTsjLKpDvlQbWKGjYXXrs34WNJ8NaMK9effrcYBSJEiKc44xZa1LyowI1U5hrb829mScqm6B6pe4gH4kdfPWgJY5YvXcskvY6q9aim4VIh/zEP3S8KIRwTalp2icsrErJRzCLGhF0nO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526927; c=relaxed/simple;
	bh=PHOPtgB+jKjGA0RXtjNaIn7OpayuyMt6R3mSjmhLEdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGwgUEs4wD/WtSOg3/qJ0lCTiKMU+DcAGzeBAHoaJS0s02NUsq3h+Aqu0TPjpRVXyz14ZtaBRbEHyHgtBl/iBNQaRca3wyt3RL817wRNov/MHWimUQeF/zmYFqAEoFC+zkCapT+wFb/EF4yfGhEDCQEa9nExL0dBKa5aoRp82fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iOZFTTSa; arc=fail smtp.client-ip=40.107.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu8h+m9DDRuL6Zmkjd2QyvCmBB/PbubYsP43jj8kKFvSFgIAKeu8S/jqBUZq4cpURYbQTvArqT7Ee3UsC3HOp/ZokVOI1dA+TGCQluqN2H7mKTCsenTT8VlQhJ9jbYp7aprtBO38yGQgCI+MMJPR7rIFeeZT+zaGmWfG16UBmrnljtMercY1/cUpZXS0rb8YzqlaQI9ctvFdbacrLQ67Oc2gPiNK/St06OfNTn6XuZv8/bDr9vT7lvIpVyUKYFh3bugK0IrZMOLcvWXuN9G7DN88Kp/fHnmJW0+UOwicqD2xiRW05LpUmDBKta0weqKaUVmh/2e3DQFslnkB3jlseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXn/gciF340nSmHrqPx1/TfGjvU1l2yYjJqjxW9SFkM=;
 b=qWUf8jAA6Qv+p+nyJ2SZIzFbt4+Fww0IyqMjU2DoUD4yx57vB6dtfW2l84YJLmPdR4BHXBQpSTEoNFktjUAvH1z2T8L0J3e6lbFPlhoSrpqvJWz/YR+LHiGk8vuf9BSedgQq+7PEgm7DpMnKdEd0N5IsCt0GrGbkGHqqoojcqbdZb98zXCS37SdwKuecMZxeig+DFzATV3h5iXnftaTRXRkbK+K8SKcUOjCnp6G2z1b/OevDfYYyr47T1YHqlzokNgGzftttcQe3utTaSoEPi9036wBvWnIG5A5a5MlXGU7ciXlPDQeJPi/H8JY8DigwQidL3ObUdQqw6t1uQD+LuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXn/gciF340nSmHrqPx1/TfGjvU1l2yYjJqjxW9SFkM=;
 b=iOZFTTSa/mjqlfOcv2dkedTf9KosgyXoXy/oAmGszZiqj5x+BGwBZIRALeXXgCsnIo2Y/BL3tGVdHKZSPKm+1BtlR2oGhPYIatgpMZvowHnEh/Bwknu9iKLJKCiiIrHF+qGY41atDxKoI3ytDeLYzGq+pes8j/RJlau4VC3UqsUJ58bNXUcj8kin5R30Sj6P2c3vbhVR3wojx/E6pUNdOcmQlWAFP1f41diRdZX2EgbGTuiOWnE7U+N+z4fSz6VTs2DKowYfc51X3t+l2tXPbOQAVCqgPbOw5JFxmplNfudQJnm4s/qR8A0asQFNdD27oVSiXWgXqwAskUCpxIMyNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SE1PPF54561D20A.apcprd06.prod.outlook.com
 (2603:1096:108:1::416) by TYZPR06MB6115.apcprd06.prod.outlook.com
 (2603:1096:400:33d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 14:22:01 +0000
Received: from SE1PPF54561D20A.apcprd06.prod.outlook.com
 ([fe80::460e:a381:581a:aad4]) by SE1PPF54561D20A.apcprd06.prod.outlook.com
 ([fe80::460e:a381:581a:aad4%7]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 14:22:01 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>,
	syzbot+356aed408415a56543cd@syzkaller.appspotmail.com
Subject: [PATCH 1/1] hfs: validate record offset in hfsplus_bmap_alloc
Date: Mon, 18 Aug 2025 22:17:34 +0800
Message-Id: <20250818141734.8559-2-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818141734.8559-1-yang.chenzhi@vivo.com>
References: <20250818141734.8559-1-yang.chenzhi@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To SE1PPF54561D20A.apcprd06.prod.outlook.com
 (2603:1096:108:1::416)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1PPF54561D20A:EE_|TYZPR06MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f0ca6-7ce2-413a-3988-08ddde629923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DxGlObfw6HPYLU2c0XMcwsWFrMevpYMONLf/0YUZYSgsybEMfW7qA2IBJ+9?=
 =?us-ascii?Q?P161WGFoydOeQArkRVF8fWRDx9JGH3SyGlGUz/5aioOuKgsYUCJ2oA5ySkGW?=
 =?us-ascii?Q?FYXaFtwwp79SNPvsFs9H8Umw5bTGLVQBSEAqB7YRsfTu4DCLZjhb6kOzlQcM?=
 =?us-ascii?Q?6D7kPTaAaF9Ws4yl5lchFi1z+n+iB3k9JlpIxxMcJCFuZ3pzUkTXeT5EfA51?=
 =?us-ascii?Q?5DPXioa7qF1HORS2Jfqs7e1d4V/uccbAPZqXINrd2ExB0TepxLs9VvKcEWZt?=
 =?us-ascii?Q?FDbOLmxSRVIknGy/aet2dmfiVxWML0lAT1QwhQNQf/KIa8Z5b7PBoSsQIzM9?=
 =?us-ascii?Q?MZ336hKbLyaoTGm6k4kU0TW9EJfVHBfAgzMJhXkZRcBy74LEt3hQX+Q8Uzit?=
 =?us-ascii?Q?Lnq5H0+JF+pc5u2SeHq7WZlOwr7xk7ubiUXLnXEcH6bJy72UXYxdP35fZN3N?=
 =?us-ascii?Q?wOs1GdLw+RlTVbWbfXAPhDHGlEceGLLGELzq8BrKZcj0KN0O3bgaMpR6ejTM?=
 =?us-ascii?Q?Ti5hdUKL61JAt10bhAjksDcJ5LoxG0DkyIgHWS17Sah+XQScnlKEFc2z1TM4?=
 =?us-ascii?Q?CkCWzYqCHLbmshHhFc5iYaiRWxoYHHaCo/C3/qoGbpi6hjw4yJR7FzkjQTDY?=
 =?us-ascii?Q?ukGfnEph/8Y4FZ4jXz6H9eItAVrnzTAA9Nx4PPJcq7V89HBLasjqtA8ckPT1?=
 =?us-ascii?Q?HwFGFPs2I38rUmqY4SO3teqv1BP94IOSHbO2Z1zFtzhv8zqi1YIPzSMom27E?=
 =?us-ascii?Q?y38S1tV2Orx6O6jz0TTap3ZBoa8PMDWAv6fstihea5hPvJo1xcsjJpX221wr?=
 =?us-ascii?Q?Cu71Bd4bN3N99lKXGpMtNsqIMVGCdwDIVsdjc1duKTIaJimUS6ArJDve3BYu?=
 =?us-ascii?Q?utsQdC/PBxFULcAIsuFtH69r/UWmL4/EoODcnKcmUqldGo8ULnX859+jnozx?=
 =?us-ascii?Q?ZdG/by3vl5frcLNkO0hMjNc/Fw9DvIQBXHFvKUZg2Mb5SpffcByFHvWUZfHl?=
 =?us-ascii?Q?5X5sLBEgaSzmd3nuxLVgSR+NOSpKELJUbSoPbRDPE/A9cGUjpDjgGcwxFl4E?=
 =?us-ascii?Q?4t8mcj+Stl8qWTLBMuQ34Ed61MSM/S2m+iky8kclxR0mrDe8CHpTIEBJQlSe?=
 =?us-ascii?Q?+GOW/MX7pLKspzjoKdJorfrwvoRd/Byf/4aRXCtiAcodVeCKfTs+5JztKhbE?=
 =?us-ascii?Q?u2wioKNEQcxK5cJ3XcM477P1RIzQqXgRyw6zuKhAobv2xrCph7iRVqE43/k4?=
 =?us-ascii?Q?fyUHVLfMh28aTSqcJ8gaKIrhIV5TLlZu9Cx6HqOdpgVGNPYIy6tYDQeX92X5?=
 =?us-ascii?Q?XuuiUKpduEo3uhSk6cwundcXbwQI2KwnHzH2XOrZLkKKytdJd+B0PPx9HO8j?=
 =?us-ascii?Q?+BdZCY+bxkHPFnUJxjVYUEwPivWB7ZOwvHhxFmMxA/2w85ubQexmfelqvbou?=
 =?us-ascii?Q?p2JFHlfRHDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1PPF54561D20A.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IVdzkF2clBmD9bMXZh/NXGjf+y62HenRuaaeaIV4yfy+svGy4RcH4M2clLZ?=
 =?us-ascii?Q?ZBE0+Z4SIXp9dEB+z00/3CIx+buXu6fuukRyidHp/fDctQ799Bzxg5/vX4OP?=
 =?us-ascii?Q?Up4foGMiD3wDBRJJceYU23gYv1jPXuuH34lQqoJH/UPOJHFdpqpkeWETwfzO?=
 =?us-ascii?Q?cDCRrTPaOHsclpcR5EQKFRWPP7B7dER3mDCdrUtOjmkf2EeufrpyCbFQg+LY?=
 =?us-ascii?Q?OXOR5QU5B5txA7If2H/yMIJS5bQ4mcJaYMAclRr8FXC3rob9qDGnMw4wNK2m?=
 =?us-ascii?Q?9mkRIhpcUx6qZ1t2Xw0tRDFvm9gDQ/6nCuG7fQ3rDtZkKQZOUbUIdvLJPJ1h?=
 =?us-ascii?Q?BAGd1udgd3QJBQrHx+qveAgXPBQ5Ci0CJZrNN6oWMs2FqtpmCTV94sJS9HiP?=
 =?us-ascii?Q?2ES4MG2Qmu3Z1y9J8Ys96IamUy4gu2yfiZbJ8s3uBsYQfEYgbXTLWvmQzQQr?=
 =?us-ascii?Q?V1jaPm/Kkk8KYX+dRnTQ6XWYH5/ta65O5Vkgj8iLcB7jfFCHTBsVHLCUHe+5?=
 =?us-ascii?Q?yUeUDUpvAhyJ4GGYhceHDs6v/ipqk2ox27BwMxsIoQAXMK2rRBnz9HpT3fzs?=
 =?us-ascii?Q?Di/rZm9FNWXk98FIJKXcgg3IM7ppQu7UibkG2EUjXkZRmtZHsNuDjQ8DkZps?=
 =?us-ascii?Q?gW2melmlWMFoezlSd1O62/mIhUYhXFTjWosuUTiY0MJk5LPzpQlxln8aIDE+?=
 =?us-ascii?Q?PvZzqRV+UWN62rlj7WKfTdvb7mqfL5S1efmor/Bl1b59p/MJ7Qv/EHUliFN6?=
 =?us-ascii?Q?cWOPNyHyq+WJ49S/9QPMuvG2VsfbAWzPAm2gqMTzt7iqU+ybPeHArxPZ7tEG?=
 =?us-ascii?Q?Tb4M6m2TyjwzBkZjEiAvn01iCHm0aAPnB7IqKIMHp13goO8EhPgs6+XYWGIT?=
 =?us-ascii?Q?qJWQsJb54ZWBkqjT5O/DjDIdYRF+KrWBZ8CzSZ5zIv+uE3RD8fcvq3gEHez7?=
 =?us-ascii?Q?RtqxMDfHfXg/DSeZkbnRKlnw39L/RStkggJFvB6A4iLsqsxLpl+2VTdYqFKp?=
 =?us-ascii?Q?6mNALopFz+tWVYmO20441+2s6hMcdbNX4HjYwlTP2oXgnR0ibhUY+mU4u2H5?=
 =?us-ascii?Q?Qo2Bd/VXRH1NFS6JkLmg8lBP5/dsBLwKZxo0gRly3YBPS1W7ELYQSW7Lh1LR?=
 =?us-ascii?Q?wNm16aMnogidz1BJunWd19H8ut4cJrD9LKbc4WHG+4ij7Ll0g7yLVYAknNfE?=
 =?us-ascii?Q?w6hfJPm+BO8biUQFFep1XhH0F3c90CZdvS6I4yj8Q+K1AepfYCtdTZOKke99?=
 =?us-ascii?Q?ylFtUNNIZzzH/O0vguuSN00cV9x3h029UsRm6AuRfBxsMhmZ4fOmq7Maxvtl?=
 =?us-ascii?Q?M8gmOvZGQRVGviq/3b6qNjOF5ctyx9nsy0o03hp5cBz9e1UZt/2FJfY6ylkW?=
 =?us-ascii?Q?yHc1dNzaKXKvkT+aH9LNrhJQCYt6cKtc1OQ6jC1oxiPFMTklbCkN41XCEuNq?=
 =?us-ascii?Q?lWeatkmNfSvVgn/af7ylj9RFFk6wLBwBCj7aetPoFxYT6N3+M4IJ9f4BJKqq?=
 =?us-ascii?Q?XKOOOepegS+LjWRnf87f0BREXJzz5fU5uxlch5aWHP6FAo6Lx/1N5UjMcUSu?=
 =?us-ascii?Q?hpKcLv14/T1FXygrRXUDJhq7yMLagEA7t9NR2dxa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f0ca6-7ce2-413a-3988-08ddde629923
X-MS-Exchange-CrossTenant-AuthSource: SE1PPF54561D20A.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:22:01.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzMkOw/xSIUSSsTye1+tHWVGaFbhZKEeVpE5MyZ+AAzzQhPZ5WavzZKlF92JGpgfoWuvDB+i4E+sqa7V88KWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6115

From: Yang Chenzhi <yang.chenzhi@vivo.com>

hfsplus_bmap_alloc can trigger a crash if a
record offset or length is larger than node_size

[   15.264282] BUG: KASAN: slab-out-of-bounds in hfsplus_bmap_alloc+0x887/0x8b0
[   15.265192] Read of size 8 at addr ffff8881085ca188 by task test/183
[   15.265949]
[   15.266163] CPU: 0 UID: 0 PID: 183 Comm: test Not tainted 6.17.0-rc2-gc17b750b3ad9 #14 PREEMPT(voluntary)
[   15.266165] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.266167] Call Trace:
[   15.266168]  <TASK>
[   15.266169]  dump_stack_lvl+0x53/0x70
[   15.266173]  print_report+0xd0/0x660
[   15.266181]  kasan_report+0xce/0x100
[   15.266185]  hfsplus_bmap_alloc+0x887/0x8b0
[   15.266208]  hfs_btree_inc_height.isra.0+0xd5/0x7c0
[   15.266217]  hfsplus_brec_insert+0x870/0xb00
[   15.266222]  __hfsplus_ext_write_extent+0x428/0x570
[   15.266225]  __hfsplus_ext_cache_extent+0x5e/0x910
[   15.266227]  hfsplus_ext_read_extent+0x1b2/0x200
[   15.266233]  hfsplus_file_extend+0x5a7/0x1000
[   15.266237]  hfsplus_get_block+0x12b/0x8c0
[   15.266238]  __block_write_begin_int+0x36b/0x12c0
[   15.266251]  block_write_begin+0x77/0x110
[   15.266252]  cont_write_begin+0x428/0x720
[   15.266259]  hfsplus_write_begin+0x51/0x100
[   15.266262]  cont_write_begin+0x272/0x720
[   15.266270]  hfsplus_write_begin+0x51/0x100
[   15.266274]  generic_perform_write+0x321/0x750
[   15.266285]  generic_file_write_iter+0xc3/0x310
[   15.266289]  __kernel_write_iter+0x2fd/0x800
[   15.266296]  dump_user_range+0x2ea/0x910
[   15.266301]  elf_core_dump+0x2a94/0x2ed0
[   15.266320]  vfs_coredump+0x1d85/0x45e0
[   15.266349]  get_signal+0x12e3/0x1990
[   15.266357]  arch_do_signal_or_restart+0x89/0x580
[   15.266362]  irqentry_exit_to_user_mode+0xab/0x110
[   15.266364]  asm_exc_page_fault+0x26/0x30
[   15.266366] RIP: 0033:0x41bd35
[   15.266367] Code: bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0f 7f 7f 30 49 83 c0 0f 49 29 d0 48 8d 7c 17 31 e9 9f 0b 00 00 66 0f ef c0 <f3> 0f 6f 0e f3 0f 6f 56 10 66 0f 74 c1 66 0f d7 d0 49 83 f8f
[   15.266369] RSP: 002b:00007ffc9e62d078 EFLAGS: 00010283
[   15.266371] RAX: 00007ffc9e62d100 RBX: 0000000000000000 RCX: 0000000000000000
[   15.266372] RDX: 00000000000000e0 RSI: 0000000000000000 RDI: 00007ffc9e62d100
[   15.266373] RBP: 0000400000000040 R08: 00000000000000e0 R09: 0000000000000000
[   15.266374] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   15.266375] R13: 0000000000000000 R14: 0000000000000000 R15: 0000400000000000
[   15.266376]  </TASK>

When calling hfsplus_bmap_alloc to allocate a free node, this function
first retrieves the bitmap from header node and map node using node->page
together with the offset and length from hfs_brec_lenoff

```
len = hfs_brec_lenoff(node, 2, &off16);
off = off16;

off += node->page_offset;
pagep = node->page + (off >> PAGE_SHIFT);
data = kmap_local_page(*pagep);
```

However, if the retrieved offset or length is invalid(i.e. exceeds
node_size), the code may end up accessing pages outside the allocated
range for this node.

This patch adds proper validation of both offset and length before use,
preventing out-of-bounds page access. Move is_bnode_offset_valid and
check_and_correct_requested_length to hfsplus_fs.h, as they may be
required by other functions.

Reported-by: syzbot+356aed408415a56543cd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67bcb4a6.050a0220.bbfd1.008f.GAE@google.com/
Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfsplus/bnode.c      | 41 ----------------------------------------
 fs/hfsplus/btree.c      |  6 ++++++
 fs/hfsplus/hfsplus_fs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..407d5152eb41 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,47 +18,6 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
 
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..fe6a54c4083c 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -393,6 +393,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	len = hfs_brec_lenoff(node, 2, &off16);
 	off = off16;
 
+	if (!is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return ERR_PTR(-EIO);
+	}
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	data = kmap_local_page(*pagep);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 96a5c24813dd..49965cd45261 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -577,6 +577,48 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
-- 
2.43.0


