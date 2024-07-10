Return-Path: <linux-fsdevel+bounces-23484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F892D3DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9891E1C236B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B8193474;
	Wed, 10 Jul 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jxhErC0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B419345E;
	Wed, 10 Jul 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620612; cv=fail; b=YOvPI4bK4PtdjBTI7W+fMisHPitbCuIV5wNH+Nn/xx52z+oKdFAQt9gFnkKHKI5M8OxGbON2TToQFHK90VWxftylTKafVJAVM3QWMjumus7P+JEEQUmXkh4VB9rlzBunmMo3MwGr5goT19Gs9OaGWZYd3UYr6g6g9s48noWUHDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620612; c=relaxed/simple;
	bh=7jQqwDm0MXfoSh6Wk/rFcNBHz1G4QRxsSCcSK5si6Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E2JTmRtUwT5rdVbKA3Y2Vm08vhk7gyImYjOL3LGiIa1W8dYHmyQnFmpZX74BvLGmJveKnNXMz4y52R3V09Bc79FSf2y2t8SkUlOx0d/6RPnaJg4RLmZeHA3n8q7kT87J+h7dqaghr/xvYUhJhud9esxVNLjQCmzHHNHdCsSYEpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jxhErC0j; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G34pcI2Tk19lh1r104GbsLkahMHV/PY8JPzaJGlAcf6DxX8T5KAwhimAaGWaiVGutX9qtWoKg5LPyrPytE2Otz8wJvSkwj9Ma2Zf4YHVJJTVDWEUVx3PxsbEmHZxbcNc3NzaFUVz/2/Swuli/3+OgJRab7WGbPrynY2Ze3h/I7AAyCkrSrdQIW8Ui8jir9sF9auN+rzPt/Vt9cNEYlBhh2UwmH7RgRw5TDGMvHvAiFpFmISQTG8Y3XmNIXbR4s1mr9z4wXYaxu84ImpCFjYsajPvt/AO1/+o2jyxiZhUoqnibzoPWDr/ULooQ+f1Z7JRfkuOzW5ddNivD25h3nIOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVfWZv1bxzI2AFs3g8Xez+PQlX+2bEmv+QBnAFOvTTs=;
 b=by7SeMNYdX7TjeWavzJmqrxlT+f7S7eZ8wt2YlZwt6MJqNO8XhpnZKunOYDDEy1y2Bn/VpQXXJDblFHJhZNEPG+1yBndxH0m3cbJTg0bhEqso3miv3O4Ja1kn7+uPJj6Yf/j0/g0PEJKy7XRKwTbb4DDzUAihrFKJKEm2P+ucC9v+xavxPPr0BMivHE/uOXV/O1ICVx/tIoevRhocHrliBhd+XJhIU2cV1xHAZsCkKTnuuGIFFXbFQznnQu49Gr+urPkNkhI9NYQpGKJgbjzdYQsbWxDXrBI5vKVjZzEbnmyhwU1XkFaNJJYk5y1+w3cKI3EzpLjLocSfQNXlpA9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVfWZv1bxzI2AFs3g8Xez+PQlX+2bEmv+QBnAFOvTTs=;
 b=jxhErC0jQiUS4tI1eDzBhZdTiyKSHbm+emhpl3VZVjXFZ0nMGWhXe68Xq9GOA3VXT6PizAPvCTKGznvLhE5ZLgVL7bj2+Zx9VKKcErMetuSioQoL8jSiwKbEJ6/aS2gw0KN6sBLh/LPiFU8ORYYEFkXEddRBVU7lrQVg8FDIwWlc5sphOzyrxQlXURwFbbaG1wJwsy4s6QOlnvmM/GwZ2w57n1oOZXJm7AS4738Zomd3ttZCR6RRQWVcl+rTougXRJsMTvquLDBgEgEt/RAO2+4/71pG008oofpgljoF3y+OZREMPPST39qxrmMG2aSMiJuzE7MD0Mqg/RKFVGKNXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB7077.apcprd06.prod.outlook.com (2603:1096:101:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:10:03 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:10:03 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Peter Xu <peterx@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH 0/2] Support direct I/O read and write for memory allocated by dmabuf
Date: Wed, 10 Jul 2024 22:09:42 +0800
Message-Id: <20240710140948.25870-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: fe821f6e-a93a-4851-634d-08dca0e9fdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYnQCdJ35+CdZZdDTcKwSUO+nNqc4I5ncL77kqRFFSvZFUNr6FqrbzWUUfF6?=
 =?us-ascii?Q?3SrN9dmIUzwt+hWuPQewgSn4k1SOFufyXL7bFVkBd1BNeT6+uuGQ9JE/ZWgt?=
 =?us-ascii?Q?FuyqicrFms3rXzD4ij4m8wvT54XzyRP6QbsEHXUK9WRvRIq7fL+315UPMlZE?=
 =?us-ascii?Q?CFf+xNneuRSoqJVzrbEAZkgZGr7keKzAfe8yzaIA+nPuFUs/bg86KDjr9zLT?=
 =?us-ascii?Q?9HdnNoypFaCfhb/af/Ssh9H25+UNXkv2D3EnlAowoVJIsuZv5cxe5CAJyD31?=
 =?us-ascii?Q?WHuZhG6qEgaaHOYPaurmnIIcy0WK/a3/DyzP5aS2U9uNUYI7E9Vcs9Fi+E2s?=
 =?us-ascii?Q?YG28Dy3PgLs6JkjjlftRUNxra7d8eK4B+c3akjI/v3JWo3dC+nTRSIibAdAT?=
 =?us-ascii?Q?u3treN0ZVugwdzXGx5EdLJdzC39XLPIPpKOTbZdW6b3xgG+PhFKjxqJ+k3UK?=
 =?us-ascii?Q?ew+Pat39BoqSm35VN+/CPl98OxAu1qjQ8wltJBOyG88760/tNI5562wOHNcl?=
 =?us-ascii?Q?74z5UR9TlpPf2PfC9Zy5Vr/eGEFs7spWhNpqd+kuvZ/elIeK+/pIaqcvYMrM?=
 =?us-ascii?Q?Rt7xunoqhWakQ+VD7+iL+/0ZS/L1KuyalVRrT+WIZFSODiDS6NPMrzAURz1M?=
 =?us-ascii?Q?9j8aaiinHfG/QpjQwY9qY91KyG/YC0P0lgw4xx+aomiUh20vSuzAMLwkCDEe?=
 =?us-ascii?Q?YEOijqhuASnfcTVuEzRw63T5SyTzLLyYtc5es80WRLKUJm4Yqj1OVfX4iiZq?=
 =?us-ascii?Q?1pg3G6MYiz8PzCFOaoXrI9GS7qfWNhNCxHoX+DWXL64rwSRY15h5FIxhRsuc?=
 =?us-ascii?Q?L0GZTWgegR5cAzAgs/5Fz6t8GmQGYxHWbMmt0M0Wdutj4Hy3Hyns/Dd4PWw5?=
 =?us-ascii?Q?8sYaBMXOh6J6wjGEy1PH+T3kN/8KRzCfuhVlCvKP9EnR1TdjNSGGjGpxZNLQ?=
 =?us-ascii?Q?FdqJBetyuqhOAVJyQZVrWAkGPI5Wr/rVK9BqffykdwtQHNhId5twEk3V3QKH?=
 =?us-ascii?Q?w5m7ZGGjvt1b4fykY6htVzIR26E/hRujMQgZLxpaCtpTxgUy4kNfftvRDtQ5?=
 =?us-ascii?Q?n16elElvy+ki0vKbDOuFeyYAL2WQczbNtiKn7SGTrV31CtrwJuuBR6dATXCO?=
 =?us-ascii?Q?vtqQBAbaKD2FwVNnIXYc8EKEkbZdenroFR2nFm0XriiD6X/v9p5NpF3DKk9D?=
 =?us-ascii?Q?RI7aqh5iCkNaoKIFItb38llUI92GsuzeIKDDgs5v/rGjHNe/Okag/+EUg443?=
 =?us-ascii?Q?Zx0ntzUQRviUpWOpo0uRafbiujpTRWm1oWIvaUbmMB80ZAx64DOACFICD7ra?=
 =?us-ascii?Q?B2n8gzCYOu2jH41zVLiXe55XpHkmY2tI/Nt2EoObj9qSwghYwZU5JPnQBw+Q?=
 =?us-ascii?Q?gacp3IKa6DHMeiMet56CEpzJBkghVxjUVOq1XqtSr1HTF5WDkwk7MD5VYVqo?=
 =?us-ascii?Q?Gz5FbfMBzvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCIwsfxN/V4URVainH7oGX21bBHZNPJK8qUFSREj5tXkRmiZP1l+ytVSXoT9?=
 =?us-ascii?Q?KCcoyQXXykQEiswhxV6fXkTmCciZaipGFRVkcaINxkX57G4BVIWSveisHp9L?=
 =?us-ascii?Q?485M9cqMap9v+wFlfY9aApqSZv1A2HXkINdGOIPaJ2iWtZYgQ06LXR1oyFUd?=
 =?us-ascii?Q?WYcyrXr8uJAtM0li4WDyfzW6fZ8Tj9GB/ZhLFHq0vzbauefzb8l/uynLdNX2?=
 =?us-ascii?Q?VuA/bb12Aryz71Zn8KdAWxLkAhb2FMorJk4YFkpMTuT86OVOMgjXLo3iOyVi?=
 =?us-ascii?Q?ZO+cGb6kTL4Rpb40g07H8lpqktOUsuQWrH2DfFK677DM9AnssdA8zG5CiaNa?=
 =?us-ascii?Q?ZyttJvg/JtfWujqYZiknjgEZVcH30k3Xl6z1hapDLdwbrFCB0LJIIXx5lZ/D?=
 =?us-ascii?Q?FOvib3iGY6pP+7KFknuNBP53U/IvvxQ9fZVMfTJys1kWWiu5/cI/NRXc+nfi?=
 =?us-ascii?Q?2CnK91VYvgrvnvZsPaQXtyjtaDi8qD6TDtbD1M1KU9rGrdPyXz+5t/ouqDSl?=
 =?us-ascii?Q?ns4vEjkGpSqpZXMmUf5bHKTt828iPqDCwvMIlf3rjBeH07as3TUut/h88fBi?=
 =?us-ascii?Q?zlMMwGcJY3XFjyQZB8UweioaFBJ9OmE6Vl+gmZJLyucLHMPe1XfFVOmpkKmu?=
 =?us-ascii?Q?lyFmyHNUQRDv7gLp6RrGQZfYMtLMA8SdyNbmYLX1yAjjL8cz/bodB+MpyUML?=
 =?us-ascii?Q?trCz6VsdFDobPJ62a5hyrhb9XHwNMyDpI+tc86wPy2ckqp6lwguasNAJQOlh?=
 =?us-ascii?Q?suGc1sIjf18mGDB0dEr1VLDyOgbwmaK8ROdZKKLj4Ox/Z8HW0PCNdyAXkX27?=
 =?us-ascii?Q?hru4AJO0XZdtfTpfldXqDt4Kh7x0g1UrC8Ad2XcCSB2PTVGHLj5FN7xUeM1k?=
 =?us-ascii?Q?NF32bicN6zlXBO+aeHMsRGTPPH/sNUKQrofnBlgNmcQ3eGJFugLGwN7+DjRr?=
 =?us-ascii?Q?pdxqopnuMQtheAgI133+6E2l/EbSWaIohzVZeAzotOFNGYBnyeD4VkmIZabT?=
 =?us-ascii?Q?PiAn9ketkG2LacCyGuhJd3Ycv6n68mbM/ruEs1ZVbm0hBVXkQNv+kjIS81OZ?=
 =?us-ascii?Q?9x61+pBwJWHK7sV5JZPmfTwUxfBf0ysKHPEvXD1RnhDRAaAIJn5Cyzv78Fy0?=
 =?us-ascii?Q?SqdytqX9pFAc+IJWVajKjM7HHY+ZHjgY3W/ICva6DEzHT5Y8B5H67OACZfpj?=
 =?us-ascii?Q?IDkiRwh+VJf98H6yAIckKRxEQVMW8GWFUN6r0hs5yLNpE3RdDPHbAkmlpFhl?=
 =?us-ascii?Q?5WLH8wNWMY7E78yaQTASfB3CINGr9s1gX+badZ59XIGSX00Ysajwt9MkV2+L?=
 =?us-ascii?Q?qCg4u4uHCyfV+3lst/c3ExxDCL8898wUv3qFcjHG8E6KzDi1j0TPTZBe6ffY?=
 =?us-ascii?Q?MioLbMQkMDLd4pz7d2pWBAaOHn2XENWkwqOVvTtcOKEQEVeVWFSfMSbCbc+x?=
 =?us-ascii?Q?UtvBb45b7frn9sLNuH1AEaOxgoWLZ5opKVrxCuEPWEn7Snt90dByK3VQ7bfR?=
 =?us-ascii?Q?mXpWFIJewp3hsfHgL+Jr0VlSX98oSw+gnQLJUSPhPfzNT4+P5+p9SkGsmdeW?=
 =?us-ascii?Q?6pF0295WTFlmRglfa8IE6/qh/Bs3G3AS+xoH72q9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe821f6e-a93a-4851-634d-08dca0e9fdda
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:10:02.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dB6kgfb9PyHs7caREm+zTsL2P+xw2dSj1GcQxKdfh+wv8EpG8emTIo9z5NmDg0OkwojQLkG2etbFUfZwD+jRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7077

Use vm_insert_page to establish a mapping for the memory allocated
by dmabuf, thus supporting direct I/O read and write; and fix the
issue of incorrect memory statistics after mapping dmabuf memory.

Lei Liu (2):
  mm: dmabuf_direct_io: Support direct_io for memory allocated by dmabuf
  mm: dmabuf_direct_io: Fix memory statistics error for dmabuf allocated
    memory with direct_io support

 drivers/dma-buf/heaps/system_heap.c |  5 +++--
 fs/proc/task_mmu.c                  |  8 +++++++-
 include/linux/mm.h                  |  1 +
 mm/memory.c                         | 15 ++++++++++-----
 mm/rmap.c                           |  9 +++++----
 5 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.34.1


