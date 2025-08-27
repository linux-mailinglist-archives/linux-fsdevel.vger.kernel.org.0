Return-Path: <linux-fsdevel+bounces-59342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44106B37A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 08:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C41B60EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E0312815;
	Wed, 27 Aug 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ca0RW8/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013069.outbound.protection.outlook.com [52.101.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6834CF9;
	Wed, 27 Aug 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276872; cv=fail; b=XAVO91iyrTiueBochQpTnFlsHXeYOcDujkWzpdPkQvIyOh7+WqRfeigSl7vpvZKXliWvrW/dgWPHPB78OxEwEbc10+2zgNcmQ+3UxiJ2LewOWl2qmtynemSFyUbqqIEp+rwf5rPqTVKvTrK0Ch1PLgTHBHOO79Yq7az9MwM30TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276872; c=relaxed/simple;
	bh=gg9V3HfL0C6mPk71OWUuvALmsVjq/ReSRMS6w3SziPg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ADbsMvvTKOd7OtEIchfexRqlt5p9fMeCVBE6ztAjNrrCeYp7cUC7Q7TNLqDqO5tKU56FlE9PXssZOTrtPnZMsGqj0LFj4tQhNKyS7T1AuZDGPBXAhdFTnsn00a5nxeFeEN+yjTKNuoPqCA8Cw1mxz5roF9wY/L3Wl2iym9IGPJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ca0RW8/z; arc=fail smtp.client-ip=52.101.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5H4hRC1aTiu8JkLK5hWpI1BMj4MWJypWJ4BkuXDjHVXzeyGWgVcVZ0LQ6NB0NVtr5sNdoOhYIxHKsb+I9Vh4FCDjagWKZPoAskQLFFjZKpm0XremmNsol9n851BXHeZ47LwubzDizt2hEvyPXpcq+HjkgmOSj9Qspwz/jKSag6vN+GldiS/pCIhmVJ4QogGgz3JlXBz+Mp9l7qU8eEg8MmTqDBuHx/nN0qjTmVFUXmzsiBJcQ8dsc7+SN+LB2ux218O3lOfuuVrmZLLeohj3yqg2HkZ0MW9iOIZWjnHVx7iSIEw/8fGC9Tf2CnzaHFYfpEt8vAs35VPue11+vLRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KNp4X1EI/c+gCyueZ9sxH4bsK/pwxYOKQhl2uO41Kw=;
 b=DOquNznxkpr3qElhe3rgTHRJ5Ctsv6uA/NlLISIyfp4ymi0T5mnen0GEujQVtn+nvI8+R5x40dRARBBnCHcrePJdFD7e7WCE4STMzhwgYRZDIFCSEL03xnEd9Z0CU9gIxAmE4gL3U39rbGeBGQp+ZifS5PKuA+QT+yTgnZnlonbhi8FOmWoXfUFf7P1wGsCdBlEbi0HbzeY5fxug3Kxlw41xnm8qw6AzIMOYxoy3naLzPo4u+HdjlfNgA/9I8revGN08T2QzEIQvwK0d7wOY1gXNlvh+dF+mZyeix9Ac7dKIAWVLu7IGAYNXUvKVhMaEbbr/gY6NtfX2hro03+wxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KNp4X1EI/c+gCyueZ9sxH4bsK/pwxYOKQhl2uO41Kw=;
 b=Ca0RW8/zezYLoqefqhgmxCahYvEN6CPF9Ggms8CneWCrTqYBKpXDWGQqCvtRBAFn4cXzLaB9RI260RxEt8Eqgcz9s3uQA+SBZlE+juOQ7InGfNXx8iD86TKh2Zl1qe/3FBazoLsK9x82B+vNxvbbMY5ixKsiQGkXdhINhblXBdXKGAOBHnVWGiQFYpCIXFWSCiwoZWJUMhUqo50gouBQ0fni2Wak7Ymh9lsz/FOY/fY2lJzVA8hHnNLWPu8U5u8Bme5DiI0AVgN5kO3moqJazTVpvxUyGrcXy24qvc48LtZI/Cl/G6mgT456NF75iqBimxB5Eb5tsj7h3T1Xa0HPgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by SI2PR06MB4996.apcprd06.prod.outlook.com (2603:1096:4:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 06:41:06 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Wed, 27 Aug 2025
 06:41:06 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [RFC PATCH v2] hfs: add return values to hfs_brec_lenoff and hfs_bnode_read to improve robustness
Date: Wed, 27 Aug 2025 14:40:18 +0800
Message-Id: <20250827064018.327046-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::7) To TY2PPF5421A6930.apcprd06.prod.outlook.com
 (2603:1096:408::78f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PPF5421A6930:EE_|SI2PR06MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a45eb6-768a-4993-8df2-08dde534b316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcHoBt04hpXIJd6kul1jrHgG0ctSJbiySyEfc62F0B0Odj4l47qbzRKpf/AS?=
 =?us-ascii?Q?WGUWpErk8HrDvFQrMQgBmzt3ynd28A4oxmDnraIsT15A1eGFYzTO1K8uZwE+?=
 =?us-ascii?Q?tuXsWw54+BPDTasBl8aYFabUSe+84TEJ5R57L3YIFf2uIIqUMidF2aT67lM5?=
 =?us-ascii?Q?N4zn1Q8juE8/XkOhKb42YXq0GXLe4+dT6v1xLtv/odZYzGl1TynehCdd5x/E?=
 =?us-ascii?Q?sPE/cxi6jGfpiTDb3JW/cYrPMA0YCZ7pGKVyFX87YiuNyiREA3x9D0RRlInR?=
 =?us-ascii?Q?s1UTBa7Pmg5GgcaYSYGFzml26do+QiuhxGb/K4J28B5aejb1d3/tCegZGAAs?=
 =?us-ascii?Q?FHFF9dL+EKTsgkv3ozDcNI67ZFU2HzLvt8Hu4s1evJb73wTQ3f4g2rxXBqo4?=
 =?us-ascii?Q?0Fj3ghH0ypj+qCyrAgXFs2XtmeOA86W+X7XWlwpptNqizmqogF9Jm+P6S6eK?=
 =?us-ascii?Q?gh+4wzptlhTwfFCbMiiXFjXL2PfuZrhV9lh0U6DwKLbGsRaefvEBvKLLkP3A?=
 =?us-ascii?Q?Hm6YW0CPjPlIluYXQBbzh8m8P7TjfJ7ba8aKiEA8pCkTjgH/d683BQfq1+ZI?=
 =?us-ascii?Q?4enVhhswjPPArLUEuOnTTHhjiEN9YcZBUzkCke9gIAlYMJip2XKsGhnv70a0?=
 =?us-ascii?Q?5SaINhlGO2b35DDBREebv2/6xIr04beldJCYI7KBUNbdwJjjLEpkkFNwMqnp?=
 =?us-ascii?Q?4XVkZs2rI2yUJhhzI3P3Zewz+GQV0Os9L1naeLYosjCR0ax3XbE+Csv7UxE1?=
 =?us-ascii?Q?agYDaa1t70W4ohTO26R3aDpUhmCxvY+pTnhuddJ40BupplhM7SeDNJ8+YfIo?=
 =?us-ascii?Q?uO5jTzDbvUFSE3/SjVQDBjSe6v5aMMKcOyKewbesLIabNn4qfnvHYruTi02o?=
 =?us-ascii?Q?3ZX7Uy6nYMQ4dC+FybPRY2Oz/ieMkSPj+UnX2ACh0iEysiH0kugr+Lke+Wel?=
 =?us-ascii?Q?R5p3rxzucsqQJnW65BFRQ7giunN24SbgiOsiNdVZVs8aFWMv/+9wZwegcRdY?=
 =?us-ascii?Q?7D3ALIKsSFiacC/+L+cssBgfvT1dkFwl7CFhsP/RoZwymBAWsKN0aZ1Wvjs6?=
 =?us-ascii?Q?mxKlEoAfH1tKH7CZSbyL2rrtMeSgGHugNCgJJ/tgyxMms2myd2Gsg72Ipdv0?=
 =?us-ascii?Q?wvnaK1dVGtFBcbUaAoaTRwLjCbdpeJGQPVrA0nd3dGLfkqGYcqYUOcZ7NEz5?=
 =?us-ascii?Q?uBbfkDIcfKgkVm4PQEz9hC77qmr37qopLWF3VzDVswc1rQYQK3EzSC12Mv6e?=
 =?us-ascii?Q?+9WC8cSS4bAMkDsm5ksyucrB1ayZjE0Ep96w8mBDGQAi55nXL9PUfFgq+wWn?=
 =?us-ascii?Q?7LnO9U/+zP/tJlv+CjYanPCkNGD5wIeAuH5WQnLnrYCXBB4mUtxtnD3tV+jo?=
 =?us-ascii?Q?NKoEGe+eouIfC8QVP3Xuv+ZSnRh5Ff2jJyMmQq7EwRl9+Y2AxpLmm7AxzJY2?=
 =?us-ascii?Q?24lKAN55CV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/QOZItaeG4gZSEfYCttTKwIahqpU8urdRVvixwyYJtrjJz9gcJuLlr1GzNx?=
 =?us-ascii?Q?AnrFJBLtVBabDRDAhSnsr8ic3Q7eaz1ZPSDDHZn7tC2sLz89HtqiS63YKGEB?=
 =?us-ascii?Q?VfIzl3HuR/A1CKxJ/aNmn5q/SnLErfUHGSo3nhXfPx4BhCPiO1IHxog4Kcya?=
 =?us-ascii?Q?m7GqgitdSsA1QzA/VWfbwxFpqJO1/EGU1j2iNLPDXPVAsyQJpuLNgX7qJB+P?=
 =?us-ascii?Q?v2nf8/Vq94st2m60UNkyhkSdcedddinEaDJu1498vJGJn5WRagmS4lONq/Zz?=
 =?us-ascii?Q?EryCHXs0dP93ldHQWxjf7nL2ZjM1VGmve3rEjsGCCsYq1HU24dVH+v3MgXjX?=
 =?us-ascii?Q?5McD+uakohpiH/7s/CnYPWQ/QB9W1m/RSCfDgHSzddy/ZMEF2VO0CVG+Ieuf?=
 =?us-ascii?Q?Jjngu74immXUiBGjsFLYiyIW3cSopzbO2hkqj/m7/JxHvpWa0F7qX2+XbV/I?=
 =?us-ascii?Q?Kzvh19vsbC9d7uF9EBAz9gN5rNVHTGwkO/d5EfC/GOdL/91kXCIETgY0/QRq?=
 =?us-ascii?Q?LwjN6j3yap4OTOzsJZK4YIOUzAEMBFIbedw4+Ao7kVjCVySVxVOvJctWXisP?=
 =?us-ascii?Q?C6t9IkR/0Q0BuoxCxfjLGIIJ7meCUNDf78QsceX76A0ijuMgxsDwa+ymzAaS?=
 =?us-ascii?Q?+Iq5PXL0WywMylPfL1BQriu8Sg6RY0huGagevBjg0Vi2u6gNDBLykXNxuy9y?=
 =?us-ascii?Q?Z7arOWtOXHzwDmyIvS+ie89nfceeJ8KomX4MyZ1N3xsCblilSQIYz2tqiHrn?=
 =?us-ascii?Q?3cRyN2l71poj9tzULGEavQJ3/65U/gDqMVIlixUijFXuJVBj20odz31VFQee?=
 =?us-ascii?Q?cnB6X5qgUymZEl33rqnDmAUM/NXcOtWEH4we4sY/gX8LtwinycMiyw0elwuT?=
 =?us-ascii?Q?gYaGKV5wch9hFPx30EI3dWFRajdUc5LACvyuU85vMhSNFYRxw9xYQMKFKTYG?=
 =?us-ascii?Q?oWPCM1ptTRd9C4Kr3B/CtNCnhqwI9G2aa07gCnRhaRS9qu6QvtfDjpoMaeGI?=
 =?us-ascii?Q?JWugGdtwy1Yqo+AIeNc6rKcRzNTl28UmzqWbb2Tp02Og/16rxuvhjWgtaoU+?=
 =?us-ascii?Q?pe87CxQvmbWy/i8jkKHhMHFF5vMTZCdMg2UFLicKGjzQ+sUPLd2s5Jx6UMr8?=
 =?us-ascii?Q?a5qUlFzLCAbQmxGZUuLb47wiyanuD+DzGeI529Jsv81wRE7aRiv30FMwHMUF?=
 =?us-ascii?Q?HEoF16Oz8v3MHIr53BfnNzPNqMSxiVCI4QKhH1sblsJAcdzceouUVNWIo9Ie?=
 =?us-ascii?Q?yZckep9i3XfkgPfDWtiGcNe/g96HJjuakkm38xB8gQlw3Os//aNTLC6g/NB7?=
 =?us-ascii?Q?og4njd0yKq91joN/Wn8+ooFCFiNlRsd1zrYFm6W6qEn8fN6GJZrcNMm9eshr?=
 =?us-ascii?Q?SiVUIjZ8X11ZUjXda2DXeHx4MHBrdKu1oqYH9/10rDbq8OolER3yc4Ugsq0a?=
 =?us-ascii?Q?dzPGyvr70fIXdg31acJoxEwIjIyH9dQYMRPdsJpAvSx39GXtn0Yh6Wac0xfZ?=
 =?us-ascii?Q?/bNhmkuYBefRw7CGOp9Lp8nB9/Zh2ioQtHGj/rzxmdN5VuNQgKmUaY8Z9uRF?=
 =?us-ascii?Q?LYkMI8+9Gsx5wiPgVdYlQwpOqXMbj+xJ3tSPuUzZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a45eb6-768a-4993-8df2-08dde534b316
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:41:06.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3qT7EcpQSeyvWM3vPQZ3gaeRchrDO0f/p6fQDn5zRWV7qxS4ob/l+LU4HL3b2f0h5npnTw+upgOjYxeiztfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4996

From: Yang Chenzhi <yang.chenzhi@vivo.com>

This patch addresses two issues in the hfs filesystem:

1. out-of-bounds access in hfs_bmap_alloc

Analysis can be found here:
https://lore.kernel.org/all/20250818141734.8559-2-yang.chenzhi@vivo.com/

With specially crafted offsets from syzbot, hfs_brec_lenoff()
could return invalid offset and length values.

This patch introduces a return value for hfs_brec_lenoff().
The function now validates offset and length:
  - if invalid, it returns an error code;
  - if valid, it returns 0.

All callers of hfs_brec_lenoff() are updated to check its return
value before using offset and length, thus preventing out-of-bounds access.

2. potential use of uninitialized memory in hfs_bnode_dump

Related bug report:
https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201

This bug was previously fixed in commit:
commit a431930c9bac518bf99d6b1da526a7f37ddee8d8

However, a new syzbot report indicated a KMSAN use-uninit-value.
The root cause is that hfs_bnode_dump() calls hfs_bnode_read_u16()
with an invalid offset.
  - hfs_bnode_read() detects the invalid offset and returns immediately;
  - Back in hfs_bnode_read_u16(), be16_to_cpu() was then called on an
    uninitialized variable.

To address this, the intended direction is for hfs_bnode_read()
to return a status code (0 on success, negative errno on failure)
so that callers can detect errors and exit early, avoiding the use
of uninitialized memory.

However, hfs_bnode_read() is widely used, this patch does not modify
it directly. Instead, new __hfs_bnode_read*() helper functions are
introduced, which mirror the original behavior but add offset/length
validation and return values.

For now, only the hfs_bnode_dump() code path is updated to use these
helpers in order to validate the feasibility of this approach.

After applying the patch, the xfstests quick suite was run:
  - The previously failing generic/113 test now passes;
  - All other test cases remain unchanged.

-------------------------------------------

The main idea of this patch is to:
Add explicit return values to critical functions so that
invalid offset/length values are reported via error codes;

Require all callers to check return values, ensuring
invalid parameters are not propagated further;

Improve the overall robustness of the HFS codebase and
protect against syzbot-crafted invalid inputs.

RFC: feedback is requested on whether adding return values
to hfs_brec_lenoff() and hfs_bnode_read() in this manner
is an acceptable direction, and if such safety improvements
should be expanded more broadly within the HFS subsystem.

Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfs/bfind.c | 14 ++++----
 fs/hfs/bnode.c | 87 +++++++++++++++++++++++++++++++++++---------------
 fs/hfs/brec.c  | 13 ++++++--
 fs/hfs/btree.c | 21 +++++++++---
 fs/hfs/btree.h | 21 +++++++++++-
 5 files changed, 116 insertions(+), 40 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..aea6edd4d830 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -61,16 +61,16 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd)
 	u16 off, len, keylen;
 	int rec;
 	int b, e;
-	int res;
+	int res, ret;
 
 	b = 0;
 	e = bnode->num_recs - 1;
 	res = -ENOENT;
 	do {
 		rec = (e + b) / 2;
-		len = hfs_brec_lenoff(bnode, rec, &off);
+		ret = hfs_brec_lenoff(bnode, rec, &off, &len);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		if (keylen == 0 || ret) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -87,9 +87,9 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd)
 			e = rec - 1;
 	} while (b <= e);
 	if (rec != e && e >= 0) {
-		len = hfs_brec_lenoff(bnode, e, &off);
+		ret = hfs_brec_lenoff(bnode, e, &off, &len);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (keylen == 0 || ret) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -223,9 +223,9 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 		fd->record += cnt;
 	}
 
-	len = hfs_brec_lenoff(bnode, fd->record, &off);
+	res = hfs_brec_lenoff(bnode, fd->record, &off, &len);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (keylen == 0 || res) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index e8cd1a31f247..b0bbaf016b8d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -57,26 +57,16 @@ int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
 	return len;
 }
 
-void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
+int __hfs_bnode_read(struct hfs_bnode *node, void *buf, u16 off, u16 len)
 {
 	struct page *page;
 	int pagenum;
 	int bytes_read;
 	int bytes_to_read;
 
-	if (!is_bnode_offset_valid(node, off))
-		return;
-
-	if (len == 0) {
-		pr_err("requested zero length: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, len %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len);
-		return;
-	}
-
-	len = check_and_correct_requested_length(node, off, len);
+	/* len = 0 is invalid: prevent use of an uninitalized buffer*/
+	if (!len || !hfs_off_and_len_is_valid(node, off, len))
+		return -EINVAL;
 
 	off += node->page_offset;
 	pagenum = off >> PAGE_SHIFT;
@@ -93,6 +83,47 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 		pagenum++;
 		off = 0; /* page offset only applies to the first page */
 	}
+
+	return 0;
+}
+
+static int __hfs_bnode_read_u16(struct hfs_bnode *node, u16* buf, u16 off)
+{
+	__be16 data;
+	int res;
+
+	res = __hfs_bnode_read(node, (void*)(&data), off, 2);
+	if (res)
+		return res;
+	*buf = be16_to_cpu(data);
+	return 0;
+}
+
+
+static int __hfs_bnode_read_u8(struct hfs_bnode *node, u8* buf, u16 off)
+{
+	int res;
+
+	res = __hfs_bnode_read(node, (void*)(&buf), off, 2);
+	if (res)
+		return res;
+	return 0;
+}
+
+void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
+{
+	int res;
+
+	len = check_and_correct_requested_length(node, off, len);
+	res = __hfs_bnode_read(node, buf, (u16)off, (u16)len);
+	if (res) {
+		pr_err("hfs_bnode_read error: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+	}
+	return;
 }
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
@@ -241,7 +272,8 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 {
 	struct hfs_bnode_desc desc;
 	__be32 cnid;
-	int i, off, key_off;
+	int i, res;
+	u16 off, key_off;
 
 	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
@@ -251,23 +283,28 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 
 	off = node->tree->node_size - 2;
 	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
-		key_off = hfs_bnode_read_u16(node, off);
+		res = __hfs_bnode_read_u16(node, &key_off, off);
+		if (res) return;
 		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
-			int tmp;
-
-			if (node->tree->attributes & HFS_TREE_VARIDXKEYS)
-				tmp = (hfs_bnode_read_u8(node, key_off) | 1) + 1;
-			else
+			u8 tmp, data;
+			if (node->tree->attributes & HFS_TREE_VARIDXKEYS) {
+				res = __hfs_bnode_read_u8(node, &data, key_off);
+				if (res) return;
+				tmp = (data | 1) + 1;
+			} else {
 				tmp = node->tree->max_key_len + 1;
-			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
-				     tmp, hfs_bnode_read_u8(node, key_off));
+			}
+			res = __hfs_bnode_read_u8(node, &data, key_off);
+			if (res) return;
+			hfs_dbg_cont(BNODE_MOD, " (%d,%d", tmp, data);
 			hfs_bnode_read(node, &cnid, key_off + tmp, 4);
 			hfs_dbg_cont(BNODE_MOD, ",%d)", be32_to_cpu(cnid));
 		} else if (i && node->type == HFS_NODE_LEAF) {
-			int tmp;
+			u8 tmp;
 
-			tmp = hfs_bnode_read_u8(node, key_off);
+			res = __hfs_bnode_read_u8(node, &tmp, key_off);
+			if (res) return;
 			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
 		}
 	}
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..d7026a3ffeea 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -16,15 +16,22 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd);
 static int hfs_btree_inc_height(struct hfs_btree *tree);
 
 /* Get the length and offset of the given record in the given node */
-u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
+int hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off, u16 *len)
 {
 	__be16 retval[2];
 	u16 dataoff;
+	int res;
 
 	dataoff = node->tree->node_size - (rec + 2) * 2;
-	hfs_bnode_read(node, retval, dataoff, 4);
+	res = __hfs_bnode_read(node, retval, dataoff, 4);
+	if (res)
+		return -EINVAL;
 	*off = be16_to_cpu(retval[1]);
-	return be16_to_cpu(retval[0]) - *off;
+	*len = be16_to_cpu(retval[0]) - *off;
+	if (!hfs_off_and_len_is_valid(node, *off, *len) ||
+			*off < sizeof(struct hfs_bnode_desc))
+		return -EINVAL;
+	return 0;
 }
 
 /* Get the length of the key from a keyed record */
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index e86e1e235658..b13582dcc27a 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -301,7 +301,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
+	res = hfs_brec_lenoff(node, 2, &off16, &len);
+	if (res)
+		return ERR_PTR(res);
 	off = off16;
 
 	off += node->page_offset;
@@ -347,7 +349,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			return next_node;
 		node = next_node;
 
-		len = hfs_brec_lenoff(node, 0, &off16);
+		res = hfs_brec_lenoff(node, 0, &off16, &len);
+		if (res)
+			return ERR_PTR(res);
 		off = off16;
 		off += node->page_offset;
 		pagep = node->page + (off >> PAGE_SHIFT);
@@ -363,6 +367,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	u16 off, len;
 	u32 nidx;
 	u8 *data, byte, m;
+	int res;
 
 	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
 	tree = node->tree;
@@ -370,7 +375,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	node = hfs_bnode_find(tree, 0);
 	if (IS_ERR(node))
 		return;
-	len = hfs_brec_lenoff(node, 2, &off);
+	res = hfs_brec_lenoff(node, 2, &off, &len);
+	if (res)
+		goto fail;
 	while (nidx >= len * 8) {
 		u32 i;
 
@@ -394,7 +401,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			hfs_bnode_put(node);
 			return;
 		}
-		len = hfs_brec_lenoff(node, 0, &off);
+		res = hfs_brec_lenoff(node, 0, &off, &len);
+		if (res)
+			goto fail;
 	}
 	off += node->page_offset + nidx / 8;
 	page = node->page[off >> PAGE_SHIFT];
@@ -415,4 +424,8 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	hfs_bnode_put(node);
 	tree->free_nodes++;
 	mark_inode_dirty(tree->inode);
+	return;
+fail:
+	hfs_bnode_put(node);
+	pr_err("fail to free a bnode due to invalid off or len\n");
 }
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..78f228e62a86 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -94,6 +94,7 @@ extern struct hfs_bnode * hfs_bmap_alloc(struct hfs_btree *);
 extern void hfs_bmap_free(struct hfs_bnode *node);
 
 /* bnode.c */
+extern int __hfs_bnode_read(struct hfs_bnode *, void *, u16, u16);
 extern void hfs_bnode_read(struct hfs_bnode *, void *, int, int);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *, int);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *, int);
@@ -116,7 +117,7 @@ extern void hfs_bnode_get(struct hfs_bnode *);
 extern void hfs_bnode_put(struct hfs_bnode *);
 
 /* brec.c */
-extern u16 hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *);
+extern int hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *, u16 *);
 extern u16 hfs_brec_keylen(struct hfs_bnode *, u16);
 extern int hfs_brec_insert(struct hfs_find_data *, void *, int);
 extern int hfs_brec_remove(struct hfs_find_data *);
@@ -170,3 +171,21 @@ struct hfs_btree_header_rec {
 						   max key length. use din catalog
 						   b-tree but not in extents
 						   b-tree (hfsplus). */
+static inline
+bool hfs_off_and_len_is_valid(struct hfs_bnode *node, u16 off, u16 len)
+{
+	bool ret = true;
+	if (off > node->tree->node_size ||
+			off + len > node->tree->node_size)
+		ret = false;
+
+	if (!ret) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %u, length %u\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+	}
+
+	return ret;
+}
-- 
2.43.0


