Return-Path: <linux-fsdevel+bounces-33953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F99C0EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0811C25DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962F21745F;
	Thu,  7 Nov 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D606zg3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2821733B
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007051; cv=none; b=K8xMu1knQOfhjurfmwZXeDFVOFJxkCzWxwjC2koLc4cgtVAlJqUpx61VyoXwhyiYvpwcYzJ1rZhv2HK+KvRtucUtgTNeP+EHDKRonhD7RqHpUGDHHf6v/YeVIaAMpH4YOVF+yXMSM8EDCf1i/vBzKdDsj4H+nBqdnZkgFnR3R7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007051; c=relaxed/simple;
	bh=0ISNyka0c8g3ggGAopkqyoWrgbOmnfjf6wXkVtDXPS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gukL3t4HeotVEB1cZke3tIkYH9SWAKibwiEQymqSU3LHVxJv5MjLmnV7K/0V9AMEcnPXSNXkXfymbHTimAGWyyYjwBljLisvfELA6ozmyfYG5Ye2IiMtgYpJnemzcyXO41wbRCQSQJ4WBuv1x9WVeBZ+/32qNPhRPmgIe92dBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D606zg3P; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso1290937276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007048; x=1731611848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG5iK0PNmiW0m0S9ll/rGoWwCANqU1Z5kMah1Ao73Dk=;
        b=D606zg3PMNbDqUZ19QIIdo4OL9a9h8zktab9J5Sg2a45kGKeVJtLyL5VRI9vSpI9+K
         9cbh3DIiLXfeJyIAfngV8sBE9BmL/bvM4LbdABIw3JAmESrPKqEM7LEKfRx99UH34o13
         B3XZYwE3pbNhkVoACsxzdaIFnqP/Pzo5bYfmZm1q24sss4herVscMQJTPPAxjPKOnhSX
         dRxMOl97JzdBhY4j7MqTiVlGCBoBBnHtHhzkPiZHuDmYR7c/HbXlKJwZ9w2omxnFra85
         XSzgD3rXFliN92dpuk/3IRRINkZyvHZSotAVR8UOYUMx9eM19cKYjeOACFyJ6lKc9dQn
         s9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007048; x=1731611848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG5iK0PNmiW0m0S9ll/rGoWwCANqU1Z5kMah1Ao73Dk=;
        b=HA7SSXQtdlArnYREHxZmVZGLRo4N8KpYIHoPOrqr6cgBJSaEehUcjSuBNKXZPR2oiC
         qUzfopvfYars61ZJX87p0T82FeklYxKxZ/qtpZB4E/0kRhSwIxq4yYNzw+sIgi3lwQB/
         ISlfexBHkRHUj+2Qm/r6Jajmk3NsMiQZ9v6L/XVAxu7aw463Zo8sRw/lDKZkF8SuCIY3
         iyLKOg9gRTI0gD0mh/VFSqYRKR9N+38T10+bgkIQoa2f0E307OW8Ov3AWMQZ1wlVyg+n
         LMqBRf4Mjk/rpivucNt0XcNUC+NEewvfmZfCoUghmT/SjNINMybuBPT7IER+hDTHH1Yi
         6Nvg==
X-Forwarded-Encrypted: i=1; AJvYcCX633MMxuHDotHkZrgBjR5V4/z72ZDt58ZdRyNIUcueF9G+nGaLoWd0uPYs4/QXqnsw4UFlkrnsCiUJAAvs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xpyTOHoIxqxCLhqf6f6SqsygL04+QkQDf64ywBT1N/g986P6
	s9tL/33aRS1HCqss8FL8ARzRUGnmuOmxU/GpB8yRot4eLMJzJQCg
X-Google-Smtp-Source: AGHT+IFcIlGFpbiDZRAZoKdELB0Ba2H780dbAB8bPQD2I1i+kogNUBV3Xb4R3gifXVFOfN141DB5Gg==
X-Received: by 2002:a05:6902:f84:b0:e29:948:69cc with SMTP id 3f1490d57ef6-e337f844097mr171360276.6.1731007048555;
        Thu, 07 Nov 2024 11:17:28 -0800 (PST)
Received: from localhost (fwdproxy-nha-013.fbsv.net. [2a03:2880:25ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba8e5sm386281276.43.2024.11.07.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:28 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 5/6] mm/migrate: fail MIGRATE_SYNC for folios under writeback with AS_WRITEBACK_MAY_BLOCK mappings
Date: Thu,  7 Nov 2024 11:16:16 -0800
Message-ID: <20241107191618.2011146-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For folios with mappings that have the AS_WRITEBACK_MAY_BLOCK flag set
on it, fail MIGRATE_SYNC mode migration with -EBUSY if the folio is
currently under writeback. If the AS_WRITEBACK_MAY_BLOCK flag is set on
the mapping, the writeback may take an indeterminate amount of time to
complete, so we cannot wait on writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..1d038a4202ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-			break;
+			if (!src->mapping ||
+			    !mapping_writeback_may_block(src->mapping))
+				break;
+			fallthrough;
 		default:
 			rc = -EBUSY;
 			goto out;
-- 
2.43.5


