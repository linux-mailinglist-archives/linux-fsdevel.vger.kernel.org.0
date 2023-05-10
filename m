Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02566FE63C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjEJVZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjEJVZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 17:25:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B94690;
        Wed, 10 May 2023 14:25:15 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33131d7a26eso54672155ab.0;
        Wed, 10 May 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683753915; x=1686345915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1zGiFBUQwd8DmaTazeYqSqZn+yy0iXwJ+uL16yshy8=;
        b=GJ4gDeugdEM6KSQzFlyWFcOq/6XSWHxa3/RssNyvHJWYV7gXzZeup/0sMrMUdNhU9w
         5B8Hx/Byrhj7ynlXs2s4NFhdYvy94y9M7oQgALC6srxbCCcNRUq81zj2CLaXyIweHH0n
         t4+OweqlFnhr+rni70A2EC9HpgggqkHesZJ+fhIzJKHQF/srPMbqvO8GTRBTHfvYeO7F
         fnNogvT3hfoq34NTjSFjTBdKhfU8S5DMTf2lmreP7+INz0QivhSujqDVEqTokWYOaSRE
         nmHnVzE/UGfdS72KUtSMaWb6hQH53TnqBvmJf3gz3bMUyT6Ts+n0QOY83WBpqrHVDaq5
         htXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753915; x=1686345915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1zGiFBUQwd8DmaTazeYqSqZn+yy0iXwJ+uL16yshy8=;
        b=Dbcn/wFbt1Q4rS2aM3wTntKu5K5oF+l0+GIkwQ7TtnMy/xskdp5ilazq31JRgKM9qt
         l87NR64550bstcKlDKlG1W9egVrEmUsw40IopPJwUsrL7dpNK8TnNodJY2AgLnK9irSZ
         05ilkR53fKrPd79sC+6QHl+X7BaxDGArc4pqE21rEL4H5Ks60pftQkaGBk0PEWw514/q
         KbGns5DL8prBroHvqUTKbMM3sB/OYZ5GwjPoLr+Yd1jacklLzzs4usRlu7BD6zjQGpHY
         GJl5ieksDlcvTgqKwXDSmughXdS6ooaSN/57Wfain+H8aXc9SkdSf1WExNASGYMN3L+g
         YtYg==
X-Gm-Message-State: AC+VfDy1DcVqD1t5KTOKrcXThQjxDWfuAHyyTKba8bLqm6n8CoWqwl4l
        BYtdFwyzw6Z2ECoczT3j0vj3RZuas7PoOg==
X-Google-Smtp-Source: ACHHUZ5FdO1Vkxe8E+oXdp07QOLbRTgdpz188FE3NH+vOhmCWXU8MKdjXkqVcq7EOhSKyOAqmewa8w==
X-Received: by 2002:a92:90c:0:b0:329:bba2:781a with SMTP id y12-20020a92090c000000b00329bba2781amr13064596ilg.0.1683753914649;
        Wed, 10 May 2023 14:25:14 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id g36-20020a028527000000b004165289bf0csm3740980jai.168.2023.05.10.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:25:14 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] procfs: Replace all non-returning strlcpy with strscpy
Date:   Wed, 10 May 2023 21:24:57 +0000
Message-ID: <20230510212457.3491385-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/proc/kcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25b44b303b35..5d0cf59c4926 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -419,7 +419,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 		char *notes;
 		size_t i = 0;
 
-		strlcpy(prpsinfo.pr_psargs, saved_command_line,
+		strscpy(prpsinfo.pr_psargs, saved_command_line,
 			sizeof(prpsinfo.pr_psargs));
 
 		notes = kzalloc(notes_len, GFP_KERNEL);

