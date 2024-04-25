Return-Path: <linux-fsdevel+bounces-17784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4569B8B22C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0293D2834C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA814A4E9;
	Thu, 25 Apr 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItKQVO+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF4149C43;
	Thu, 25 Apr 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051768; cv=none; b=NtrFBnsAq3pLawLmIU/TP351ztKlyWj0yOZb9DbeCZibhgnuyrNq91GsgEqPmJiqStpCDDaOYvpA1KSmKZ66t4t6upe1YHFDPyNlGSu+hGrV0tG8XNWAAzKgCrfib86AfQBDA7JilN/FzdVqDWQIyAkvKCwkMerZk5qkfOt3ypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051768; c=relaxed/simple;
	bh=tsPaJVHRDXkBmzNMwJ/nKOKe9OUjegd10o36pE8Dt/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APYcSWpImN3yH2gU6FzK3ATbaGpCEMBmaZUlMtaxyJLbqI3pEcyrM7Q2Ax6GbqkwyX0k12Zj95iQYgwQrOrhADo7MtaYq+ujSNbfhSkFm3DORCSuM/7fcCfZkN47cD6wRynInTAuRrnuURti1V6Xeq9xfbQviAaWd+KOJo9IXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItKQVO+r; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so949076b3a.0;
        Thu, 25 Apr 2024 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714051765; x=1714656565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCyv0eSKDRq6D8j569kOqYfrClk2YTDJxfBncGXtKdE=;
        b=ItKQVO+r+z+VyMzD5upQeyjR9mdn7CWeBu1LYTBqq08UwsApSiX/k/QQdu/lFESofb
         q3W59tmDFQPQ/rSM3rpjNGM32DJy5PjI++I36jytbd/yKEtg2MjjF1UMUZcR/KlddTzV
         TLT6oc/GDdVvu5rr/iErQnkIo19Mpba5YeUSyIXHgK8icJYFXX7XOMsZiawrirb6U0Kd
         nUET/h8vJ9+gfUj9qs3WWIi8aTDG1ZBA1o/UzNVc+QlhxR8yM+yuBZHAKr/ctNm2sZUN
         NtNH0NeTgJ8LF39bb+U4Ksc4T6BfA3qd29UVwD7H3BcchDvEb451gNYU/wy3/+4oQJyx
         jlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051765; x=1714656565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCyv0eSKDRq6D8j569kOqYfrClk2YTDJxfBncGXtKdE=;
        b=ugbuSnUGq9UDl7bx2HykLMzrnNpsJ4lKzNs2Y0DX/nYQZllEmK2WT7XX3+5Ds8IszS
         yF1N3RtX5iXMk3oE2YLEAnhBoJ/ndtsUlOBe3ch5x+b65DS7DvdK8zGVZSm2r+KlsTme
         MWg1ZYAqlwq9K1VuD+3kYGjxYE0YLiLFfWDYbA8GboRaDD4Eh2wq+2pbVGLTXAoM4VK1
         i7gf2aEE4tTP2xraT9+UCRPhi2WglgioEwdr7g6cnqx6BNBgLwU1fWYQx7H8qdPyHZK9
         04Q+h5c8dQpXMGEvWIRXCIMwtT8GKM/7e1cuDLNRbKr2QbxLAFdIZjDyIwL5SQdZJiMz
         WrEA==
X-Forwarded-Encrypted: i=1; AJvYcCV66B9dAXNC15tX8Dk8TZB3OMBciVgUvD2zSogkOspWpwb8Q7mnTKn4TXHU4hAygT6i144RSGq3xPJllSSeKM+Rox/o+hGNIU88
X-Gm-Message-State: AOJu0YwuONDeDf06eolHJcWRtZVc/MNgIscgWQwHYsRU+FLRaKyQHEsT
	qHxAypkp5laFR8soR2ZtY+d3LnNn0uKqe1i5nA6CZNgXdVk0w8R2vcrYtOKT
X-Google-Smtp-Source: AGHT+IH99lzg0CGyhPNWPz4vjXqdj2G1nV6t3Zwosmar0rYxpJRofmUYJ57x77C/2QSEKkA+kMYTdw==
X-Received: by 2002:a05:6a21:9217:b0:1ad:8862:318f with SMTP id tl23-20020a056a21921700b001ad8862318fmr5730168pzb.12.1714051764966;
        Thu, 25 Apr 2024 06:29:24 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm9764518pfh.141.2024.04.25.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:29:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFCv3 6/7] iomap: Optimize iomap_read_folio
Date: Thu, 25 Apr 2024 18:58:50 +0530
Message-ID: <a01641c22af0856fa2b19ab00a6660706056666d.1714046808.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714046808.git.ritesh.list@gmail.com>
References: <cover.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
within a folio separately. This makes iomap_read_folio() to call into
->iomap_begin() to request for extent mapping even though it might already
have an extent which is not fully processed.

This happens when we either have a large folio or with bs < ps. In these
cases we can have sub blocks which can be uptodate (say for e.g. due to
previous writes). With iomap_read_folio_iter(), this is handled more
efficiently by not calling ->iomap_begin() call until all the sub blocks
with the current folio are processed.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f79c82d1f73..0a4269095ae2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -444,6 +444,24 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
+static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	struct folio *folio = ctx->cur_folio;
+	size_t pos = offset_in_folio(folio, iter->pos);
+	loff_t length = min_t(loff_t, folio_size(folio) - pos,
+			      iomap_length(iter));
+	loff_t done, ret;
+
+	for (done = 0; done < length; done += ret) {
+		ret = iomap_readpage_iter(iter, ctx, done);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return done;
+}
+
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
@@ -459,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
+		iter.processed = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ret < 0)
 		folio_set_error(folio);
-- 
2.44.0


