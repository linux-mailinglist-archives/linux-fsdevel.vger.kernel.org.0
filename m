Return-Path: <linux-fsdevel+bounces-35855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A029D8E47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA98F28A85D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C160190059;
	Mon, 25 Nov 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axy66u5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33E1CCEDB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572368; cv=none; b=hdEi8p5GjUzqDsTyJCIJpAId1eYOBhTTwNK/kj78F79pGyIWU/nkwT3WeKFaQVbxAHpCAiXDx2qju2i8rlsCw3RhnTbkqgLJLVAdMZ5ThCAJ/pFhrpjDoqueZErfRo2De8/hhC2crWy+VHJqTaEorIKq/NVxw2kBE+OZjVOa4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572368; c=relaxed/simple;
	bh=SVDywT/j47e6gthHPLPPIN8NX1ME+LUIo1K0oGoKyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjn8bN6F33TAEnnrtrYbAPH8EZzDSapCQgouNVNBD5p8FTu4ih5v/uIDIYJvcVJEpFYo7JDPw53ienSe7aojxAFjEFcL8Hdufz1yyOqn4FQX4bmgQDKOBorrr/l1jZ+CsgS4vc6WIrm/2YxYDIZPe18oFkP6hoPlFGZxFnWDFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Axy66u5h; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3839177651so3975473276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572365; x=1733177165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxPIDlHDK7HE4w3vT3kctEuNkH7jrQTEdOwBsbFisTU=;
        b=Axy66u5hayEQ6PWh2vdZg/1bvQf7duojGuozZtKBvW8UDiQ0TlnTr3Ttbz3LaD2lU9
         djHKK7rByNe4olOeIoP8B5zVwlesgq6BY7T/BJxtKQHA+c5eSK5Y3zbyoBLfy0qQnL2F
         V1Q9h8WMW1srU8OTTfOlQ3tQ+AJ4ujC81lAT2It5xUSOdk4mD0TkVbNWY4fLyR5S7y+E
         tLCsIyzuL7ie59m27WsomeAqMseoLpXJhkKjEOxX/DpiIcDDZxzaFzaWn5kPx9m/5h05
         rveIiISbgwo3afSJwoh08oZewmnirkKHW0PFJuJ72Ko5NgWFTB/3uRYfkc7Ee2rhmjrL
         RzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572365; x=1733177165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxPIDlHDK7HE4w3vT3kctEuNkH7jrQTEdOwBsbFisTU=;
        b=djLMqh63KbACzvFUgQ/kkuM8IBkhy9/sv/VRnIKT9AfGmSbJeo+cC4f2mvET2Bz+9I
         k+ZpFLdxDs01JbMn00iB4eK7UcISss+dAkXxO3+qVSZp3oNfePwsyFoWxXJSUaGPiboy
         97+Re8QOTxCCWrZE7EGb3SXxjPeWF8kNECmU80zA4txIX6W03cxN4ckIRkzIteTao6y4
         FQ77WCCdMy3o9U62JIj09KlNGZnuBS1WJ9CvpYsw5EW6S76P7Yk9+87GlPgjqaD1Lr9Y
         UiEKwuaI0iSOnIN36HyrXdOrWzMtCFEHqx0oEzUUWi30gYN4/izbRfMP8xmaG7D//DDS
         FPEg==
X-Forwarded-Encrypted: i=1; AJvYcCU6X3uH0LEKv+5ZfwEjHcoT+nhJFrhdWRETq0PLXeQda/Q8I5pfLO0gtCahYFBzWf89wRVkH57F0Z/uXe4u@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdOmrdopAhb/PKulCjgUAipmg3kyUgNCE+M4RHE6ADyQAqcPl
	CCNQhBZFFrFsbNi+96F2Jf4aPsEUKyI4vAGiLtx5B4+HFGVfrZPL
X-Gm-Gg: ASbGncsvyYWFmC3AnBaCYaUiWd5uFW1FuGCTKc2wPnGUQcheODMeuleaU0EOJzdDXxo
	b/JsxOq69X5Ljbb229Q9WVva9VajjodD/LlpMtCCrWAzffIFo6RxL3Dq14gqfcF20SSN4HE47e0
	g/hrW4x3UNSukvpPraEL4Rf0FRDlt+KOTNEiul1Rb1aTciTIJNFtEEb2+LRzuIrdEMFWMv9wqF2
	7Aa4OT0ajLs+N20s7XHk/B2Vpg6RRuymQaBnuMYJG7jb0Y9T6jWsABNSPXaIYBaTuKjn78mj9Q/
	6S5HLP7UGA==
X-Google-Smtp-Source: AGHT+IGsxzMBbTEX+jLvUsV+cXeEgwSPAMxKVTRgs3m0bUuelH5gc1YbIbEECHplZ8a+NsPBfqWI8g==
X-Received: by 2002:a05:6902:2402:b0:e38:8a7d:d292 with SMTP id 3f1490d57ef6-e38f8c079f5mr11679999276.50.1732572365544;
        Mon, 25 Nov 2024 14:06:05 -0800 (PST)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f601b9a5sm2684307276.2.2024.11.25.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 07/12] fuse: support large folios for stores
Date: Mon, 25 Nov 2024 14:05:32 -0800
Message-ID: <20241125220537.3663725-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for stores.
Also change variable naming from "this_num" to "nr_bytes".

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8d6418972fe5..bbb8a8a3cf8b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1655,18 +1655,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
-		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_segment(folio, this_num, folio_size(folio));
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
@@ -1675,9 +1680,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
-		num -= this_num;
+		num -= nr_bytes;
 		offset = 0;
-		index++;
+		index += nr_pages;
 	}
 
 	err = 0;
-- 
2.43.5


