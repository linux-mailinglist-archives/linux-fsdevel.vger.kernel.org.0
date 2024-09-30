Return-Path: <linux-fsdevel+bounces-30367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530498A5B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056B01F22557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFD18FC75;
	Mon, 30 Sep 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jw6wk6YJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0518E02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703943; cv=none; b=IbLyDoJDKx0FJACl5bWVHkAhWnm6euJ0MPx824iWTMocJcgTixRtIB/KtBqLaXUsrnzAciKPVzdNLSpR5WP/GYaRChtwE2K3z134YLwjILFovykZDHDqkXe9G/riikZx5uEF6lSObqh/HrBiTDu8bMXpvk7t/LxlhBxUV1aowPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703943; c=relaxed/simple;
	bh=NIMnjsmggbnxzBEW4uwR4TD2Ew40UGbWjKw34K8b/Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRJqissdyiX+0IBcCF9hb5GdRYQPUHLm7cC+OFSurALuryYsdO0coYBeg3sAcONSVrXATwIc0uuiJfLjXMAmydWmx5f38GmTp41pCedOc2gTHsfXxlYihWQbTJ/9nenhjFXQLq/hKdL5wrY82Ad+L8lwQxoHxystnkvIJe/6TcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jw6wk6YJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb259e2eafso36476166d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703940; x=1728308740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIdykmDXYXqWHPWczE8moE+Dme0TRAg0JjJRVJFxKHY=;
        b=jw6wk6YJ0s8MOvAYncfDVQ0jnJJqcN772HCFaWAcN5KokltyzRr36T91DJJUZqaO4/
         PUhVZ1pil6aKaUgc3lbbpXT69rHYLg8Fo5XhLMl/WhHMpSE2uzjCNj6afyWvMkXiDX9E
         6pe7IhM0H9n/WziCX/HIAcyOe8tvPPAPgsIJvH/BH4sLfMRiAUFS9HTp+0ox0qwTc8ET
         pP/9y6gB4p/Dt2kFp3I65h35mIJG3QaPNZhei6J3ZXsGRN96kUklhyIXtj+UJPircQ8k
         5+zXBG6K8TRaICmPBQ/ehs4l2VFDg6fuiK8PmkqzmyhcL9LY2+GudVkYF6nXH5uimTwZ
         +NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703940; x=1728308740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIdykmDXYXqWHPWczE8moE+Dme0TRAg0JjJRVJFxKHY=;
        b=EVXM/8bF77j+wTNyVjhJugv5qErO0JqUwIIIFzAi/Vv7xR5MbPTVvCMeqoIY8DVjj6
         M6yNYBAiCvf+0hORzk6K1wsiDw0NW4MP6OZGr7xZbszNXe1lLSBvHPzipiOxqUfeiZlp
         STwqqE4ksNNg+YwgqMiQXzW7+YIr/xGlVFlORvb2mwN+BbB2mTbGB9NoHikN2VaHk0xo
         mnt3ICdf298n/4Z6pT4k8VNOnDny1hH9SbioJU7xKUuHUY61LSzUFUdymu0OfurOsqGJ
         E/ftKWtMaxFLcPCZ+cTwhckQCMXztNaokNWMDXE1zCS6duinzxayG5vi7NctLscThtFu
         CGng==
X-Gm-Message-State: AOJu0Yw7rHtuGVVisNbgven8nlz4Y1bVNrQu6lrQLIYtg5VJ42fhHX3N
	8i6bAH2RwMLjD9JOEbipR3ihy0tfRpLmuLwT4UBUln0+Rg05+w0FxZUDu4mBOWelET6GOEpxvOU
	4
X-Google-Smtp-Source: AGHT+IFAeBrlnzTEiyC5RXXGoTUiJ2/uNyiG3/C6k6f/SkBBtpSZNIbpASQi4eSaTQ/KLK0pVFS4OQ==
X-Received: by 2002:a0c:e906:0:b0:6cb:3da9:d5a2 with SMTP id 6a1803df08f44-6cb3da9d990mr159410456d6.19.1727703940104;
        Mon, 30 Sep 2024 06:45:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff5a2sm40160476d6.4.2024.09.30.06.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Matthew Wilcox <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 02/10] fuse: convert fuse_send_write_pages to use folios
Date: Mon, 30 Sep 2024 09:45:10 -0400
Message-ID: <82d1c7f2d0427e126e6dc0e660a7c4e04d347068.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
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
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 132528cde745..17ac2de61cdb 100644
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


