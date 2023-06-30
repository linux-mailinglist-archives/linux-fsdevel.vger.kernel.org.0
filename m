Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE11D744262
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjF3SgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 14:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjF3SfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:35:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E349FE
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 11:34:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9922d6f003cso265859966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688150094; x=1690742094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVVeDwD7caIzp61kw2BMuZNs7lYHzfuzLdBj/mmv2Ok=;
        b=k5TL6aojVvFuJPOtkITW+dKkpAxlFWvt00ELUMy5b1i0q55juTkWLlOIvTF8hH1cRc
         APPYM6Ps2g9U5wLIG2dgGEJoYyClGjZTP/Z+QJjIkamRVV+2NKpQKhV/P8PawXUXLfBW
         crGiFx6tv/LflatlEEB8q9PbrioNXgCnrX/2tjJBowB6DZAFJ9xBF+hGB3bcXKQEaOCg
         J7K2BLbFBfaNl1IVyPOMvmNzQiJa646BGoHYBt5sUTs7UC4rx+N5PGwUOF5VZjix/65N
         xC7aHNwQcYqAcJtKSxP2byxXsqNErFyt7Fx7APk0u2mFXILiBV1iMQlKmheU1AV4MZDW
         r5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150094; x=1690742094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVVeDwD7caIzp61kw2BMuZNs7lYHzfuzLdBj/mmv2Ok=;
        b=djTtcDByovPFx88Lx0+m8J0Wiv4+gvGiS4Rp7MI3blAbhVNvn+qB7r3xQa2MVbOTGQ
         kESxcZGlWur2JvjAmIKpCz2wWFvc3LQWvbpFhYqSthQWeUCZX0PutZAbbrjibhNG9M9s
         L/7EysVT+5E33dNzhIiWnXs2ELZ63aVsLNFcFajS8s58ZJthsDYqI3TJdrkk5PgP4fnT
         H4+AULCz0Al5fx7W0KlRFkPeqGGFNf2FhhMo3KZ0pN9v+9YWgDtbdxkkIo1ha2IhAQr3
         cSSkdRm47ez1UG8/Xph2gKZQGGFBshFqylLCEmBjKcNHKCUF9g8EFAol6JsayflJlY1Y
         8iCA==
X-Gm-Message-State: ABy/qLZrTtpfqWEKYcsaAQEKdgxRuLjFpskc0tg0y1hNbOZ0Qy5wsJwN
        F3Ty9mghKapmCNP5LzA3+g==
X-Google-Smtp-Source: APBJJlFOdv0xmO+EJX1ZCeIS1VlMiknbb0vo/MAjcnBIuQ0xFvKuXgUanNFf6+uJgym93/F0LC4/Aw==
X-Received: by 2002:a17:906:8148:b0:98d:7818:e51b with SMTP id z8-20020a170906814800b0098d7818e51bmr2567496ejw.27.1688150093977;
        Fri, 30 Jun 2023 11:34:53 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.113])
        by smtp.gmail.com with ESMTPSA id lr3-20020a170906fb8300b00973f1cd586fsm8361827ejb.1.2023.06.30.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:34:53 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, bjorn@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] proc: skip proc-empty-vm on anything but amd64 and i386
Date:   Fri, 30 Jun 2023 21:34:34 +0300
Message-Id: <20230630183434.17434-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630183434.17434-1-adobriyan@gmail.com>
References: <20230630183434.17434-1-adobriyan@gmail.com>
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

This test is arch specific, requires "munmap everything" primitive.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 3aea36c57800..dfbcb3ce2194 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -1,3 +1,4 @@
+#if defined __amd64__ || defined __i386__
 /*
  * Copyright (c) 2022 Alexey Dobriyan <adobriyan@gmail.com>
  *
@@ -402,3 +403,9 @@ int main(void)
 
 	return rv;
 }
+#else
+int main(void)
+{
+	return 4;
+}
+#endif
-- 
2.40.1

