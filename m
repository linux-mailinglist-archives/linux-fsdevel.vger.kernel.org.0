Return-Path: <linux-fsdevel+bounces-77261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBrcD4irkmlPwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:30:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D179C140FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F85301378C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300614F70;
	Mon, 16 Feb 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B1b2z+T7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6362D97A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219825; cv=none; b=HLiv2E6K4NxKTbQhJVIudlRDMqNO2dEfk3UVkhHqDY78eVdqKxBPKdpjslr9RP9xhmUX0f8+uDVAar/txGJH26SfYa0VEbLMgD7gFUB9Kpj1LREVyXLJfBwT1xKMJkSyEMv5CthlS1i7MKH/Nv5tJXdUXJBlwPWRryoLjz0irVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219825; c=relaxed/simple;
	bh=2S1Uqfq6crA0Tg9XHeAvte7p4aFJp+C1Vn0X879uJ5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AhJRoJim8ZB9KytimmeFqRkvhiJ2EptIDCIFEVfHPuI4S80EuExfwFYUohXSRhaGs0NYeyTzsII83EdSHoED5GvgNZ1/A2X/Fm/pWCL/1VFxnLclY7guivI9GoZDYHgkNS6YQ8tQAN8UtV3Muxlpob3bGV2Ga4XTjQIqIg+g350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B1b2z+T7; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260216053021epoutp01bc51420070a7fc714c47ce13223e39eb~UowsZ_UQz2251722517epoutp01b
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260216053021epoutp01bc51420070a7fc714c47ce13223e39eb~UowsZ_UQz2251722517epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771219821;
	bh=xg5zCaVrLFRJteK76DQu6a5unFnWHTutpcUCOUeBAeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1b2z+T79/7E/W48/P+m0kkjLOhkdKYjr1sEU5X/5ymkFBf77ZYBTMvgce2MEU/i3
	 W4GcSGczh+RruPIJ9q+2UsnVHsCSDaqBaFkWEtCYOP6UpPU3xRaET9fwQlgoKANIjT
	 vTtjwTccK1lKsRr7dW6jk5LAHiJECyPffCnxf1bA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260216053020epcas5p3f67ad803eb1143d1d4405293359706a6~Uowr1zSJY1375013750epcas5p39;
	Mon, 16 Feb 2026 05:30:20 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fDrvY6Rzgz2SSKX; Mon, 16 Feb
	2026 05:30:17 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb~UowoNicVB0350003500epcas5p2f;
	Mon, 16 Feb 2026 05:30:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260216053015epsmtip18d14fb1eddfb8146485dcd3a5d64dc92~UowmxijSF1607516075epsmtip1B;
	Mon, 16 Feb 2026 05:30:15 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, brauner@kernel.org, jack@suse.cz, djwong@kernel.org,
	axboe@kernel.dk, kbusch@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 1/4] fs: add write-stream management file_operations
Date: Mon, 16 Feb 2026 10:55:37 +0530
Message-Id: <20260216052540.217920-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260216052540.217920-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb
References: <20260216052540.217920-1-joshi.k@samsung.com>
	<CGME20260216053017epcas5p2d6492dd8c33c6d2453b15d79819d97eb@epcas5p2.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77261-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D179C140FDC
X-Rspamd-Action: no action

Add three new hooks in struct file_operations to allow fileystems to
manage write streams at per-file level.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/fs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e4d1e8b0e71..ff9aa391eda7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1967,6 +1967,12 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	/* To fetch number of streams that are available for a file */
+	int (*get_max_write_streams)(struct file *);
+	/* To set write stream on a file */
+	int (*set_write_stream)(struct file *, unsigned long);
+	/* To query the write stream on a file */
+	int (*get_write_stream)(struct file *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.25.1


