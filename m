Return-Path: <linux-fsdevel+bounces-23482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78292D39C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D11C2120A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0E19344B;
	Wed, 10 Jul 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OiTLtJUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0A128369;
	Wed, 10 Jul 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619902; cv=fail; b=VEQZKAwjveDH9wL5sYlEwcPtn7XowDLuw5w71Ja0cig+4oDochjGemBJiJRHl4rDbTR4SfidQFaXrhMYwrA9n08C8KA+8gfoyJVRTeBPhfgpOHneAlQAsmancO2l8PlvebUityNmkxEYIWahr9f9Qbr5oWpXXrZkoooYOex8LpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619902; c=relaxed/simple;
	bh=7jQqwDm0MXfoSh6Wk/rFcNBHz1G4QRxsSCcSK5si6Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EGWlceDTKH6rkvDaTu7DeARGRWu7/PWpwSjuURYxg9dR1CNfwqZjivNtPGXFzXG+tkcDQwjUrLMLsKfn3Maok5rW+CKqT9ybxYP8V2jOb9p5BkM9OWdUAcOYD/saQIDokq2KqOVrZ1aFElgpnK6ovTTEWOZV/Vr2ThuA7z9N6bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OiTLtJUe; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXohaOyD5v6GL0X0OPJKkNN48/SsCzeCuM4v1Apubm/WD3riWZo6KG8JnC4IN2hJ0mXFVlpSkTfzAxx0xtSwtqOHFj16xJEC3rKtxW7vu5gvkoWIbqx04SlBStRXuXpBJLKt+lNcFN+EmoZNgyN2M7PKNUFGGjVRuTVCaaZvNSQWtbufo0yL1EfQ902rJEMCAvBF+/WeJscNhhOTGK3vXjx+SOuUl+uxblWVPSpYiSbNbsvyF85TRBQOWELm/7nno5kwhf154W+U7c5S8mtyqqiCeXlIITAHs35JgO6rHprEq7WyWR+kgzA8icNIKGq/lWeLXwJm3GOsEkJraUNTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVfWZv1bxzI2AFs3g8Xez+PQlX+2bEmv+QBnAFOvTTs=;
 b=mj5GTVmp+yqAeKZLoQnTeF+EtrfUDIAaqp3BI7Ti7tDC95sVmQuhzkOwe9/QwjYuShRh+ge1Nh0v9fcrvNseQvf5xUCX4u98IIeKeaim28oozT77JBtQQp4VFO3uoz+fsjob5NZmyzNwT8Xcimvh8R94EPKwRmWRl2S6i+B8f83UycU+xrTEQHbDLVAntwZot3TMA7uXJ3gbMWm8Ws6pAaKxHwOZFk8iAr2mVv5bV1yLMLcAOYIkRJcKjobSLhNBZGjaRPMvu1eV48fLdtaxBhz5yyc4G8PXin19p5RFfcW0OJsLwfE5w2yWConEonkdm2mRjG10xjNpvjEJH+kLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVfWZv1bxzI2AFs3g8Xez+PQlX+2bEmv+QBnAFOvTTs=;
 b=OiTLtJUeF91hdaaG5twoAQg63D/Dr/S9XsvwbbFMP3oKY4lldDiZ/ThQBMuF+XQYx4QUEte35WjchC6KL7YXUp3a/JwagbtCaG/DmFIpRDjovtY4YHjOastvnxeLJS3W9xsNgvf9gZKH0tON+krd9sOoBlXRRTs5UtJ+ckQjgrj/QufEk9eNuY5XJq93Kuh1ew+YOMvhzZEVlW9AVbsTkQGsQhq+ocNfO+6q5hZLPmjne9YLN2B5lSLvEJVcSAUORpKDep6DJ/SAw1Nvx5P4uL+jAFB8QK7px4q3PNv0Dqcw940AyCKUGkSBSs6MlUjJHrnVcZ8Xjxv8lVYgpxuMMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6383.apcprd06.prod.outlook.com (2603:1096:101:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 13:58:14 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:58:14 +0000
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
Date: Wed, 10 Jul 2024 21:57:52 +0800
Message-Id: <20240710135757.25786-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d1f3d9-dc82-42b9-e7c7-08dca0e85737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Lq4GyPq4CpU2WpK5VvQnF0Gm+9EqPSZWlL50s2IBT9aBt2Px5HLy5AGRWDP?=
 =?us-ascii?Q?xtLEZbsiTbHUdfgfFR7um/lT7q+EPfUnP5kIP9rn5FZGuhMeBVXxiZQL/CSA?=
 =?us-ascii?Q?ZIW4cM6KDHK25O44DraJOlGvGb5oNSA5N6ABAzORD2kREEiLhloT3Id6ZI1f?=
 =?us-ascii?Q?FPFhWJbSszEr6Rq2/2mMH1rx1SZHX+0zrT6Ea0VAPep8XWffJ2lxsRHL03eF?=
 =?us-ascii?Q?UbeJA0Qo/huzxjt34a22x0IJ+cNf2FBMnebLKGiHRSEoDWZK4Lpv+OGIj3TL?=
 =?us-ascii?Q?5r1Nt/HECKvWezjCShQaLK5YqXZMXD44vDs89ICmOH8JGDAegNgM45UW1Mtq?=
 =?us-ascii?Q?+A8d0zpS1uMUZHN3w/PLMzhelcPmYQmz5cOjIANAbF90bvWV8yx8DYIYjLah?=
 =?us-ascii?Q?0RrcPjgJxCs/BFZhLMpd3ngOQ+EGNjWWVvUvE1840x71Iv7Bm/jelCnL5qRa?=
 =?us-ascii?Q?421E6LvJ+eMfiUM0S3SKq5cX+iqfZoGb2+wy4j+1Qxp6diqG/ZZy8ajKI5BW?=
 =?us-ascii?Q?MsCInYC9vBXbARP9Zb4PuZKJwo6WHIem41UG7siTpeNt10VbsqFZnAAlvo2S?=
 =?us-ascii?Q?9Y/lUdMM3BcWFanJFLNVy04DZMupGYnc2QcxM+QwiPGgDRF2ICqvQo4qbhrE?=
 =?us-ascii?Q?IkC7VyCMlHXo9Z4Y8Ku5YqnCgQZXYE39LGU0X8/Rd/eBVxU53YBrLaWpk08X?=
 =?us-ascii?Q?vRFK/E1V1U/TRW0e9ClswvvlQ7RqKPLdo1wL60lgY17lSd4Mh0XyMFRl+Yia?=
 =?us-ascii?Q?ZJcL0e7l5CSPhoMAg+KQneVusaS2KQ9VMSgg/48bzb1xNOtfh8oOHy2T7woq?=
 =?us-ascii?Q?PeOqk3sfRSEyighEVYyPpd98iS492nZfkoj+z+qpx+XSL4Ydo32k+Qxa2wre?=
 =?us-ascii?Q?ksNKIgyM6c8TfDvbCOVsIkCKpq+HkVx9UGk2Wb2txii1jj6UCNkT9Jy5FutE?=
 =?us-ascii?Q?Lxd3UJmRcILonmygKeRmmj0sS/t0T73Y8DqK31lSGYJ8Yvjb2twXKf8zFZy3?=
 =?us-ascii?Q?K/sMw9eN7aSvaDy/CTnr7jGvdKiRmv0k4KrK5389QcmGm5QcGKD1E3THcZSr?=
 =?us-ascii?Q?+Zyr+7+42010iBesZ8/40s9iMz9J6pfjBkmp1MWvyvfYuTzbFsMsevCMHwaD?=
 =?us-ascii?Q?lmf/Lg/ltZ4wmPlLgI9jYVz8snldteYotLmj0QWEWrjgUENGSC86SyP+gUO+?=
 =?us-ascii?Q?Y7iI5bc2V7C8PKQr9uTdUruV8gV1ayB/lIiBAD4Y8vtsF/vjz6OsWw8aX1Fw?=
 =?us-ascii?Q?lyj2m/Hxi+vjuGI2pxMAJm0y5aaO1Mbi8yx29xMBP85Xdmk5eaykgGAlzxhV?=
 =?us-ascii?Q?1G+b4FHqMm+eVh/4OEBtcsI1oJt1tSoVJZe8dsH9Nr5h89C8HesMt9wHR/s7?=
 =?us-ascii?Q?gGkXInVeXV54a6w/q+yxJekL+0z8K9K8hejod040YfojhKEJw/4pRtcRt3dT?=
 =?us-ascii?Q?9qCyrgcWww4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/oZD+FZ8889yxcdc+raAqIq+zMzHaiXDMnscRfKSMA+cz7yzQJJucOTHPz/?=
 =?us-ascii?Q?N2kU51VEY1rzHPNk39sBd4/h9oNPPLcMcISEx0Bot+r1nm6E6apNh3WD6Eza?=
 =?us-ascii?Q?s93lx/7ihQGyp55OEO0UcuNG8zQ7OHTOEXtUo31dHV2yBqBARwHUbISShcPl?=
 =?us-ascii?Q?qY8tkmnPCPHpDUUpB1GqAlyjjqWn/i21FzyC2H+uid5jn4hQU9DuGs7yZPUL?=
 =?us-ascii?Q?+rAceKwsHffz7GOo6eVXdnbeO73j/a7WPZolii310kNMr3CgS3Hhy6fXeAJL?=
 =?us-ascii?Q?c01IS1s5nO1zOQ1k1RsriPEeur+6eDlOJBefil144F7UAvFWimlXwc4NLvCU?=
 =?us-ascii?Q?8HWy7uTxoBnVW03VTNEDq9DfmUYLEfIKpO5ad3O4sPKu7l2suSH3759AAc6z?=
 =?us-ascii?Q?Rf7/B1Ovyp8ICYRbAjraB788q7Sx2AQpf5+EEVQZc+LTZykBc1Q3SAekqtSC?=
 =?us-ascii?Q?XQnIjKeRiFkWvD7xmi2Oy8aevQzTAs00eCZXZdo0rd6ffVKXKseTwRgvD97B?=
 =?us-ascii?Q?U5ZmxHqCkILSi6HCHswY8l8iwGDLsxcrk8Ztu9R1b4uf5VTs4aFIywmsZl5y?=
 =?us-ascii?Q?HlnwahJFhbFZ/8YsDrbrtxPbFpDWM+9tzSJVwgcyf9dF/wkXeYuDohY4joIe?=
 =?us-ascii?Q?Tp4WbdJurCVVnPldrE+AFBoLGzNlYsaeLV66kASmjql0YOqiFy/iS/PPUiRL?=
 =?us-ascii?Q?pJFUX/gEJQr15DjP1xt+wv0A0aWOC+va1lQ3tunq1ZfMDg1cWl10xSLVoiyN?=
 =?us-ascii?Q?EcUnqhsVfV5VjJ17xD5IBzsMNeYgG4iFnY0wCfTP+46jWDHIP6WBdT5hIKrS?=
 =?us-ascii?Q?+zZ3UhnJEVnhtsXQqvMQBWfOkinM+6OTMpkI/5ioCh+5Kzn5UdMXaVYGX0vN?=
 =?us-ascii?Q?cJTLrPrC+spg3AGCpsv9K3ihJlYDcjxKdSDIHeyMQD+0M85MXcRScrmJnG2R?=
 =?us-ascii?Q?VejcIAAKH3Dr6m/sUGu5VDG7KAFeVeh03w5glekg77Z/qwZI1rdVYbkSDiwT?=
 =?us-ascii?Q?8fPKfdUrExP/49vaIHT0Van5zGpO26p2+eKiG2dlROwJqJEONiqp8U40leZF?=
 =?us-ascii?Q?r2YusWhdbEwwNvzUrFKZLyg7AIB/qHsosHBs8/XPD/nlBNM3VBTimI1UwNLH?=
 =?us-ascii?Q?c1aqBMsHGzzK1NS7NE2FecGtXpl+JvsQoGuJf8THPGElLuShQKLyBYnOKyCi?=
 =?us-ascii?Q?aHXSPQKXk6vTkmBJbJxebjpaKOhsrd276pQHMdyExCc8k602MsphO/Tk9daG?=
 =?us-ascii?Q?xETdW54MlDcjksNTxFRN9KR48Qs31TF0h+g3MV27STS3o82/DquuidsnDX+8?=
 =?us-ascii?Q?0BSQx5jmQPqRDzN7gd8TrtrZ5hi8cp7NkHFttBKck8S9lK51dCJ+iYFU1ysR?=
 =?us-ascii?Q?CsF5ccMICDcVJ9BxRz5MX/L3Eu3G7bqrDrdJXmThDRk1OFMyFhwP74q51FSi?=
 =?us-ascii?Q?1Z/GnA+wSQwMvr5eyg6XX7wMgGxy0O+45ZDz1xkT8CWvivnkAywhRmEJ5hbp?=
 =?us-ascii?Q?oOmxo3C+X9RcAzhXdiseL7Sm2dcRgT5nq3BBG/uL2grd/liHmn7arwqKsK9Z?=
 =?us-ascii?Q?6MdHQuhNCfQBjW4LLlD2LKPD78xjsesG3DzndE/p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d1f3d9-dc82-42b9-e7c7-08dca0e85737
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:58:13.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3v8YVbJbbp+T5wvFwgq+NGy96poQFcPF9qNBjTLgJRLs836ahCjMTcPl1zQ/LNnmlxQNF8ed1W3QVHuT2zu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6383

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


