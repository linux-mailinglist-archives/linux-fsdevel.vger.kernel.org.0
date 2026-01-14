Return-Path: <linux-fsdevel+bounces-73796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EBD20B98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5113062903
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516530C353;
	Wed, 14 Jan 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C66ck5QL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2D52F88
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413781; cv=none; b=BDdoBF16i06Kjy/4StO+vINRTasJmEjGfJJf/zvrNzgBw2qvzmBTdvZddkOQSqaPtI/SVGPtUMg86m+HN5TvacF1R7lUkVSmZct/qpu2BYjB+FUOVfZiktuoOmhIcZX05yfpwVQvlZvr9kJWCsIVX+HNkdInjWFxMPufKyiJXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413781; c=relaxed/simple;
	bh=mndyIUpgwa7TcxoQPxUEorDjXkSpqRfD2PQbNLCbmGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdxukOvSng+/rsOoRdwwbZK/tU9F6hs+SPAkjrdz+9Z3gDdHkC+CmZ9VOeMITIMpUP9Wp+ULSr1ZjR+14qc5w+dLHLxusPHKEbGYHSpUTS5+aLjT1IjnVABzqI+qh58zuITjrQzuIHCDaM2umWQv2kMek4aFM+PqYDb64MfeiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C66ck5QL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso43177b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768413780; x=1769018580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3JEux1HOGf4aviYytRlNw8Z4N/AyOoDfEbT07rTQio=;
        b=C66ck5QLYcM2BxZ6DAhX4hnCB/x/oLVRmPvhOcVBSJvzyqZSJGH7ghmF/n3m3ZimB6
         mgpj0EYs+Q38Js56dutbZhdWdaiULgPhIQiQkabnzayVBED5S37RWoNpROEukr8+aP4d
         HixuqmMKOj043BUGWs5U9iWxxRIXAZI7ckOvXo7oMRRlg+a8R1xgNXYWOpuKBdxr5xM3
         2R1JwaZvr8OtgAiwY/IOhtQy6GTbKT/ybMxG7VD5QTtz89vIep5Oh6YUGBKgu6CidPGt
         9GNfhJeChnPavxdoS9DZqLoDjSeA89MG+bo6Ep1eP1VWw3B0l2ChF/rIC3uIUp8ej9Or
         sOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413780; x=1769018580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3JEux1HOGf4aviYytRlNw8Z4N/AyOoDfEbT07rTQio=;
        b=C06GiDft/wpF0tMHT4YRtkdU49yDZFOVx6qRcqsNjGta5bFm4LQCF0yGAtnof/23qF
         ILGMKdx5I2OF/NHi0GtccP1ccbQSEOB1wGhCiPp/IUQWy89RG9nmEcWhGEG7197Wpx4k
         aiZj9iNodQ7+3TGQCJLhgRYl2UhQMmbwHN1uRO+qqW+r/sdSjUvWcDOWTmMz/WElzQ4K
         SPiUuRfGuxljYod2FbUvRy2T4koEf7LY6Ev1aJXEdRZW9AMipio1iDybKXx8ti7xKvRX
         /N6M0kMl3o9KJrM4LCGnPor52U6sYjiZMOZYsVXbWJxp4joTO9gTkezuOAOVULF0bZ95
         3zJg==
X-Forwarded-Encrypted: i=1; AJvYcCXwtBjur4eIWTs8WtdNtB1MIDHh4//tLl2RRgrYQGdOmGiXMp+SyY5jIU9sHnpKt+XKqPeRB2AVq+fzVZJx@vger.kernel.org
X-Gm-Message-State: AOJu0YwReIwGng13tvZYxkUTp+GtMIZdAiqRjmZfgTyvnl/rhizGUwIl
	6STLR0KV7AzSUHL5bLlaOnKgFIY+JAY4uW7NcoNt6CzQVyQo9tWfI/n1+S3zBA==
X-Gm-Gg: AY/fxX6qSYosVi03bJKqg+75nof9zzMklp9Mbmlm2ENW/AGirriIg77YU9RSJ/Y7E0/
	pLWEoE0iusJ9PoyAcLxMqbEQowIKiNCVqj9y76vTDYuhFhRDpddMrR3rGyQyO124cbBc6uHsdln
	IlEDxKIOnk5L4QkEOWhlK8UrcoowA1zpqnZrkcab5EmV8yOqSPdP7PSzoPMmbRWr1O23E9ajLzV
	s+t9BD1HcJZ5NnWsg3p0Pi0gvInFIpJX4nJN+DxWGOGqEPL2J1nk8OAbTZjGvE79YASy0izfrDm
	w2xCaaE8ppgOhlsDVGHuz4+ZJKG/hqN+zfNsPB2Tl6wxUL0qgVYFkDL+cWlJ3lxH4FgIbMzhjZt
	XQpCm+h1+YZXAtl8iDFmiiZFiPFzyQUR4m7JKkWXcFPGpE0K1osfdkmUg+sAiZ6djjgUZtSFjwo
	go8E9k8w==
X-Received: by 2002:a05:6a20:12d5:b0:38b:e70c:63f5 with SMTP id adf61e73a8af0-38bed2171femr3177562637.70.1768413779823;
        Wed, 14 Jan 2026 10:02:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm22800314a12.10.2026.01.14.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:02:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: fix readahead folio refcounting race
Date: Wed, 14 Jan 2026 10:02:55 -0800
Message-ID: <20260114180255.3043081-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

readahead_folio() returns the next folio from the readahead control
(rac) but it also drops the refcount on the folio that had been held by
the rac. As such, there is only one refcount remaining on the folio
(which is held by the page cache) after this returns.

This is problematic because this opens a race where if the folio does
not have an iomap_folio_state struct attached to it and the folio gets
read in by the filesystem's IO helper, folio_end_read() may have already
been called on the folio (which will unlock the folio) which allows the
page cache to evict the folio (dropping the refcount and leading to the
folio being freed) by the time iomap_read_end() runs.

Switch to __readahead_folio(), which returns the folio with a reference
held for the caller, and add explicit folio_put() calls when done with
the folio.

Fixes: d43558ae6729 ("iomap: track pending read bytes more optimally")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd9a2cf95620..96fab015371b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -588,10 +588,11 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
 			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
+			folio_put(ctx->cur_folio);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
-			ctx->cur_folio = readahead_folio(ctx->rac);
+			ctx->cur_folio = __readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
 			*cur_bytes_submitted = 0;
@@ -639,8 +640,10 @@ void iomap_readahead(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	if (ctx->cur_folio)
+	if (ctx->cur_folio) {
 		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
+		folio_put(ctx->cur_folio);
+	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


