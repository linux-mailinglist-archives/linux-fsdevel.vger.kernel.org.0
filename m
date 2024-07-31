Return-Path: <linux-fsdevel+bounces-24657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F794272B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13531C224E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDE16CD39;
	Wed, 31 Jul 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ANeWDiib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2042.outbound.protection.outlook.com [40.107.117.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82717D2;
	Wed, 31 Jul 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408714; cv=fail; b=nnwusZMFiROg7m2QNaU5+pHW8Q5d500KNwC7YAVkDr8StM4UUjo8J8msHwE1dCIenl2Dc7dsEipYNGRbjrPRf7SD+YoXsQPTg2r30VBqiksqQAODFGCKh0vmgNjJOq3GH2PVa2jsj1jMZsIvVw24lsBinl8TSbYpR3i9xP5mzU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408714; c=relaxed/simple;
	bh=hlFDQRdXIsLaJ+0UepwewvfgiTE1RDIbDWX7UWZGWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A/QJLCo1emMan4zhZVHC5w2FPHDezoBxpn8gry0ICzcFpe4kY3GnbIiQ/Igxss6im8qMTUN8qQyERpDMm9wKhgCAIuE8lQnnC5gYAr6+oOeBiPDZ4a1qkvVBcdjocu5cLh+LrlX361C78UU6b8+/2r6z0nKYcmXCHNwAxib+Wj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ANeWDiib; arc=fail smtp.client-ip=40.107.117.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWu8GoxfiBpxqdkRDgBv9FAylS8mZaDnpc2l83LcBPhoCVyLuuh+jR+/Az4EjPmo0hG7vlkgh7G+Q8ywAsu93jLs1+ARODSw1nt1LmGlkJ59ZXF+0bXoOe4uHBVo8mFvVtqgKZTiTgGZ2a6zGEzer5eKwfGiFULnScPL0CDcgcakYPjTVyd9SOylZFHODPOQKAH8fQimYAIKVfBLPLtLCnhEnWYhGP/Iv/G9AV4OU19czjNlofwMC2WyrrM8kELfdMp/le3POUmnv/tuTKcTRbG/S7NQtrenJ4xEZSdUbeSL0ElQQxf5yoHzRS5xAyIXeDlu8jyo37TwtMMloPKm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3veoaQjIdWTy2ikVuNZYwz3n7DbIVPufqW/C5yMM6Q=;
 b=lngyYXhiom/Dt2LhvrRV9ZM3a2IcFaDHzWF91nOPRlOZv90Oy/ZAzG0Sa4vfhqw2u/6PgRm8LoFKF/L0r4Im776hoBzayzQO24OL0ySPIA5hML/v/fzE8L0PmiAz1NU5zCXiBijEsVq9M23AjAA+Z2FWsRCdQnbY+SQcW5EnG2Y+Diupq34O7WtRIXwOT8Bs8W8mxMBFO5um57mQRg8lwHOB6yzg0jY2CgoD7i1jipfLcYqw/5BQmZfY2d6wAX+ljFmKVFKNeC5zsvktG4kPbGNSyfDnIo0BwEeBkE4mDg6FSAfrNBT0TjcJt8ZOX+hEbGIkiY/wOT5O77VakBzBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3veoaQjIdWTy2ikVuNZYwz3n7DbIVPufqW/C5yMM6Q=;
 b=ANeWDiibMmdBrRgD7NS9uChjjP/jogBx8l/EFS7l4nVzD2EGn2YzxpmYu1zrs4G0apdmWAu9YRJI2ddxW6BndQzhlynFiFhEY/LX4/wqV3hHUJ9N17Q6U4gTkyzGGIZqnvM43zYUATCVBgY0RiKhsOlLaQF0gdWo7Xcnjxc3XTviawPrG7gLeSPCDmujYdWmXK4QJ08vKGtStQuKVBOceuhNWoFp255ugv/2Turdnw3mDIKu4RiKHdlkdjBS83VgPkUXFDx6SqD+i/HXfeKBKka0SLlbREXgr7oeIpHNSXgRDU8NZi46o1XPFWA/Jommr9xh87Glg6MZVlOjr0eH8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6939.apcprd06.prod.outlook.com (2603:1096:990:66::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Wed, 31 Jul 2024 06:51:47 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:51:47 +0000
From: Rong Qianfeng <rongqianfeng@vivo.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Rong Qianfeng <rongqianfeng@vivo.com>
Subject: [PATCH] mm/filemap: In page fault retry path skip filemap_map_pages() if no read-ahead pages
Date: Wed, 31 Jul 2024 14:51:28 +0800
Message-Id: <20240731065128.50971-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0037.apcprd06.prod.outlook.com
 (2603:1096:404:2e::25) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: d6da644a-8581-48d0-5b94-08dcb12d3f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxBYz1tnwjR3bcNtX63hoyxt/EQ6ucwBS0LKec/kaSvd6iN8zFTGsZygAxTt?=
 =?us-ascii?Q?zyAgmfEFgnUgrfgfKarUTFB1pp533JgI0Iyxy1bsPzPQXHBsGp5n8DcMvnis?=
 =?us-ascii?Q?5VswJ2GUUipOjDJEC3rlfOjgr3aR5Gap5CX5CKIizPVfVirQsWr9o+SRvkxX?=
 =?us-ascii?Q?sB8RGf4ED1hmQhk0isNDYz4NpnxHcIlXrYO1inn8nd9fcfrj+OJftB/xQgdq?=
 =?us-ascii?Q?FN9aDRU+SqTc2yja02j5yBO/+2KemoOQEk45drYfcvecKl60hCKFVCIXrrGs?=
 =?us-ascii?Q?WypIC8ZsV2LV6AmNi6TQNlKjIbTCGSQdb9xuQg6XDOtzMCYa+g1Bi5CbfH25?=
 =?us-ascii?Q?NoeJohVLGJcuZx+mJGrX171xf0xQso7kHc0P0fbNIVJm3Ig3JoMERPssXbnQ?=
 =?us-ascii?Q?vWyRJ9qa0JCSiv21bSqyE0v3R8mGu/VMGb6rxK5TP9sTYFo6d64Tr9+0iOL8?=
 =?us-ascii?Q?4Pift/ObuK+4gggIrH7EbOY/ZtgpX0q8BlNOIQLenhum3Em/F9VZPD1cgDPL?=
 =?us-ascii?Q?OZfxt3BweQgC45+02INVuTybkzOEPdqmOVuscZ82AhX6irqEghG/NvACW60b?=
 =?us-ascii?Q?4fo2C5ZsDn9P5wjtFdScYTVn4fOyFxpQ4MiuHWoaTK47RSbz0Hg78u2UYIbR?=
 =?us-ascii?Q?2wf/4nDwNE4o2iXYjiDlr5oGr/nZ/KRpRoNmTQ9V5Y7tkADbzeD6OBEWIjpV?=
 =?us-ascii?Q?T399d8llLb4XDzXbripLu+45XQju7IgZwPi4GmfC5V0zq9S2oDNpEOxnIJAS?=
 =?us-ascii?Q?/AL5MF01ZLzlAny75bQByYsj6ktNxrXHOFRXs1R3MFrOMyETtFCWcL7TO2xb?=
 =?us-ascii?Q?dQkJu4wBY7mpK54CoegaSxAyytZJQ3Zj8BgU8tBwqhiMU+3JXEUU8oLuF7fi?=
 =?us-ascii?Q?gLbWa0t3HRlMORCt5RwYIARojKrK+CM03BF/NpFbCe0VSw63qeqsVwOlrI82?=
 =?us-ascii?Q?FOIDJia60su6KPfMDxHgbiExeXHknLCBFi+RvNmLwNRn59pJYIeI8ns+0Z/m?=
 =?us-ascii?Q?cCaOrfsi8vVj8JVaiGwCmPzUNsV8yoijjsWVOmFxfE8h277+RilGv+skqoqs?=
 =?us-ascii?Q?mDCFiTDzfzw1qkRMAlUNbo7smIcqboT2kzn5ft0FNnPDsyLVjqV9WOLql9HA?=
 =?us-ascii?Q?EBUvrguOsGUS7YCJEP9icCXF5UbuZncDNdvh63n+9q2Mk0+bxP46QzML8wUw?=
 =?us-ascii?Q?epjdebzlHIXXp7s2vpYaJVhWAhG3izZSxB8iw7P1R7dOnUoB3b8zKAmxLOK6?=
 =?us-ascii?Q?gNqRDYedSAttO7SvHbbhDy6VFcWFTYve1GlICxFNjrGlBQ59oWrvt0sj5oQc?=
 =?us-ascii?Q?7XyjvIXGcIpiTB68hF3J+hNEGq5J0FlYw+jrcgwLsGNMzuyWaNRiq3TsSmm9?=
 =?us-ascii?Q?13tNeJJ2viT1IbPWOfyUm3qAK8EdfF41JEiRWigAOKkExjtvlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pw6FpsqEvhghUkV5At6WpQayPwmPvvj3ERGfpGJePrWC4RNX40yhPJ3B+1B6?=
 =?us-ascii?Q?BY7H7xHV9XWDlwHnFpciWtmjST+FgZ1hvCe+hcgAjISJkmqpFZi00w7wAIig?=
 =?us-ascii?Q?Ko/sR3ftJuwVrmsMCFTgYctadqpCAmqOLBlN2TTNoG/CgwFgDJGhDOzSMKwQ?=
 =?us-ascii?Q?0UHoh4NlrMR93wiu/x22QtgSmqWLC0VIdRTP5seitliRn4plFr2fa8DKqoa9?=
 =?us-ascii?Q?M5s4vVrOOIsaCVOWyGlga93P3rT8E/7TcbXqJZ1Iu0dCfbXCIKiRNRBMDigC?=
 =?us-ascii?Q?XZ/l83ItLf3+lTt4ibNiM7TbpDtPM2X5ycqRr9XA1wPz1cNDjVMzkvaedmQt?=
 =?us-ascii?Q?jThkhqzQ/Nv+hDwQUovV4+Go2E4BgjzRgmqpLbN4/OscylWBtpNJl69KBCmZ?=
 =?us-ascii?Q?DBOWH7gdut5UkbyW1Ntpw2CrFLR1KnVJAXvWjmcNsD5SSsMwRGq/r1E9mAvm?=
 =?us-ascii?Q?3YFG7535oWLyghKdRTS9lYgNPsMslAGfcDKrA9UmohMUL+eFAq+tGE2TdrND?=
 =?us-ascii?Q?1JDJpWhu/plcruywNCTRBxmaPinAro3PrAzj/NOZfF9gpIcAd/sHKz5n4gYd?=
 =?us-ascii?Q?8nWPV1vcC6gLDjj14bsoTy3N1OfdhJpadptzVprbICgFFxx0faWrjc7onjFo?=
 =?us-ascii?Q?e/RqaQ4WOilyOTDrUQ0K16sRTQSZ9yt928rKIsexFwMlUMWYp+fKCRbiUfue?=
 =?us-ascii?Q?Cjip31kGDchY/thE40mhWKQUTaz9+1+hBigBFe6kL6yC6OwEkZqmUl3jjYVK?=
 =?us-ascii?Q?qllae9C6i7WI1Fog9enXgkCmZgV7eNGGL/V//NC+toV81bg+ONRYUavI1Yuv?=
 =?us-ascii?Q?c+X9E26JQcM1P1+0GisAA3ygfi12jHC7/3gLPlVr14bJs+EFQCa/NhumEp/v?=
 =?us-ascii?Q?oma0zD8T9MPbvrjhf9oa+6MyiJOA7j/AG09c43xtEOxh2h5vIxfygk3gWiZW?=
 =?us-ascii?Q?ptiq4cPyEhk4nQtCj86dwWnVcvGWKwI/A76UfbYEijIPpguTXkJ8K1VLq05i?=
 =?us-ascii?Q?uVsc3hVuTlQgRLIvQHRT9TWijVAd94k1kzTNYbBuPD1oqtfH+lNlU4G7w3DM?=
 =?us-ascii?Q?3783Ikzjs18HuDEK//9mYC/S6BhDFAdQiegf/B+SmPzdT8BHTGDmVZmH2Pv7?=
 =?us-ascii?Q?YXh3IuTsBSukF77wERnoDHEKTcnltenLgqh5Std4lgyQ0nMAWREzFv0kc3qc?=
 =?us-ascii?Q?flsX8lzTqmfYwYCf/PddeBNPbZBBPt9QRj1O7WEyyM93WU44wKlSRxUs+Tg9?=
 =?us-ascii?Q?/iSH2RFc+62EnUDcA62H4tj9ezEfDht5ay864edlKgBMFvDOB8pCTectH69b?=
 =?us-ascii?Q?L9RGqSqXPhqX8HwcpP+7avaeR9+/SmqxzFeskFezufkW6RNJH49k5jy96aHm?=
 =?us-ascii?Q?XP77/+lNKQky+aF/4TcKC+m5n5LqRz0LEm5koHmKt/LF9tfM4CCwpibjWRzD?=
 =?us-ascii?Q?1K+kFP0wvV8icY+FF8WcsZfsAw6liX8o7hzySbUmurM8xwp1b64qkqJAtz4p?=
 =?us-ascii?Q?/CdUYEATyGlD6fJElDGWxeMNWyYfTFS9hhIW68PTIIMuNaOfpd6Ok4uN5rZw?=
 =?us-ascii?Q?3FyMzKg0wfOBiOYxxVBvSZVzx6XXvSIv/fpy56gw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da644a-8581-48d0-5b94-08dcb12d3f5c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:51:47.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNfNye5kBJ7Wukasx59q2N9aLps/Ai9yQbN9XA9Zcl1fMKOdzVNpKkwanI0ayr9QOsJEKyBvJdcxYh/WOgnVBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6939

In filemap_fault(), if don't want read-ahead, the process is as follows:

First, __filemap_get_folio alloc one new folio, because PG_uptodate is not
set, filemap_read_folio() will be called later to read data into the folio.
Secondly, before returning, it will check whether the per vma lock or
mmap_lock is released. If the lock is released, VM_FAULT_RETRY is returned,
which means that the page fault path needs retry again. Finally,
filemap_map_pages() is called in do_fault_around() to establish a page
table mapping for the previous folio.

Because filemap_read_folio() just read the data of one folio, without
read-ahead pages, it is no needs to go through the do_fault_around() again
in the page fault retry path.

Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---
 mm/filemap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..f29adf5cf081
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3105,6 +3105,15 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 	return 1;
 }
 
+static inline bool want_readahead(unsigned long vm_flags, struct file_ra_state *ra)
+{
+	if (vm_flags & VM_RAND_READ || !ra->ra_pages)
+		return false;
+
+	return true;
+}
+
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
@@ -3141,9 +3150,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 #endif
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vm_flags & VM_RAND_READ)
-		return fpin;
-	if (!ra->ra_pages)
+	if (!want_readahead(vm_flags, ra))
 		return fpin;
 
 	if (vm_flags & VM_SEQ_READ) {
@@ -3191,7 +3198,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	unsigned int mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
+	if (!want_readahead(vmf->vma->vm_flags, ra))
 		return fpin;
 
 	mmap_miss = READ_ONCE(ra->mmap_miss);
@@ -3612,6 +3619,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
 
+	/*
+	 * If no other read-ahead pages, return zero will
+	 * call __do_fault() to end the page fault path.
+	 */
+	if ((vmf->flags & FAULT_FLAG_TRIED) &&
+	    !want_readahead(vma->vm_flags, &file->f_ra))
+		return 0;
+
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
-- 
2.39.0


