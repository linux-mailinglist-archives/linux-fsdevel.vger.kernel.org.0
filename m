Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808C4E7B75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiCYT12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCYT1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213171E5A59
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 12:00:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bq8so3185807ejb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB37nOdmm3Vf8hmoNRG1nUjJxNB85rDTwpk6HNC+oxQ=;
        b=FQueytGu712rIaAw0tkA0KlebfH7aE3Yg8COrwfM9zA2BUMBUvyzwnTchYL4oG+nlQ
         JSkDv1eGbob3R0ysl1HWx2aebp2L7yhxn34LQJy4Iz6smM+hKFA59UHuHRYovHLYWnb1
         BoMtvrvQlJl+xwnAr0AqAP+XnVcle9Sat5+pYE0nSn5KqGF1mY/dtyhvUogVtfE582Sq
         3XSOfx/mn2+bt6zcQn05N2o3aYwuNmGEaih7USt2CUU+3El9Gpvzt0DbrrAqnbwrDwX8
         yLU5AIvp8x/lyQYi03FqUVkvrzxM70VIKQteDJwsqfPNh6mxDJ7nbkYbkxpW0SdwyaKA
         Nz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lB37nOdmm3Vf8hmoNRG1nUjJxNB85rDTwpk6HNC+oxQ=;
        b=uuYWTxRXFYItu4ZWroiE3g6Km6T/guWKnrfGUpNcURAIXBGvM5OjfV/N4NdevqEmHG
         ia1W6j2P+56qrEXST4lhCQerg/gJUKnlG/bpY4NO4dvd+MiKB9BWpBR5Ls/kPMRqRbv7
         kHXl85N+xfymD5RKC8uz5fztcJ2UvEpBlfJAM2H6PcYYJ0xeLFRYEPAF01Pxk1cMnlBn
         Cht1Ux1JibrFvM1SuNNF4r121eUJeKd3feuEdf4TfHU0AydYQneA5xjH067KZfQS3i8A
         rnRXbNBqB+IkiHCdTMvMwmyfdx8hBz8HOqWi4Uvcp7hKIel+13TH+QbYAkGdBTVGdtdx
         HPIQ==
X-Gm-Message-State: AOAM5300gZU4mYOhyx+ynyBNIreCXsMNobvZzFeai5uMicpNl7GVJhsg
        yLwgqL68U9iS22qm0oTtykfJVFkChHhaZg==
X-Google-Smtp-Source: ABdhPJxbFFe1cTOyOPpCFebBH+QpO/1YhIynnCyaI2JryBJPiu2QLvIAjnvNAUQmJYJwRCIVv+GGVg==
X-Received: by 2002:a17:906:6a1b:b0:6e0:b38b:f74c with SMTP id qw27-20020a1709066a1b00b006e0b38bf74cmr3417142ejc.46.1648234834651;
        Fri, 25 Mar 2022 12:00:34 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm2589844ejr.192.2022.03.25.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:00:33 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Niels Dossche <dossche.niels@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fs/dcache: use lockdep assertion instead of warn try_lock
Date:   Fri, 25 Mar 2022 20:00:02 +0100
Message-Id: <20220325190001.1832-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, there is a fallback with a WARN that uses down_read_trylock
as a safety measure for when there is no lock taken. The current
callsites expect a write lock to be taken. Moreover, the s_root field
is written to, which is not allowed under a read lock.
This code safety fallback should not be executed unless there is an
issue somewhere else.
Using a lockdep assertion better communicates the intent of the code,
and gets rid of the currently slightly wrong fallback solution.

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis as my master's thesis
in order to obtain my master's degree.
If you would like to have more details, please let me know.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. I have both compile-tested this patch and runtime-tested
this patch on x86_64. The effect on a running system could be a
potential race condition in exceptional cases.
This issue was found on Linux v5.17.

Fixes: c636ebdb186bf ("VFS: Destroy the dentries contributed by a superblock on unmounting")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..0142f15340e5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1692,7 +1692,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
 {
 	struct dentry *dentry;
 
-	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
+	lockdep_assert_held_write(&sb->s_umount);
 
 	dentry = sb->s_root;
 	sb->s_root = NULL;
-- 
2.35.1

