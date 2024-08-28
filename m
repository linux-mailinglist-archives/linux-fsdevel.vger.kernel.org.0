Return-Path: <linux-fsdevel+bounces-27648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C729633A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C801C23AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0B1AD3FE;
	Wed, 28 Aug 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gWwbni98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959361ACE10
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879685; cv=none; b=o5wA9T1t1ymP2RqvBBOD55SyMKccoNRgMBrTcrT5jqos4y3e2Ei0rpPmN52j4Z1XfiTVtuwzFpZEqBOtJxMzDfVItVizQjVT6FyBiu/829w4IjPlXxYzpQYsFG6dK+DxIpXi0bxBj/C6Dy7AifqilxdXiACs9jCoP9L448P/Hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879685; c=relaxed/simple;
	bh=rqh63TWKRvEXjWv3XfOW6IdI6JwCyPFzQI0Yoqi+h2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNs8F2N3/1IlZ40++uGDqvGBc0pE8tiA05eOGxIa55u0GsxqTrx3yBXsGADPdmv0jExeOVyt9FEEkW+mLoiphfC4WzVytu9ciy85V5FuNtw7CQXvxMIjRQHI+Ikuw04BdBJRrSn1IVsTMMNrobb/Qege2S+OEUq8NoyQtgVwAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gWwbni98; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a66b813745so408688985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879682; x=1725484482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKt2u9GiqkNR6gbLdnctJUEOsRc41JpjbhpUeXMVOyE=;
        b=gWwbni98nZveOGtXA0sbUNxvB07yDXJNZV0jIMOsKW7cjBrtblQCaS6GGwZI3Z9U7+
         bA1Fo13o6xRnGInfO1P2lpbqttTtz8ErHlw/Ijw+7/vdQ5umhgEju5Lbr/U+DUa6LfoQ
         VDpU61cAqlqG3NCdvOR4Gz/b0vCcFNQ/71/uxuvDaqhTKi51zPEuPIjcnmsbII9uqC7x
         XMv2IoBYHZl3gXChLUIqSDNP3iWOem5HgwRTRxmi7Zng18I4dtSqrYU07MD3gT3CBecL
         jclvHK0XiEkzvpH37lbG/DtzQWjkuHhOT0rnZGPj1juivqLsnQkRgmRLB8n9wvdTHbUh
         3qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879682; x=1725484482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKt2u9GiqkNR6gbLdnctJUEOsRc41JpjbhpUeXMVOyE=;
        b=etKz+W5IQ/+gywVxLA+VV/4fQpDiXN2N93wPnzqQMMihnDrfiEkIqzrPjle9l1iv/W
         PmyzEdl1NB3ctF97MOC3Lyx54zB7rT0BiqdnqUeDVvF+2OnrUes0lmcDM0xN2GKd2WnZ
         9709IJvuoepy4NWxZD5zFu8CuCqOfkzxiAR1wVSUiWfAeT+mWR2A0+B+IwiBWq5r1r5V
         NcO5fJHgKUjM7V9Z31Bf20rQ1zvcIwNh7WRTu8othOnA1avUt2SBn7pF5QbtKKIhN9Z/
         KFe/t5zoh5fVvyO/WSuryHgyosZ38PD2+f03olqVALTwyYLVuwOG9x0JNcJtiSXLoMSE
         18NQ==
X-Gm-Message-State: AOJu0YzURjlp5q+OIEngQDkkiELphpIDm61sx0CBQQpsPrr0fBfkWE5t
	HxTBhu2IV0kN208fQrJa4UackkLiLERrMYWPb2J4zpvmN0GhdFOec7QQnEjHcbehoKMF2kcy26v
	C
X-Google-Smtp-Source: AGHT+IFqQQ8vD/SxIBZnEAIj2SWucgj5i9MNgDYsxsARrWrYLypIPnik4UOvumcf0d1lTCjF/AODNQ==
X-Received: by 2002:a05:620a:1909:b0:7a6:640b:4557 with SMTP id af79cd13be357-7a803f28b7fmr96441785a.0.1724879682200;
        Wed, 28 Aug 2024 14:14:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3f7b75sm671180285a.104.2024.08.28.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 02/11] fuse: convert fuse_send_write_pages to use folios
Date: Wed, 28 Aug 2024 17:13:52 -0400
Message-ID: <1278043b334b557d7f3ba4ab5d502a618e100824.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio from the fuse_args_pages and use the
appropriate folio related functions.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2fd6513ac53e..275af3a7c50b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1168,23 +1168,23 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	offset = ap->descs[0].offset;
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_pages; i++) {
-		struct page *page = ap->pages[i];
+		struct folio *folio = page_folio(ap->pages[i]);
 
 		if (err) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 		} else {
-			if (count >= PAGE_SIZE - offset)
-				count -= PAGE_SIZE - offset;
+			if (count >= folio_size(folio) - offset)
+				count -= folio_size(folio) - offset;
 			else {
 				if (short_write)
-					ClearPageUptodate(page);
+					folio_clear_uptodate(folio);
 				count = 0;
 			}
 			offset = 0;
 		}
 		if (ia->write.page_locked && (i == ap->num_pages - 1))
-			unlock_page(page);
-		put_page(page);
+			folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	return err;
-- 
2.43.0


