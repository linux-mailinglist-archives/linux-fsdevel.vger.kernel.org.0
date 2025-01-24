Return-Path: <linux-fsdevel+bounces-40047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D8A1BADF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152FF16E788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C21A8F7D;
	Fri, 24 Jan 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="xFjMIWst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12415958A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737260; cv=fail; b=i3X6+9fHmGIOvhpGnvuMOnQT4pplfCevrD0DHnBFKnTe53wcUD9uul5oM/fdFjfdyguKwKSyn6fGoBzzwUTTlNHVYRqbFwBuZOvfXFWZfSeSTUzY3Yd9IUmt7HtOrJsH8dblXHUyjuOLZstKTpRnc1GmidcXWWc0zAhujpTEBrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737260; c=relaxed/simple;
	bh=QC5g3Y9Ki2CLVy0xdoc9tKQIgIoRon/XUhR1K6un1dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcRv5jaJt65bxDyBhN50iXqW4SmB0VrUEteu7nPWehxd189KPb3PmCH8COWfQrho+zyOeyS7OcLb2RJ1SdqfLf9PPPwkxHOtTLqW4/ACGDxwo6qFrmJnxfBHmaiaiGOIVVmxyxP1t3LVA1RQ06zGHiE0HDgsnbUoj61FDZVexa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=xFjMIWst; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound11-34.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz16huy02GKXApe4NxS84/augjhS5FjgbaODQXTLFM70OgTk0wRIg5XWXlJpXQc9ar7bywLySjXh7NdhIAS/JdfqmtS8tTn8/lUIhCu08MLLUJSTvCSkt5Gy7IsX1Zjsjj425YD7KXEc4lYe/xamOItqCZq5fwi9c/2p23ZT6qw51IQr4sp6J4rU/4NZPTSbnbblCebPW7htbcDx/y8eYsoYk25RjEG7EM5i+M1lcJS6Q9YAfl1MhdQ4jHv/xse0lco3VWcS5aOawZKYHzyvD59rlBUpBZ3xm6QdsbUlhd6aPLK1jN6O7rrPB22ulxy2c5ynlStSBjrLSZk7gxjtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc+mea3tcKX4gCh/B2wgNuSW2iW4H3fMvrsJto8Hx8o=;
 b=Si+NogawDz4Ypcen/QPZ81vOUK+Tk7DEVHtijYt+5P9Kv7XoLkL+YhgrO/GQ+Sn4sZ/hqn0mnSaphBzFlZ4WmuePCHYnun4/k11KRiHqFzlDZD3rF4zfOuWbwdIJz8oba2FEssH8uxfvg5U+VSWtLFn0K7B/Rg45geTeaOpNLolsGKBS8bgamW4yVDrxhtritU83v7hdJRpNSzaXs9yKD2sdz6uXumEeXLZaxKy3pAfyffgtfW/VifRxi8BJD+iSkYXlyoqew/HZww8FcXVQgEMSTZg54dXgb1/Tow+mNoI+SNsiS6alUJKqWbeCHBBGxWqbWfbMXZay56fFZwPVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc+mea3tcKX4gCh/B2wgNuSW2iW4H3fMvrsJto8Hx8o=;
 b=xFjMIWstKid8hC9c1ATzgXZP+8JX+FmQilRSzrCnpewFuEKZ198Op4KoqUhJtWGLkfR4X+oKrvfNf0SJSIzk7SZq1AKHOv7fxgLDJ6x3KReJIuW5w3zbynYkvtZwV+VF8dsLAjKEiUb+3uz775tVF50hjYFbI8ykesZBGK+1KD8=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by MW4PR19MB6846.namprd19.prod.outlook.com (2603:10b6:303:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 16:47:18 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::be) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.19 via Frontend Transport; Fri,
 24 Jan 2025 16:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 16:47:17 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EBFA458;
	Fri, 24 Jan 2025 16:47:15 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 24 Jan 2025 17:46:54 +0100
Subject: [PATCH 4/4] fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-optimize-fuse-uring-req-timeouts-v1-4-b834b5f32e85@ddn.com>
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737737231; l=1124;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=QC5g3Y9Ki2CLVy0xdoc9tKQIgIoRon/XUhR1K6un1dM=;
 b=kZwSqlW75fuBLIUcVKUiHGlRjIDsqOqW+uKZK50jlSoFpK/0KlcTvJgN3duJX9My7uDkceKCv
 KTvTfwbu1yhDfIGpDenkg7+DEZdbZEKOpXx/Wwner+PPoseUS58/Xbp
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR19MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: e880a360-6e0e-438d-be3e-08dd3c96c315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUdQUEI1Snd5THdPKzFiRm1KSWthQXBOS1c1RTZQUG9YeE80TXZtZjVXaTRN?=
 =?utf-8?B?a1FIeGh6dGJNZGgxY0pxWjB6ajY4Z3EvZEJ3Q2hmZDZiaVpTNlIrR08vQVBR?=
 =?utf-8?B?OWZhaHRnK1E0MlN1eCtXV3U4bm8vQ3BxSjBiMjY4MUZIVUt0RkRWZjRwNHJT?=
 =?utf-8?B?Q1FSSmxNbU1tWmZEVGp0bUpldW5QTklHU2M5UXVpNk00QUNhRnpuYS94Y2Zk?=
 =?utf-8?B?ZjdvSDcvTUgyZWtiRXNKSFNZQzhuS2ZCWTd2REtWbnBJa2YrY0ZvdWR1VXdh?=
 =?utf-8?B?ZFBNYnI0L1BMemhYdFNtWHh4LytSYk5wVDhFbWlyU1dsZFBudFZCamhQL1lY?=
 =?utf-8?B?Q1I0Yys4STJwdnBqMzk5M3lZN2YwR0VOOURGNHpvNnNnUHF0c3RFYlRFTzIy?=
 =?utf-8?B?SEZidEVwU1R3ZDA5aWVIUFVnMWdVcWhzWXFoSC9iaE9kTHVYYzEvNDNBNk9E?=
 =?utf-8?B?RGs0OUJpTzhxUFA5L1U5SWUxYkVWbkQwYTJ4K3BHZ0JtNDluN1V2cWp2bnFQ?=
 =?utf-8?B?dXZKYkZFM2N4Y2FqWE5UeVg4NGxtRGs5OXdkY2NKNXVFanZwQ1FBTFNGY2Vl?=
 =?utf-8?B?ZDcvYkR6RFhYb2t2TlU4T2FvdHIzS1BuWThsVHlhQ0k0UmpBRC9hNDJBbHU5?=
 =?utf-8?B?NUZSa21Hc1poZ2pSajB6N0llZ1A3S21GNWlWMkN6SkozN3lNQ1F2UmhhclJ5?=
 =?utf-8?B?ZGdYZ2tJM0RCWk5OekdRY2NYZVZOaHNtejdXRTFQdE9QcXRZVUNLd05KVkxw?=
 =?utf-8?B?Zk8xRndUcUo0UU5jSDd5M0NzZFJyaUNITmFQQnVlQzB5cFhaR2Ewc0VSTGFZ?=
 =?utf-8?B?dUNYNkkrZnFyMzRSRU1ubHVwTHEwMkF5cER2R0RkRkwvKzRRS1daSXlTdkhV?=
 =?utf-8?B?RkhJc2J0dDZYdDhUbzBLSE9ZM1hyanNtWnAyMXo2WE94Z1NBMmlJOUVBVTVR?=
 =?utf-8?B?blFNRU44eSszbVVnSHpGRVJKbVVWeEtuUDdxZ2YyaTE4WHpha0hIUEpkdHN2?=
 =?utf-8?B?RHFUeW1vN0RoMDdsTDhPbTlPenlkN3BNb3hYYkFhd1dmZjZSU0RMV1NSNlQ2?=
 =?utf-8?B?bFZsdlk2eENMc1ZzNlJxZFRUc3ZIQWUyc1o5eXc1TnM0TnBxWUVDanFIMmFl?=
 =?utf-8?B?U2dxNTUzL0FsU2ZVZm9hMEhuMzBmVlNWTWFrZnpOOXFvdENWSGhUek5FcDJR?=
 =?utf-8?B?Yjg2MlVWSkhRN1NMOG9XeGljUlA4RCtQS1JPWnFsL1A5MUtvYlYyWUNZZEVR?=
 =?utf-8?B?SUxPRjFyTWhXMkRqWnZNSDEzNkhaQ1hIazBvUFRyOWxFZk8raHFBUkdNeUkr?=
 =?utf-8?B?WkMxNmR5OUM0aXpRVlR5U0kwS3IyNCtXQ1FkWUR2VVpZd3QxRHBNWVppL3M3?=
 =?utf-8?B?UU4yb2ExUy9JcU84OHovUG1lNkRPZHUzUTBmWUlSVC9vMnRwV1lEZFFJT3VU?=
 =?utf-8?B?Z21RZUkwUTdSbjdlbGo1YS9lK1FGdjd2L0FreDZGbWlqWjBJVnJzWndLWGZk?=
 =?utf-8?B?ZjlvN0V6a0lpVXJrS3Z4KzB4OVJ6RjFwMDR6NzVMRFRvS0EzNEZhTDBKdUF4?=
 =?utf-8?B?dlFmK3o4NUVISUh6WEpROHNGWFFSc21vb3ZlTUQ5a2M0R2pMMVRpQW5zYjVN?=
 =?utf-8?B?ckFCdmY0N0JUbURPQVhTV0p5cXlDb2YvREVTM0Vod3FXN2tzbE9ubzJIMmQ5?=
 =?utf-8?B?cm9admMyemR4bDJ2ZzZBMzBDNEZ2YVJKSDNvMVRGZG5jNGlFR3dsbGpWWUlX?=
 =?utf-8?B?REhIUkFoWkQxZS9JbFFZVlBBQmZFVXpOQmVvbW1JNC92ZDNjdTM2eGkrZHRa?=
 =?utf-8?B?cm9mczd3dHZvVFZEbXViVXBBZWJCclVmR01CTFY3SStFN2hKYzUwdzNqVjRX?=
 =?utf-8?B?SEJsZy9rSG5QdXk1eE0yQzNJOHRFbEJXQi96azFCK214a3U4Y0xrYm4xRlZN?=
 =?utf-8?B?UjVadFFwWHl2emVMVk00aHpEUytsTFlwOWhoWWo2YlV6Y0gycmQ4UkhjVUdQ?=
 =?utf-8?Q?XSPnTHreP9g8PhSAtKsqj0w/EK1vz4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pEdyID6MiUXqXzJVFxA7xtwBHoGHWeinRqZny063Fh0F0fMce1hTiwRuy77NqNr+7U7a2zwM+VZL8AmYouRCBFAtfpupPmYQvvUS7qTDai8ds1h6bQ3w4jcjoQBzK8CDPkGR3B35rlpyAlOv94Z5g1VtS7GlAvs8ZSHBYuSAasnvRS7FSzZHLPbXW9pO6zIyfZn8031LoJ8djTbqBqkPUSxTmkBXah01zKu2ZUL3di5qTrrdu/gdnSTI00UZmGBJKXYuDJfGPXPPOAtryoe1qDby2KbzB9j8k1ih+6YDG5tvsJCjbk134hYK9GduFCRggeG1EN/zOSS7qfmsPNx8EQJlWydEzuUyX6rujwXuxNZfsFM2qaoXijbTlo32zjuLprSFqO7yXXwDwHSHpgAgy0Iuu27iLeAa6RO6Bclku1Xvo/ze1bbEzMjGZzWsP9zfqo6aveyQxFuIyVGVwJk45iTErmanDGGO+onO9B2q0Ow6Goftxevmu0sikxHi4XTEcV13lSjYei8jVZ4uG4ijkTd84UqpnqAsbNA4UiPr+6SnINl2kUy49m/YWWZUEzvXqe6cqbnBkWRZyfENOh7YxgDU6oX8YJEkRPyatrMf3lwsGQQJ0yFanh1uODl+ml61nPy+y0UIKL3zaFSkuVQtLw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:47:17.0658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e880a360-6e0e-438d-be3e-08dd3c96c315
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6846
X-BESS-ID: 1737737243-102850-13353-20190-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGloZAVgZQMMnM0Nw0ySTFwM
	Qo1SQ10TzF0NjEwMDSLNkkNcXMKM1cqTYWAFaaBBBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan10-31.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is set and read by different threads, we better use
_ONCE.

Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c958701d4343705015abe2812e5030a9816346c3..c4453352a0c1c0aef387caf45bae21eaae0918ef 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -36,7 +36,7 @@ static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 	struct fuse_uring_pdu *pdu =
 		io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
 
-	pdu->ent = ring_ent;
+	WRITE_ONCE(pdu->ent, ring_ent);
 }
 
 static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
@@ -44,7 +44,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
 	struct fuse_uring_pdu *pdu =
 		io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
 
-	return pdu->ent;
+	return READ_ONCE(pdu->ent);
 }
 
 static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)

-- 
2.43.0


