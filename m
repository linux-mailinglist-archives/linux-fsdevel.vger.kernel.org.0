Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9AD5417
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfJMEIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 00:08:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42492 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfJMEIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 00:08:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so2982067pgi.9;
        Sat, 12 Oct 2019 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9mpX1bbT835ApgtlCBm7T1WS7+wbTgLPpZogSEQonE=;
        b=Q/dseJBnDi82NZ63Ja0ehvJCMufSWASfHKc1Uj/uZsCwEO9iJIu9wV40kSdNHWKih4
         6Bqr+WY4GPEOHlTPifvI61e/tYjzRuqfCGil3hAi6suweb9/sJF7pdEymm9ujwWYGBEi
         3Pja4TIRlN0XOGExJQCYTgQn+g72jGTco5b+XaW9QczLVh2JBM6HkPuH412NyNLKyP7Y
         JYO5UK9b17mW8MFeT13VHahOixfsAM8Dz+Dqr7iMwQ/HoVw+oswhDzNYgB64y+rXAj9S
         i8YEr5Y0xaW84L/woULLHxObjuJUlyDN1eJWGIa+S9ukEUx2qHFJgS9svzkB3Urf2qOa
         xleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9mpX1bbT835ApgtlCBm7T1WS7+wbTgLPpZogSEQonE=;
        b=aveVvE76KDM1nfZKg4/NQeGEvokEE3YzwT2rnF2W+BGb7lPyUJBB2khFBy9nafbAVY
         VZsnR+qh1EP8psd42gpIChkOr0/oH3oNItMxw46OO6FX2Jg78HI8GfV+LSbj5n+JZnZm
         6BbiX9oXMFZKNofy1jr4puuZp4//NdaBZXxWVNfwWb0GtJnXsSicf6KB+xdFjBMZEPCA
         LoYyhTC8s/XxXLKySH2/55mApZSzxycmiue1X2XWE/tF0FUhYVUo1TvJYKuSnJpHZ7QV
         L5/Q3IUR7wQGLwK1PutsLAg7khn/A7EywjQC1iaD40O4Gt5/xYgVKlBXQUiyq/3Gfgf0
         HuwA==
X-Gm-Message-State: APjAAAWLdefe3/4xNm3oRn0/iMTjrFwBgD/1m9ur7nn0bD/IYsJ6yOB2
        IzLccM2uSZHJdXozSP5MiXs=
X-Google-Smtp-Source: APXvYqw36P3qXY4OCM2EqbsWH5VMrC9lRJWvs1Trc72yVwpEpOBRiqQocYUx2xB6KObg7n8x/MiVPQ==
X-Received: by 2002:a63:5605:: with SMTP id k5mr3773333pgb.14.1570939722132;
        Sat, 12 Oct 2019 21:08:42 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id m102sm11320831pje.5.2019.10.12.21.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2019 21:08:41 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id D0074201218; Sun, 13 Oct 2019 13:08:38 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tj@kernel.org, axboe@kernel.dk
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] writeback: Fix a warning while "make xmldocs"
Date:   Sun, 13 Oct 2019 13:08:37 +0900
Message-Id: <20191013040837.14766-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.526.g70bf0b755af4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fix following warning.
./fs/fs-writeback.c:918: warning: Excess function parameter
'nr_pages' description in 'cgroup_writeback_by_id'

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e88421d9a48d..8461a6322039 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -905,7 +905,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
  * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
  * @bdi_id: target bdi id
  * @memcg_id: target memcg css id
- * @nr_pages: number of pages to write, 0 for best-effort dirty flushing
+ * @nr: number of pages to write, 0 for best-effort dirty flushing
  * @reason: reason why some writeback work initiated
  * @done: target wb_completion
  *
-- 
2.23.0.526.g70bf0b755af4

