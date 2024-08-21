Return-Path: <linux-fsdevel+bounces-26568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D595A822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40D21F226DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39E17DFE1;
	Wed, 21 Aug 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5DnVXHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AE1494AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282716; cv=none; b=LY1b1FcV/Ox0hYU3UVJUkKG6tQaVxZWY7SbDRvBZQxIGglmkfo5arCJJ5SVpLQQqbhuVliHi4/8INGY9kEptLLvpiQJtiOwgG79pkz7oGvG5zoruHmMk9E9m5eI61P076OrHcYfRHqqWwi2Iga4nOLS53qgkrIxxiW6Xbl3Bm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282716; c=relaxed/simple;
	bh=eaHwMeJ0CTx8L8hGmD/ZgvwlqQiriDj4xMCy/d865M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4nHv8AfeR0PjWmX51sNi9gvyZOOCdAalCUwBHUGgypr8RB/wGjlqxLdH7+0uGOFEVGuAiQRJZdz5YfzdofgzFOcaK0kIngTW8JHg2gRW2tQdC6ym4YSPqWzsE5+kcA2re7lKACWllRok4LayEGTwd3nOZon9MHst6shPWEG2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5DnVXHp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c1ed19b25fso2507697b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282714; x=1724887514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=Q5DnVXHpqc3Ca2r2NFLlpCuYNwtBDU/lRHSAlSWcbDZpcyJQb7ugJnDUFt9TIEEUOF
         eLpwYVAQ+dNsGQZHC5yD6twY4W0JsXwx24kXQFsa5eReo+2GTfjsNVw4inu50hBuT8l1
         M+dGDhPTGRV9Y8tvfvnGqBwA591qFFRfQL96jIE/6QCa+R4iy2Y3xpEm4KLqtveLNP0X
         VN1klMZy3UWOAGmeRCqLyjkYdny1HrDwsBFdiJNvadqtdGIW0eFAuVdzIrIzLGzShTtv
         n+LT/xLBcsYgzJDZcvPsPjb+uUXPxfp+dVtdjQTGQB9s7W7r9xujhQoX1BYefOj/eGpQ
         dUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282714; x=1724887514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+JBESYi38EleyLEk7wLfDndWDrXHxRbRmO5HxAqZX4=;
        b=q/ZG7dZsccTn2glq3HcsPIfKzYFFBUqJChid+OpDkdV+urk4OVKpxLZSj+9Tx0L5ya
         VPOFdunK6vyA8g0QBP+y29b0g0+/VhDa6c7BmphQoHlK2+G8RqW9U/oMF8gwWfhvyh2H
         2uYdIlt4R5qnn7mFPhw55YV3AV4a9o0TTYgbnO8WNehNe8QVQj7YMdPrIE8vyHV0lS2y
         KZiGnoJprYf97FV2Jp6uTKCsyNoOqapmPl+RyYlfqM38+9MiPCOwDxPg0wtFQHIP4gyx
         G+Ztit/wt2YXtIvV2U+zZkOw09GFgxxDFng8UHTl58uC5RCw/dpuVRssWhL5aJjbLQA3
         CDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwYqCeVt3YFmOBic4xSlaMUQ0jdjI4vYrxMnI3zrvy3wEF3whRZKDIE/w8XkPreRjF2qvK4Fx8HugLvkuN@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1Uv63W/hOM4A774gt1PSbH9KmMh34b9+PGxB8Xxh+fvYo5HL
	0VxYO49vz88Ikf/1Zb4rN9D3VI629Zc1En52gd/H//DO2ltXgIMv
X-Google-Smtp-Source: AGHT+IEmtXQDt3MigRFJZs2cvOMaTfsxNs0BPdApvvwLL2IqHWCZ2oIg1bUZj3yG1K2CiIa5Kfv+8Q==
X-Received: by 2002:a05:690c:4b06:b0:62c:e9f8:8228 with SMTP id 00721157ae682-6c0fb268624mr42255447b3.25.1724282714062;
        Wed, 21 Aug 2024 16:25:14 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dc531a7sm365987b3.126.2024.08.21.16.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 3/9] fuse: update stats for pages in dropped aux writeback list
Date: Wed, 21 Aug 2024 16:22:35 -0700
Message-ID: <20240821232241.3573997-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where the aux writeback list is dropped (eg the pages
have been truncated or the connection is broken), the stats for
its pages and backing device info need to be updated as well.

Fixes: e2653bd53a98 ("fuse: fix leaked aux requests")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 320fa26b23e8..1ae58f93884e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1837,10 +1837,11 @@ __acquires(fi->lock)
 	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
-	/* After fuse_writepage_finish() aux request list is private */
+	/* After rb_erase() aux request list is private */
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
+		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
 		fuse_writepage_free(aux);
 	}
 
-- 
2.43.5


