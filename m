Return-Path: <linux-fsdevel+bounces-25001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097BA9479DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322F41C2017F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA48157E8B;
	Mon,  5 Aug 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MgiUmdKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E415689B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853805; cv=none; b=YA7tPbEv5PpbdI4B1zI5wmlGXDKw0Sqjvis6LO0MQBjFL6gcC8XjZiMlgwqfWzsTmEnf1XLawDtN4Fxvudx5LZkWnPUG0eo27YIrUussdq1rE5PpabpbaehQNKQ2kVRcvCvW9rHljDFeRQ2NssUhELAlD/iu437nG+KMs/MW9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853805; c=relaxed/simple;
	bh=JuOl0jwvRacIVVmMz9i/DNsJFghR7Ps+bku/MuxJZjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNjpocSRlYifdOVVMkOSbfX8ww9u/HUTDsXKry6HROCXS8kK1D2mvK92eAH3R42I8BD6qckg8R/moff+10jbdR8Sy2ofNwnhnLqhB6PrdRCzdHNWSyTNkeanm7lbPISfUknJ+hQZDxZsfPJxtFLHrayZFJ877y/Ka8Mxx1eC39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MgiUmdKh; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id auyPsh8Id6NRTauyYsps7P; Mon, 05 Aug 2024 12:30:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722853802;
	bh=26AbValjT7Vk4kQ03bbizfA7G7UEuqTMoxXJ/fluyLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MgiUmdKhCqVn+pq6mwgruZpr78Pf5qVebAde0iagP40Tb3DeJV4GToVLMrKetEvag
	 TCao9jW44o+WgdqhEeoYSm8EzPrm8Wu7YYZ5DVKdLrRXSsBMQBe27yLLt4JdifQcsv
	 7oo4BUMmicd9xi5F+5JCQgM5VvDgJiSfLpCmtQHWUR1ygFCdxqVPHrDSWqRY0aAy3W
	 oxonoC+zybeDAJoyKjoXu+gYpqwQhxMmIVOqy5HSWgNbFLXAq603sXju6Cq/EZeBVl
	 afqQwMZLQX07/9stSc0S28tiF9hQS2zyTBUjAKaXlaLVHdw0WupHgoMBpMfUyYTAE6
	 wDOKYvwFBd2HA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Aug 2024 12:30:02 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srinivas.kandagatla@linaro.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/3] ida: Remove the ida_simple_xxx() API
Date: Mon,  5 Aug 2024 12:29:48 +0200
Message-ID: <2e9b298991fb8cd47815c917a8fc069b553cea10.1722853349.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
References: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of the ida_simple_xxx() have been converted.
In Linux 6.11-rc2, the only callers are in tools/testing/.

So it is now time to remove the definition of this old and deprecated
ida_simple_get() and ida_simple_remove().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: new patch
---
 include/linux/idr.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index da5f5fa4a3a6..60216f8fc04c 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -316,14 +316,6 @@ static inline void ida_init(struct ida *ida)
 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
 }
 
-/*
- * ida_simple_get() and ida_simple_remove() are deprecated. Use
- * ida_alloc() and ida_free() instead respectively.
- */
-#define ida_simple_get(ida, start, end, gfp)	\
-			ida_alloc_range(ida, start, (end) - 1, gfp)
-#define ida_simple_remove(ida, id)	ida_free(ida, id)
-
 static inline bool ida_is_empty(const struct ida *ida)
 {
 	return xa_empty(&ida->xa);
-- 
2.45.2


